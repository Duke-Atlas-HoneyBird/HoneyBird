/**
 * Seeds test data for every real user (Firebase Auth + Firestore `users`).
 *
 * Creates/updates per user:
 *   - `users/{uid}` profile doc (if missing fields)
 *   - `preferences/{uid}` with onboarding completed (for testing)
 *   - N deterministic posts authored by that user (profile post history)
 *
 * Also ensures demo restaurants exist.
 *
 * Prerequisites (pick one):
 *   export GOOGLE_APPLICATION_CREDENTIALS=/path/to/serviceAccountKey.json
 *   — or —
 *   gcloud auth application-default login
 *
 * Usage:
 *   cd scripts && npm install && npm run seed:users
 *
 * Options (env):
 *   POSTS_PER_USER=3     Posts to create per user (default 3)
 *   FORCE=1              Re-write seeded posts even if they already exist
 *   DRY_RUN=1            Log actions without writing
 *   ONLY_UID=<uid>       Seed a single user (for debugging)
 */

import admin from 'firebase-admin';

const PROJECT_ID = 'honeybird-ccaf2';
const POSTS_PER_USER = Math.max(1, Number(process.env.POSTS_PER_USER ?? 3));
const DRY_RUN = process.env.DRY_RUN === '1';
const FORCE = process.env.FORCE === '1';
const ONLY_UID = process.env.ONLY_UID?.trim() || '';

const RESTAURANTS = [
  { id: 'rest_cape_grill', name: 'The Cape Grill' },
  { id: 'rest_mediterraneo', name: 'Mediterraneo' },
  { id: 'rest_honey_hive', name: 'Honey Hive Bistro' },
];

const POST_TEMPLATES = [
  {
    text: 'Testing my profile feed — just tried an incredible brunch spot. The eggs benedict was perfect!',
    restaurantId: 'rest_honey_hive',
    restaurantName: 'Honey Hive Bistro',
  },
  {
    text: 'Seed post for QA: sunset dinner with friends. Atmosphere was cozy and the wine list was solid.',
    restaurantId: 'rest_cape_grill',
    restaurantName: 'The Cape Grill',
  },
  {
    text: 'Another test post from the seeder — Mediterranean lunch with fresh seafood and good vibes.',
    restaurantId: 'rest_mediterraneo',
    restaurantName: 'Mediterraneo',
  },
  {
    text: 'Quick seed caption with no restaurant link — useful for text-only post history tests.',
  },
  {
    text: 'Weekend market haul and home cooking experiments. Seeder-generated for profile grid testing.',
  },
];

if (!admin.apps.length) {
  admin.initializeApp({ projectId: PROJECT_ID });
}

const db = admin.firestore();
const auth = admin.auth();

function hoursAgo(h) {
  return new Date(Date.now() - h * 60 * 60 * 1000).toISOString();
}

function displayNameFromAuth(userRecord) {
  if (userRecord.displayName?.trim()) return userRecord.displayName.trim();
  if (userRecord.email) return userRecord.email.split('@')[0];
  return `User ${userRecord.uid.slice(0, 6)}`;
}

async function listAuthUsers() {
  const users = [];
  let pageToken;
  do {
    const result = await auth.listUsers(1000, pageToken);
    users.push(...result.users);
    pageToken = result.pageToken;
  } while (pageToken);
  return users;
}

/**
 * @returns {Promise<Map<string, { uid: string, email: string, userName: string, source: string }>>}
 */
async function collectAllUsers() {
  const byUid = new Map();

  const authUsers = await listAuthUsers();
  for (const record of authUsers) {
    byUid.set(record.uid, {
      uid: record.uid,
      email: record.email ?? '',
      userName: displayNameFromAuth(record),
      source: 'auth',
    });
  }

  const usersSnap = await db.collection('users').get();
  for (const doc of usersSnap.docs) {
    const data = doc.data() ?? {};
    const uid = (data.userUID || doc.id || '').toString();
    if (!uid) continue;

    const existing = byUid.get(uid);
    if (existing) {
      byUid.set(uid, {
        ...existing,
        email: existing.email || data.userEmail || '',
        userName:
          (data.userName && String(data.userName).trim()) || existing.userName,
        source: `${existing.source}+firestore`,
      });
    } else {
      byUid.set(uid, {
        uid,
        email: data.userEmail ?? '',
        userName:
          (data.userName && String(data.userName).trim()) ||
          `User ${uid.slice(0, 6)}`,
        source: 'firestore',
      });
    }
  }

  // Skip legacy / demo seed author IDs — not real login accounts.
  for (const uid of [...byUid.keys()]) {
    if (uid.startsWith('seed_author_')) byUid.delete(uid);
  }

  if (ONLY_UID) {
    const one = byUid.get(ONLY_UID);
    byUid.clear();
    if (one) byUid.set(ONLY_UID, one);
  }

  return byUid;
}

async function ensureRestaurants() {
  for (const r of RESTAURANTS) {
    if (DRY_RUN) {
      console.log(`  [dry-run] restaurants/${r.id}`);
      continue;
    }
    await db.collection('restaurants').doc(r.id).set(
      { id: r.id, name: r.name },
      { merge: true },
    );
  }
  console.log(`Ensured ${RESTAURANTS.length} restaurants`);
}

async function ensureUserProfile(user) {
  const ref = db.collection('users').doc(user.uid);
  const snap = await ref.get();
  const existing = snap.exists ? snap.data() ?? {} : {};

  const payload = {
    id: existing.id || user.uid,
    userUID: user.uid,
    userName: existing.userName || user.userName,
    userEmail: existing.userEmail || user.email || '',
    userBio:
      existing.userBio ||
      'Seeded bio for testing — update me in Account settings.',
    userBioLink: existing.userBioLink || '',
  };

  if (DRY_RUN) {
    console.log(`  [dry-run] users/${user.uid}`);
    return payload;
  }

  await ref.set(payload, { merge: true });
  return payload;
}

async function ensurePreferences(uid) {
  const ref = db.collection('preferences').doc(uid);
  const snap = await ref.get();
  const existing = snap.exists ? snap.data() ?? {} : {};

  const payload = {
    id: uid,
    halaal: existing.halaal ?? false,
    haram: existing.haram ?? false,
    pork: existing.pork ?? false,
    vegan: existing.vegan ?? false,
    vegetarian: existing.vegetarian ?? false,
    lactose: existing.lactose ?? false,
    outdoor: existing.outdoor ?? true,
    wineTasting: existing.wineTasting ?? false,
    wineFarms: existing.wineFarms ?? false,
    african: existing.african ?? true,
    italian: existing.italian ?? true,
    greek: existing.greek ?? true,
    chinese: existing.chinese ?? true,
    thai: existing.thai ?? true,
    showProfileToOthers: existing.showProfileToOthers ?? true,
    showBioToOthers: existing.showBioToOthers ?? true,
    showEmailToOthers: existing.showEmailToOthers ?? false,
    showPreferencesToOthers: existing.showPreferencesToOthers ?? true,
    // Make Account / profile flows easier to test.
    hasCompletedOnboardingThisInstall:
      existing.hasCompletedOnboardingThisInstall ?? true,
  };

  if (DRY_RUN) {
    console.log(`  [dry-run] preferences/${uid}`);
    return;
  }

  await ref.set(payload, { merge: true });
}

function seededPostId(uid, index) {
  // Deterministic IDs so re-runs update instead of duplicating.
  return `seed_user_${uid}_post_${index + 1}`;
}

async function seedPostsForUser(user, profile) {
  let created = 0;
  let skipped = 0;

  for (let i = 0; i < POSTS_PER_USER; i++) {
    const template = POST_TEMPLATES[i % POST_TEMPLATES.length];
    const postId = seededPostId(user.uid, i);
    const ref = db.collection('posts').doc(postId);
    const existing = await ref.get();

    if (existing.exists && !FORCE) {
      skipped += 1;
      continue;
    }

    const payload = {
      id: postId,
      text: template.text,
      imageURL: null,
      imageReferenceID: '',
      videoURL: null,
      videoReferenceID: '',
      publishedDate: hoursAgo(i * 5 + 1),
      likeIDs: [],
      userName: profile.userName || user.userName,
      userUID: user.uid,
      restaurantId: template.restaurantId ?? null,
      restaurantName: template.restaurantName ?? null,
    };

    if (DRY_RUN) {
      console.log(`  [dry-run] posts/${postId}`);
      created += 1;
      continue;
    }

    await ref.set(payload, { merge: true });
    created += 1;
  }

  return { created, skipped };
}

async function main() {
  console.log(`Seeding per-user test data for project ${PROJECT_ID}`);
  console.log(
    `Options: POSTS_PER_USER=${POSTS_PER_USER} FORCE=${FORCE ? 1 : 0} DRY_RUN=${DRY_RUN ? 1 : 0}` +
      (ONLY_UID ? ` ONLY_UID=${ONLY_UID}` : ''),
  );

  await ensureRestaurants();

  const users = await collectAllUsers();
  if (users.size === 0) {
    console.log('No users found in Auth or Firestore. Nothing to seed.');
    return;
  }

  console.log(`Found ${users.size} user(s) to seed.\n`);

  let totalPosts = 0;
  let totalSkipped = 0;

  for (const user of users.values()) {
    console.log(`→ ${user.userName} (${user.uid}) [${user.source}]`);
    const profile = await ensureUserProfile(user);
    await ensurePreferences(user.uid);
    const { created, skipped } = await seedPostsForUser(user, profile);
    totalPosts += created;
    totalSkipped += skipped;
    console.log(`  posts: ${created} written, ${skipped} skipped\n`);
  }

  console.log('Done.');
  console.log(
    `Users: ${users.size} | Posts written: ${totalPosts} | Posts skipped: ${totalSkipped}`,
  );
  if (!FORCE && totalSkipped > 0) {
    console.log('Tip: re-run with FORCE=1 to overwrite existing seeded posts.');
  }
}

main().catch((err) => {
  console.error('Seed failed:', err.message ?? err);
  process.exit(1);
});

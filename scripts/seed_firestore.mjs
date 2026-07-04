/**
 * Seeds Firestore demo data using the Admin SDK (bypasses security rules).
 *
 * Prerequisites (pick one):
 *   export GOOGLE_APPLICATION_CREDENTIALS=/path/to/serviceAccountKey.json
 *   — or —
 *   gcloud auth application-default login
 *
 * Usage:
 *   cd scripts && npm install && npm run seed
 *
 * Re-seed after a version bump:
 *   delete `_meta/seed` in Firestore, or run with FORCE=1
 */

import admin from 'firebase-admin';

const PROJECT_ID = 'honeybird-ccaf2';
const SEED_VERSION = 2;

// Demo post authors — display-only IDs, NOT Firebase Auth UIDs.
const AUTHOR_FOODIE = 'seed_author_foodie';
const AUTHOR_WINE = 'seed_author_wine';
const AUTHOR_ADVENTURE = 'seed_author_adventure';

// Legacy fake Auth UIDs from seed v1 (removed — caused B2C messaging confusion).
const LEGACY_FAKE_UIDS = [
  '4g1nB3dDSFZu953CO4S6FpAjsZq1',
  'O0fLgx3srCb1hFErBxPn1bt3CpB2',
  'Y8z9kL2mP5nR1qT7vX4w3S6A9B0C1',
];

const RESTAURANTS = [
  { id: 'rest_cape_grill', name: 'The Cape Grill' },
  { id: 'rest_mediterraneo', name: 'Mediterraneo' },
  { id: 'rest_honey_hive', name: 'Honey Hive Bistro' },
];

const POST_IDS = [
  'seed_post_1',
  'seed_post_2',
  'seed_post_3',
  'seed_post_4',
  'seed_post_5',
  'seed_post_6',
  'seed_post_7',
  'seed_post_8',
];

if (!admin.apps.length) {
  admin.initializeApp({ projectId: PROJECT_ID });
}

const db = admin.firestore();

function hoursAgo(h) {
  return new Date(Date.now() - h * 60 * 60 * 1000);
}

function daysAgo(d, extraHours = 0) {
  return new Date(Date.now() - (d * 24 + extraHours) * 60 * 60 * 1000);
}

async function needsSeeding() {
  if (process.env.FORCE === '1') return true;
  const doc = await db.doc('_meta/seed').get();
  if (!doc.exists) return true;
  return (doc.data()?.version ?? 0) < SEED_VERSION;
}

async function markSeeded() {
  await db.doc('_meta/seed').set({
    version: SEED_VERSION,
    seededAt: admin.firestore.FieldValue.serverTimestamp(),
  });
}

async function deleteCollectionDocs(collectionPath, batchSize = 100) {
  const collectionRef = db.collection(collectionPath);
  const snapshot = await collectionRef.limit(batchSize).get();
  if (snapshot.empty) return;

  const batch = db.batch();
  snapshot.docs.forEach((doc) => batch.delete(doc.ref));
  await batch.commit();

  if (snapshot.size >= batchSize) {
    await deleteCollectionDocs(collectionPath, batchSize);
  }
}

async function cleanupLegacySeedData() {
  console.log('Cleaning up legacy seed v1 data...');

  for (const uid of LEGACY_FAKE_UIDS) {
    for (const restaurant of RESTAURANTS) {
      const convId = `user_${uid}_restaurant_${restaurant.id}`;
      const convRef = db.collection('conversations').doc(convId);
      const messagesSnap = await convRef.collection('messages').get();
      if (!messagesSnap.empty) {
        const batch = db.batch();
        messagesSnap.docs.forEach((doc) => batch.delete(doc.ref));
        await batch.commit();
      }
      await convRef.delete().catch(() => {});
    }

    await db.collection('users').doc(uid).delete().catch(() => {});
    await db.collection('preferences').doc(uid).delete().catch(() => {});
    await db.collection('favorites').doc(uid).delete().catch(() => {});
  }

  console.log('Legacy cleanup complete.');
}

async function seedRestaurants() {
  for (const r of RESTAURANTS) {
    await db.collection('restaurants').doc(r.id).set({ id: r.id, name: r.name });
  }
  console.log(`Seeded ${RESTAURANTS.length} restaurants`);
}

async function seedPosts() {
  const posts = [
    {
      id: POST_IDS[0],
      text:
        'Just discovered an amazing new restaurant in Cape Town! The food was incredible and the atmosphere was perfect for a date night. Highly recommend trying their signature dish!',
      publishedDate: hoursAgo(2).toISOString(),
      userName: 'FoodieExplorer',
      userUID: AUTHOR_FOODIE,
      likeIDs: ['user1', 'user2', 'user3', 'user4'],
      restaurantId: 'rest_cape_grill',
      restaurantName: 'The Cape Grill',
    },
    {
      id: POST_IDS[1],
      text:
        'Wine tasting at a local vineyard was absolutely breathtaking. The sunset views paired with excellent wines made for an unforgettable experience. Perfect for wine lovers!',
      publishedDate: hoursAgo(5).toISOString(),
      userName: 'WineEnthusiast',
      userUID: AUTHOR_WINE,
      likeIDs: ['user1', 'user2', 'user3', 'user4', 'user5', 'user6'],
    },
    {
      id: POST_IDS[2],
      text:
        'Outdoor adventure at Table Mountain today! The hike was challenging but the views from the top were absolutely worth it. Nature never fails to amaze me.',
      publishedDate: daysAgo(1).toISOString(),
      userName: 'AdventureSeeker',
      userUID: AUTHOR_ADVENTURE,
      likeIDs: ['user1', 'user2', 'user3'],
    },
    {
      id: POST_IDS[3],
      text:
        'Tried authentic Italian cuisine at a hidden gem in the city. The pasta was handmade and the flavors were incredible. A must-visit for Italian food lovers!',
      publishedDate: daysAgo(1, 3).toISOString(),
      userName: 'FoodieExplorer',
      userUID: AUTHOR_FOODIE,
      likeIDs: ['user1', 'user2', 'user3', 'user4', 'user5'],
      restaurantId: 'rest_honey_hive',
      restaurantName: 'Honey Hive Bistro',
    },
    {
      id: POST_IDS[4],
      text:
        'Greek restaurant with amazing Mediterranean flavors! The moussaka was perfect and the atmosphere reminded me of my trip to Greece. Highly recommend!',
      publishedDate: daysAgo(2).toISOString(),
      userName: 'WineEnthusiast',
      userUID: AUTHOR_WINE,
      likeIDs: ['user1', 'user2'],
      restaurantId: 'rest_mediterraneo',
      restaurantName: 'Mediterraneo',
    },
    {
      id: POST_IDS[5],
      text:
        'Chinese dim sum experience was outstanding! The variety of dumplings and the authentic flavors made this one of my best dining experiences this year.',
      publishedDate: daysAgo(2, 5).toISOString(),
      userName: 'AdventureSeeker',
      userUID: AUTHOR_ADVENTURE,
      likeIDs: ['user1', 'user2', 'user3', 'user4'],
    },
    {
      id: POST_IDS[6],
      text:
        'Thai street food market visit was incredible! The pad thai and green curry were authentic and delicious. Great place to explore different flavors!',
      publishedDate: daysAgo(3).toISOString(),
      userName: 'AdventureSeeker',
      userUID: AUTHOR_ADVENTURE,
      likeIDs: ['user1', 'user2', 'user3'],
    },
    {
      id: POST_IDS[7],
      text:
        'African cuisine restaurant with traditional dishes was a cultural experience! The flavors were rich and authentic. Loved learning about the different regional cuisines.',
      publishedDate: daysAgo(4).toISOString(),
      userName: 'FoodieExplorer',
      userUID: AUTHOR_FOODIE,
      likeIDs: ['user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7'],
      restaurantId: 'rest_cape_grill',
      restaurantName: 'The Cape Grill',
    },
  ];

  for (const post of posts) {
    const { id, ...data } = post;
    await db
      .collection('posts')
      .doc(id)
      .set({ id, ...data, imageReferenceID: '', videoReferenceID: '' });
  }
  console.log(`Seeded ${posts.length} posts`);
}

async function seedFirestore() {
  await cleanupLegacySeedData();
  await seedRestaurants();
  await seedPosts();
}

async function main() {
  console.log(`Checking seed status for project ${PROJECT_ID}...`);
  if (!(await needsSeeding())) {
    console.log('Firestore already seeded — nothing to do.');
    console.log('To force re-seed: FORCE=1 npm run seed');
    return;
  }

  console.log(`Seeding Firestore (v${SEED_VERSION})...`);
  await seedFirestore();
  await markSeeded();
  console.log('Firestore seeding completed successfully.');
  console.log(
    'B2C messages use your signed-in Firebase Auth UID — no demo conversation is seeded.',
  );
}

main().catch((err) => {
  console.error('Seed failed:', err.message ?? err);
  process.exit(1);
});

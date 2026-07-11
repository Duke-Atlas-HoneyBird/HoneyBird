# honey_bird

[![.github/workflows/build-on-tag.yml](https://github.com/simbadombo/HoneyBird/actions/workflows/build-on-tag.yml/badge.svg)](https://github.com/simbadombo/HoneyBird/actions/workflows/build-on-tag.yml)

### Install Flutter 
  ```bash
  # Download from: https://flutter.dev/docs/get-started/install
  # Or use package managers:
  
  # macOS (using Homebrew)
  brew install --cask flutter
  
  # Windows (using Chocolatey)
  choco install flutter
  
  # Linux (snap)
  sudo snap install flutter --classic
  ```
### Verify Installation
`flutter doctor -v`

Use the same Flutter version as CI so builds match. CI uses **Flutter 3.41.2** (stable). To match locally:
```bash
flutter upgrade 3.41.2
# or: flutter version 3.41.2
```
Then run `flutter doctor -v` and confirm the version.

### IDE
- install VS Code

### Run project
```bash
# download 
git clone https://github.com/simbadombo/HoneyBird.git

# navigate to project directory
cd ./HoneyBird

# install deps
flutter pub get

# generate freezed / build_runner code (required after clone or when changing @freezed models)
dart run build_runner build -d

# setup Android Emulator / iOS Simulator, then run the app
flutter run
```

### Code generation (Freezed)

Bloc states and events use [Freezed](https://pub.dev/packages/freezed). After cloning—or whenever you change a `@freezed` class—run:

```bash
dart run build_runner build -d
```

Use `dart run build_runner watch -d` while iterating on generated files. See the [build_runner](https://pub.dev/packages/build_runner) docs for more options.

### Firebase config (`firebase_options.dart`)

`lib/firebase_options.dart` (and the native config files below) are **not committed**—they are listed in `.gitignore` so each developer generates their own copy.

| File | Purpose |
|------|---------|
| `lib/firebase_options.dart` | FlutterFire options used by `main.dart` |
| `android/app/google-services.json` | Android Firebase config |
| `ios/Runner/GoogleService-Info.plist` | iOS Firebase config |

**New developers:** you need access to the Firebase project (ask a maintainer to add you in the [Firebase Console](https://console.firebase.google.com/)), then generate the files locally:

1. Install the [Firebase CLI](https://firebase.google.com/docs/cli) and log in (`firebase login`).
2. Install the [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) (`dart pub global activate flutterfire_cli`).
3. From the project root, run **`dart run flutterfire configure`** and select the HoneyBird project and your target platforms.

That command writes all three files above. Do not commit them.

**References**

- [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup) — overview and CLI setup
- [FlutterFire CLI `configure`](https://firebase.google.com/docs/flutter/setup?platform=android#install-cli-tools) — generating `firebase_options.dart`
- [Firebase Console](https://console.firebase.google.com/) — project access and app registration

CI injects these files from GitHub secrets; see [`.github/CI_SECRETS.md`](.github/CI_SECRETS.md) if you maintain the pipeline.

###tri
### Firebase setup

The app reads all data from Firestore. Demo content (restaurants, posts, users, sample B2C conversations) is **not** seeded from the app — security rules block client writes to catalog and seed metadata. Use the Admin SDK script instead.

#### 1. Deploy Firestore rules and indexes

Requires the [Firebase CLI](https://firebase.google.com/docs/cli) and access to project `honeybird-ccaf2`:

```bash
firebase login
firebase deploy --only firestore
```

#### 2. Seed demo data (one-time)

1. Create a service account key in Google Cloud Console (project `honeybird-ccaf2`):

   [Service account → Keys](https://console.cloud.google.com/iam-admin/serviceaccounts/details/104570100048720688475;edit=true/keys?project=honeybird-ccaf2)

   Click **Add key** → **Create new key** → **JSON**, then save the file locally (do not commit it).

2. Run the seed script:

```bash
export GOOGLE_APPLICATION_CREDENTIALS=/path/to/serviceAccountKey.json
cd scripts
npm install
npm run seed
```

Alternatively, if you use Google Cloud application-default credentials with owner access on the project:

```bash
gcloud auth application-default login
cd scripts && npm run seed
```

The script is idempotent: it skips if `_meta/seed` already exists with the current version. To re-seed after a seed version bump (e.g. to remove legacy fake user data):

```bash
FORCE=1 npm run seed
```

Or delete the `_meta/seed` document in Firestore and run again.

**Note:** B2C restaurant messages always use **your signed-in Firebase Auth UID**, not demo post author IDs. Demo posts use `seed_author_*` IDs for display only — they are not login accounts.

#### 3. Run the app

After rules are deployed and seeding completes, start the app as usual:

```bash
flutter run
```

### Release tagging

```bash
VERSION=2.0.18
git commit -m "Bump version to $VERSION" && git push origin develop && git tag v$VERSION -m "Release v$VERSION" && git push origin v$VERSION
```


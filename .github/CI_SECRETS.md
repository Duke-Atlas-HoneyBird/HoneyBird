# CI config files and secrets

The **Build on Tag** workflow needs Firebase/Google config files that are **not in the repo** (they’re in `.gitignore`). Add them as **GitHub Actions secrets** and the workflow will write them during each job.

## Where to add secrets

**Repo** → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**.

---

## Required secrets (all builds)

These are needed for the app to build with Firebase. Add all three.

### 1. `GOOGLE_SERVICES_JSON` (Android)

- **Used by:** Android build job.
- **Steps:**
  1. Firebase Console → Project settings → **General** → your **Android** app → download **google-services.json**.
  2. Open the file and copy the **entire** JSON.
  3. Create a secret named **`GOOGLE_SERVICES_JSON`** and paste the JSON as the value.

### 2. `GOOGLE_SERVICE_INFO_PLIST` (iOS)

- **Used by:** iOS build job.
- **Steps:**
  1. Firebase Console → Project settings → **General** → your **iOS** app → download **GoogleService-Info.plist**.
  2. Open the file and copy the **entire** XML content.
  3. Create a secret named **`GOOGLE_SERVICE_INFO_PLIST`** and paste the XML as the value.

### 3. `FIREBASE_OPTIONS_DART` (Flutter)

- **Used by:** Android, iOS, and Web build jobs.
- **Steps:**
  1. Locally, run **`dart run flutterfire configure`** (or `flutterfire configure`) so that `lib/firebase_options.dart` is generated.
  2. Open **`lib/firebase_options.dart`** and copy the **entire** file content.
  3. Create a secret named **`FIREBASE_OPTIONS_DART`** and paste the Dart code as the value.

If you don’t have the file locally, generate it once with `flutterfire configure`, then copy its contents into the secret.

---

## Optional: Android release signing

To sign release builds in CI with your own keystore, add these secrets and configure Gradle to use them.

### Create the keystore (one-time, on your machine)

```bash
keytool -genkey -v -keystore release.keystore -alias your-key-alias -keyalg RSA -keysize 2048 -validity 10000
```

### Encode the keystore for GitHub

```bash
base64 -i release.keystore | pbcopy   # macOS: copies base64 to clipboard
# Or on Linux: base64 -i release.keystore
```

### Add GitHub secrets

| Secret name               | Value                                      |
|---------------------------|--------------------------------------------|
| `ANDROID_KEYSTORE_BASE64` | Output of `base64 -i release.keystore`     |
| `KEYSTORE_PASSWORD`       | Keystore password                          |
| `KEY_PASSWORD`            | Key password (often same as keystore)      |
| `KEY_ALIAS`               | Alias you used (e.g. `your-key-alias`)     |

If **any** of these are missing, the workflow skips signing setup and uses the default (debug) config.

### Use the keystore in the Android build

The workflow writes `android/key.properties` and `android/app/release.keystore` when the secrets are set. Your `android/app/build.gradle` must read them.

Replace the `buildTypes { release { ... } }` block in `android/app/build.gradle` with:

```groovy
def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ... existing config ...

    signingConfigs {
        release {
            if (keystorePropertiesFile.exists()) {
                keyAlias keystoreProperties['keyAlias']
                keyPassword keystoreProperties['keyPassword']
                storeFile file(keystoreProperties['storeFile'])
                storePassword keystoreProperties['storePassword']
            }
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            // ... rest of release config
        }
    }
}
```

Then release builds in CI will be signed with your keystore when all four secrets are set.

---

## Summary

| Secret | Required | Used by |
|--------|----------|---------|
| `GOOGLE_SERVICES_JSON` | Yes | Android build |
| `GOOGLE_SERVICE_INFO_PLIST` | Yes | iOS build |
| `FIREBASE_OPTIONS_DART` | Yes | Android, iOS, Web builds |
| `ANDROID_KEYSTORE_BASE64` | No | Android release signing |
| `KEYSTORE_PASSWORD` | No | Android release signing |
| `KEY_PASSWORD` | No | Android release signing |
| `KEY_ALIAS` | No | Android release signing |

**Local development:** After cloning, run **`dart run flutterfire configure`** (with Firebase CLI logged in) to generate `lib/firebase_options.dart`, `android/app/google-services.json`, and `ios/GoogleService-Info.plist` locally. Those paths are gitignored, so they stay only on your machine.

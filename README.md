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

## setup a Android Emulators/iOS Simulator 

## the run the app
flutter run

```

###tri

```bash
VERSION=2.0.9
git add . && git commit -m "Bump version to $VERSION" && git push origin develop && git tag v$VERSION -m "Release v$VERSION" && git push origin v$VERSION
```
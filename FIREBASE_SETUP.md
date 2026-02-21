# Firebase Setup Instructions

This document provides instructions for setting up Firebase/Firestore authentication and database for the Honey Bird app.

## Prerequisites

1. Flutter SDK installed
2. Firebase CLI installed (`npm install -g firebase-tools`)
3. A Google account for Firebase Console access

## Firebase Project Setup

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name (e.g., "honey-bird-app")
4. Enable Google Analytics (optional)
5. Create project

### 2. Enable Authentication

1. In Firebase Console, go to "Authentication"
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password" provider
5. Save changes

### 3. Create Firestore Database

1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location close to your users
5. Create database

### 4. Configure Flutter App

#### Install FlutterFire CLI
```bash
dart pub global activate flutterfire_cli
```

#### Configure Firebase for Flutter
```bash
# Run this in your project root
flutterfire configure
```

This will:
- Create/update `firebase_options.dart` with your project configuration
- Configure platform-specific files (iOS, Android, etc.)

#### Update Dependencies
The required Firebase dependencies are already added to `pubspec.yaml`:
```yaml
dependencies:
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.4
  firebase_storage: ^12.3.4
```

Run:
```bash
flutter pub get
```

## Firestore Security Rules

### Development Rules (Test Mode)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2024, 12, 31);
    }
  }
}
```

### Production Rules (Recommended)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only access their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Posts are readable by all authenticated users
    // Posts can only be created/updated by authenticated users
    // Posts can only be deleted by their creator
    match /posts/{postId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && request.auth.uid == resource.data.userUID;
      allow update: if request.auth != null && 
        (request.auth.uid == resource.data.userUID || 
         onlyUpdatingVotes());
      allow delete: if request.auth != null && request.auth.uid == resource.data.userUID;
    }
    
    function onlyUpdatingVotes() {
      return request.resource.data.diff(resource.data).affectedKeys()
        .hasOnly(['upvoteIDs', 'downvoteIDs']);
    }
  }
}
```

## Data Structure

### Users Collection (`/users/{userId}`)
```json
{
  "id": "string",
  "userName": "string",
  "userBio": "string", 
  "userBioLink": "string",
  "userUID": "string",
  "userEmail": "string"
}
```

### Posts Collection (`/posts/{postId}`)
```json
{
  "id": "string",
  "text": "string",
  "imageURL": "string (optional)",
  "imageReferenceID": "string",
  "publishedDate": "timestamp",
  "upvoteIDs": ["string"],
  "downvoteIDs": ["string"],
  "userName": "string",
  "userUID": "string"
}
```

## Testing the Implementation

### 1. Run the App
```bash
flutter run
```

### 2. Test Authentication
- Navigate to the auth screen
- Try signing up with a new email/password
- Try signing in with existing credentials
- Test password reset functionality

### 3. Test Firestore Operations
- Create posts (requires authentication)
- Read posts from Firestore
- Update posts (upvote/downvote)
- Delete posts (only by creator)

## Architecture Overview

The implementation follows Domain-Driven Design (DDD) principles:

### Domain Layer
- `AuthUser` entity - represents authenticated user
- `AuthRepository` interface - defines auth operations
- `PostRepository` interface - defines post operations

### Application Layer  
- `SignInUseCase` - handles sign in logic with validation
- `SignUpUseCase` - handles sign up logic with validation
- `SignOutUseCase` - handles sign out logic

### Infrastructure Layer
- `FirebaseAuthDataSource` - Firebase Auth integration
- `FirebasePostDataSource` - Firestore posts integration
- `AuthRepositoryImpl` - implements auth repository
- `PostRepositoryImpl` - implements post repository

### Presentation Layer
- `AuthBloc` - manages authentication state
- `AuthScreen` - authentication UI
- BLoC pattern for state management

## Environment Configuration

### Development
- Use Firebase test mode for Firestore
- Enable debug logging
- Use emulators for local development (optional)

### Production
- Implement proper security rules
- Enable authentication requirements
- Set up proper error handling and monitoring

## Troubleshooting

### Common Issues

1. **Firebase not initialized**
   - Ensure `Firebase.initializeApp()` is called before `runApp()`
   - Check that `firebase_options.dart` is properly configured

2. **Authentication errors**
   - Verify Email/Password provider is enabled in Firebase Console
   - Check network connectivity
   - Ensure proper error handling in UI

3. **Firestore permission errors**
   - Check security rules in Firebase Console
   - Ensure user is authenticated before accessing Firestore
   - Verify document structure matches security rules

4. **Build errors**
   - Run `flutter clean && flutter pub get`
   - Check that all Firebase dependencies are compatible
   - Ensure platform-specific configuration is complete

## Next Steps

1. Set up Firebase Storage for image uploads
2. Implement push notifications with Firebase Messaging
3. Add analytics with Firebase Analytics
4. Set up crash reporting with Firebase Crashlytics
5. Implement offline support with Firestore caching

## Test User Credentials

For convenience during development, you can use the following test user credentials:

- **Email**: `test@honeybird.com`
- **Password**: `Password123`

You can create this user manually in the Firebase Console or using the Sign Up feature in the app.
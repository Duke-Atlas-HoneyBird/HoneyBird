# HoneyBird UI Implementation Design

## Overview

This design document outlines the technical approach for implementing the HoneyBird mobile application UI. The application follows Clean Architecture principles with Domain-Driven Design (DDD), separating concerns into presentation, application, domain, and infrastructure layers. The UI will be built using Flutter with Material Design 3, featuring a home feed, navigation system, and interactive post components.

The implementation leverages the existing DDD architecture with repositories, use cases, and entities already in place. The focus is on building the presentation layer (screens, widgets, and state management) that connects to the existing domain and application layers.

## Architecture

### Layer Structure

The application follows a four-layer architecture:

1. **Presentation Layer** (`lib/presentation/`)
   - Screens: Full-page UI components
   - Widgets: Reusable UI components
   - State Management: UI state and business logic coordination

2. **Application Layer** (`lib/application/`)
   - Use Cases: Already implemented (GetPosts, UpvotePost, DownvotePost, etc.)
   - Orchestrates domain logic for specific user actions

3. **Domain Layer** (`lib/domain/`)
   - Entities: Post, User (already implemented)
   - Repositories: Interfaces for data access (already implemented)

4. **Infrastructure Layer** (`lib/infrastructure/`)
   - Data Sources: Firebase and local storage implementations (already implemented)
   - Repository Implementations: Concrete implementations (already implemented)

### State Management Approach

For this implementation, we'll use a simple state management solution that fits Flutter's reactive paradigm:

- **StatefulWidget with setState**: For simple, localized state (e.g., selected tab, menu visibility)
- **ValueNotifier/ChangeNotifier**: For shared state across widgets (e.g., post feed data, vote counts)
- **FutureBuilder/StreamBuilder**: For async data loading from use cases

This approach avoids adding additional dependencies while maintaining clean separation of concerns.

## Components and Interfaces

### Screen Components

#### 1. HomeScreen
**Purpose**: Main landing page with search, post feed, and navigation

**Key Responsibilities**:
- Display gradient background
- Render search bar
- Show post feed
- Manage bottom navigation
- Display FAB for post creation
- Handle side menu drawer

**State**:
- Current navigation tab index
- Search query text
- Side menu visibility

**Dependencies**:
- GetPosts use case
- PostFeedWidget
- BottomNavigationWidget
- SearchBarWidget
- SideMenuDrawer

#### 2. PostCreationScreen
**Purpose**: Allow users to create new posts

**Key Responsibilities**:
- Text input for post content
- Image selection (optional)
- Submit post to backend

**Dependencies**:
- CreatePost use case

#### 3. FavoritesScreen
**Purpose**: Display user's favorited posts

**State**: List of favorited posts

#### 4. ProfileScreen
**Purpose**: Display user profile information

**State**: User data

#### 5. MessagesScreen
**Purpose**: Display user messages/conversations

**State**: Message list

#### 6. AccountScreen, ManageScreen, TimelineScreen, FeedScreen
**Purpose**: Additional screens accessible from side menu

### Widget Components

#### 1. PostCard
**Purpose**: Display individual post with interaction controls

**Props**:
- `Post post`: The post entity to display
- `VoidCallback onUpvote`: Callback for upvote action
- `VoidCallback onDownvote`: Callback for downvote action

**Visual Elements**:
- User name and avatar
- Post text content
- Post image (if available)
- Published date
- Upvote button with count
- Downvote button with count

**Styling**:
- Card elevation and rounded corners
- Padding and spacing following Material Design 3
- Color scheme matching app theme

#### 2. PostFeedWidget
**Purpose**: Scrollable list of posts

**Props**:
- `List<Post> posts`: List of posts to display
- `Function(String postId, String userId) onUpvote`: Upvote handler
- `Function(String postId, String userId) onDownvote`: Downvote handler

**Behavior**:
- Vertical scrolling with ListView.builder
- Pull-to-refresh functionality
- Loading indicator while fetching
- Empty state when no posts available

#### 3. SearchBarWidget
**Purpose**: Search input field

**Props**:
- `Function(String query) onSearch`: Search callback
- `String placeholder`: Placeholder text

**Visual Elements**:
- Rounded text field
- Search icon
- Clear button when text is entered

#### 4. BottomNavigationWidget
**Purpose**: Bottom navigation bar with four tabs

**Props**:
- `int currentIndex`: Currently selected tab
- `Function(int index) onTabSelected`: Tab selection callback

**Tabs**:
- Home (icon: home)
- Favorites (icon: favorite)
- Profile (icon: person)
- Messages (icon: message)

#### 5. SideMenuDrawer
**Purpose**: Hamburger menu with additional navigation options

**Props**:
- `Function(String route) onNavigate`: Navigation callback

**Menu Items**:
- Account
- Manage
- Timeline
- Feed

**Behavior**:
- Slides in from right side
- Closes on outside tap or item selection

#### 6. GradientBackground
**Purpose**: Reusable gradient background widget

**Props**:
- `Widget child`: Child widget to display over gradient

**Styling**:
- Linear gradient from purple/blue (#6B4FBB) to dark purple (#2D1B4E)
- Covers full screen

## Data Models

### Existing Domain Entities

#### Post Entity
```dart
class Post {
  final String? id;
  final String text;
  final Uri? imageURL;
  final String imageReferenceID;
  final DateTime publishedDate;
  final List<String> upvoteIDs;
  final List<String> downvoteIDs;
  final String userName;
  final String userUID;
}
```

#### User Entity
```dart
class User {
  final String? id;
  final String userName;
  final String userBio;
  final String userBioLink;
  final String userUID;
  final String userEmail;
}
```

### UI State Models

#### NavigationState
```dart
class NavigationState {
  final int currentTabIndex;
  final bool isMenuOpen;
  
  NavigationState({
    this.currentTabIndex = 0,
    this.isMenuOpen = false,
  });
}
```

#### PostFeedState
```dart
class PostFeedState {
  final List<Post> posts;
  final bool isLoading;
  final String? error;
  
  PostFeedState({
    this.posts = const [],
    this.isLoading = false,
    this.error,
  });
}
```

## Error Handling

### Error Types

1. **Network Errors**: When Firebase operations fail
   - Display user-friendly error message in SnackBar
   - Provide retry option

2. **Validation Errors**: When user input is invalid
   - Show inline validation messages
   - Disable submit button until valid

3. **Loading States**: During async operations
   - Show loading indicators (CircularProgressIndicator)
   - Disable interactive elements during loading

### Error Display Strategy

- **SnackBar**: For transient errors (network failures, operation failures)
- **Dialog**: For critical errors requiring user acknowledgment
- **Inline Messages**: For form validation errors
- **Empty States**: When no data is available with helpful messaging

## Testing Strategy

### Widget Tests

1. **PostCard Widget**
   - Renders post data correctly
   - Upvote button triggers callback
   - Downvote button triggers callback
   - Displays vote counts accurately

2. **PostFeedWidget**
   - Renders list of posts
   - Handles empty state
   - Handles loading state
   - Scrolls correctly

3. **SearchBarWidget**
   - Accepts text input
   - Triggers search callback
   - Displays placeholder text

4. **BottomNavigationWidget**
   - Renders all tabs
   - Highlights current tab
   - Triggers navigation callback

### Integration Tests

1. **Home Screen Flow**
   - Load posts from backend
   - Navigate between tabs
   - Open side menu
   - Tap FAB to create post

2. **Post Interaction Flow**
   - Upvote a post
   - Downvote a post
   - Verify vote counts update
   - Verify persistence to backend

3. **Navigation Flow**
   - Navigate to each screen from bottom nav
   - Navigate to each screen from side menu
   - Verify correct screen displays

### Manual Testing Checklist

- [ ] Gradient background displays correctly
- [ ] Search bar accepts input
- [ ] Post feed scrolls smoothly
- [ ] Posts display all required information
- [ ] Upvote/downvote buttons work
- [ ] Vote counts update in real-time
- [ ] Bottom navigation switches screens
- [ ] FAB navigates to post creation
- [ ] Side menu opens and closes
- [ ] Side menu navigation works
- [ ] App works on different screen sizes
- [ ] Dark mode support (if implemented)

## Theme and Styling

### Color Scheme

**Primary Colors**:
- Primary: `#6B4FBB` (Purple)
- Primary Variant: `#2D1B4E` (Dark Purple)
- Secondary: `#FF6B9D` (Pink accent)
- Background: Gradient from Primary to Primary Variant

**Surface Colors**:
- Card Background: `#FFFFFF` with 90% opacity
- Text Primary: `#000000`
- Text Secondary: `#666666`

**Interactive Colors**:
- Upvote: `#4CAF50` (Green)
- Downvote: `#F44336` (Red)
- Selected Tab: Primary color
- Unselected Tab: `#999999`

### Typography

Using Material Design 3 typography scale:

- **Headline Large**: App title, 32sp, Bold
- **Headline Medium**: Screen titles, 24sp, Semi-bold
- **Body Large**: Post content, 16sp, Regular
- **Body Medium**: Metadata (username, date), 14sp, Regular
- **Label Large**: Button text, 14sp, Medium

### Spacing

Consistent spacing using 8dp grid:
- Extra Small: 4dp
- Small: 8dp
- Medium: 16dp
- Large: 24dp
- Extra Large: 32dp

### Component Styling

**Cards**:
- Elevation: 2dp
- Border Radius: 12dp
- Padding: 16dp

**Buttons**:
- Border Radius: 8dp
- Padding: 12dp horizontal, 8dp vertical
- Elevation: 0dp (flat)

**FAB**:
- Size: 56dp diameter
- Elevation: 6dp
- Icon Size: 24dp

## Implementation Notes

### Dependency Injection

Use existing GetIt service locator (`lib/core/di/injection.dart`) to inject use cases into screens:

```dart
final getPosts = sl<GetPosts>();
final upvotePost = sl<UpvotePost>();
final downvotePost = sl<DownvotePost>();
```

### Navigation

Use Flutter's Navigator 2.0 or simple Navigator.push/pop for screen transitions:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => PostCreationScreen()),
);
```

### Asset Management

Images and icons will be stored in `assets/` directory and referenced in `pubspec.yaml`.

### Performance Considerations

1. **List Optimization**: Use `ListView.builder` for efficient rendering of large post lists
2. **Image Caching**: Use `CachedNetworkImage` package for image loading and caching
3. **Lazy Loading**: Implement pagination for post feed to load posts in batches
4. **State Updates**: Minimize unnecessary rebuilds by using const constructors and proper state management

### Accessibility

1. **Semantic Labels**: Add semantic labels to all interactive elements
2. **Text Scaling**: Support dynamic text sizing
3. **Color Contrast**: Ensure sufficient contrast ratios (WCAG AA standard)
4. **Screen Reader**: Test with TalkBack (Android) and VoiceOver (iOS)

## Dependencies

### Required Packages

Already in `pubspec.yaml`:
- `flutter`: SDK
- `firebase_core`: Firebase initialization
- `cloud_firestore`: Firestore database
- `get_it`: Dependency injection
- `equatable`: Value equality
- `dartz`: Functional programming (Either type)

### Additional Packages to Consider

- `cached_network_image`: For efficient image loading and caching
- `intl`: For date formatting
- `flutter_svg`: If using SVG icons

## Migration Path

Since the domain, application, and infrastructure layers are already implemented, the migration focuses on the presentation layer:

1. **Phase 1**: Create theme and styling constants
2. **Phase 2**: Build reusable widget components (PostCard, SearchBar, etc.)
3. **Phase 3**: Implement HomeScreen with post feed
4. **Phase 4**: Add navigation system (bottom nav, side menu)
5. **Phase 5**: Implement remaining screens (Favorites, Profile, Messages, etc.)
6. **Phase 6**: Add post creation functionality
7. **Phase 7**: Polish and testing

Each phase builds incrementally on the previous, allowing for iterative development and testing.

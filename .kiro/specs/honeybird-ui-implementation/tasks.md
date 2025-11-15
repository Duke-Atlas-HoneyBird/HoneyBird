# Implementation Plan

- [ ] 1. Set up theme and styling foundation
  - Create `lib/presentation/theme/app_theme.dart` with Material Design 3 theme configuration
  - Define color scheme with gradient colors (#6B4FBB, #2D1B4E, accent colors)
  - Define typography scale (headline, body, label styles)
  - Define spacing constants (4dp, 8dp, 16dp, 24dp, 32dp)
  - _Requirements: 6.1, 6.2, 6.3, 6.4_

- [ ] 2. Create core reusable widgets
- [ ] 2.1 Implement GradientBackground widget
  - Create `lib/presentation/widgets/gradient_background.dart`
  - Implement LinearGradient from purple/blue to dark purple
  - Accept child widget parameter
  - _Requirements: 1.1, 1.5_

- [ ] 2.2 Implement SearchBarWidget
  - Create `lib/presentation/widgets/search_bar_widget.dart`
  - Add TextField with "HoneyBird Search..." placeholder
  - Add search icon and clear button
  - Implement onSearch callback
  - Apply rounded border styling
  - _Requirements: 1.2, 1.4_

- [ ] 2.3 Implement PostCard widget
  - Create `lib/presentation/widgets/post_card.dart`
  - Display post text, username, published date
  - Display post image if imageURL is not null
  - Add upvote button with count display
  - Add downvote button with count display
  - Implement onUpvote and onDownvote callbacks
  - Apply card styling (elevation, border radius, padding)
  - Format date using intl package
  - _Requirements: 2.3, 2.4, 2.5, 2.6, 2.7, 7.1, 7.2, 7.3_

- [ ] 2.4 Implement BottomNavigationWidget
  - Create `lib/presentation/widgets/bottom_navigation_widget.dart`
  - Add four navigation items: Home, Favorites, Profile, Messages
  - Add appropriate icons for each item
  - Implement currentIndex highlighting
  - Implement onTabSelected callback
  - _Requirements: 3.1, 3.2, 3.3, 3.5_

- [ ] 2.5 Implement SideMenuDrawer
  - Create `lib/presentation/widgets/side_menu_drawer.dart`
  - Add menu items: Account, Manage, Timeline, Feed
  - Implement slide-in animation from right
  - Implement onNavigate callback for menu items
  - Add close on outside tap behavior
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [ ] 3. Implement PostFeedWidget with state management
  - Create `lib/presentation/widgets/post_feed_widget.dart`
  - Use ListView.builder for efficient rendering
  - Implement FutureBuilder to load posts using GetPosts use case
  - Display loading indicator while fetching posts
  - Display empty state when no posts available
  - Handle error state with user-friendly message
  - Pass upvote/downvote callbacks to PostCard widgets
  - Ensure feed occupies ~50% of screen height
  - _Requirements: 2.1, 2.2, 2.3, 2.8_

- [ ] 4. Implement HomeScreen
- [ ] 4.1 Create HomeScreen structure
  - Create `lib/presentation/screens/home_screen.dart`
  - Wrap screen with GradientBackground widget
  - Add Scaffold with transparent background
  - Position SearchBarWidget near top
  - Add hamburger menu icon in top-right corner
  - Position PostFeedWidget in center area
  - Add BottomNavigationWidget at bottom
  - Add FAB in bottom-right with message icon
  - _Requirements: 1.1, 1.2, 1.3, 2.1, 3.1, 4.1, 4.5_

- [ ] 4.2 Implement HomeScreen state management
  - Add StatefulWidget with state for current tab index
  - Add state for side menu visibility
  - Inject GetPosts, UpvotePost, DownvotePost use cases via GetIt
  - Implement upvote handler that calls UpvotePost use case
  - Implement downvote handler that calls DownvotePost use case
  - Handle success/error responses with SnackBar
  - Update post list after vote operations
  - _Requirements: 7.4, 7.5, 7.6_

- [ ] 4.3 Wire up navigation and interactions
  - Connect hamburger icon to open SideMenuDrawer
  - Connect FAB to navigate to PostCreationScreen
  - Connect BottomNavigationWidget to switch between screens
  - Implement tab switching logic
  - _Requirements: 3.4, 4.3, 5.1_

- [ ] 5. Implement placeholder screens for navigation
- [ ] 5.1 Create FavoritesScreen
  - Create `lib/presentation/screens/favorites_screen.dart`
  - Add Scaffold with GradientBackground
  - Display "Favorites" title
  - Add placeholder content
  - _Requirements: 3.4_

- [ ] 5.2 Create ProfileScreen
  - Create `lib/presentation/screens/profile_screen.dart`
  - Add Scaffold with GradientBackground
  - Display "Profile" title
  - Add placeholder content
  - _Requirements: 3.4_

- [ ] 5.3 Create MessagesScreen
  - Create `lib/presentation/screens/messages_screen.dart`
  - Add Scaffold with GradientBackground
  - Display "Messages" title
  - Add placeholder content
  - _Requirements: 3.4_

- [ ] 5.4 Create side menu screens
  - Create `lib/presentation/screens/account_screen.dart`
  - Create `lib/presentation/screens/manage_screen.dart`
  - Create `lib/presentation/screens/timeline_screen.dart`
  - Create `lib/presentation/screens/feed_screen.dart`
  - Each with Scaffold, GradientBackground, and placeholder content
  - _Requirements: 5.3, 5.4_

- [ ] 6. Implement PostCreationScreen
- [ ] 6.1 Create PostCreationScreen UI
  - Create `lib/presentation/screens/post_creation_screen.dart`
  - Add Scaffold with GradientBackground
  - Add TextField for post text input (multiline)
  - Add image picker button (optional)
  - Add submit button
  - Add cancel/back button
  - _Requirements: 4.3_

- [ ] 6.2 Implement post creation logic
  - Inject CreatePost use case via GetIt
  - Implement form validation (text not empty)
  - Create Post entity from form data
  - Call CreatePost use case on submit
  - Handle success: show SnackBar and navigate back
  - Handle error: show error message
  - Disable submit button during loading
  - _Requirements: 4.3_

- [ ] 7. Update main.dart and wire everything together
  - Update `lib/main.dart` to use custom theme from app_theme.dart
  - Set HomeScreen as the initial route
  - Configure MaterialApp with theme and routes
  - Ensure Firebase and DI are initialized before app starts
  - Remove demo counter code
  - _Requirements: 6.1, 6.5_

- [ ] 8. Add error handling and loading states
  - Implement SnackBar utility for displaying errors
  - Add CircularProgressIndicator for loading states
  - Add error retry functionality in PostFeedWidget
  - Implement empty state UI for PostFeedWidget
  - Add form validation messages in PostCreationScreen
  - _Requirements: 2.1, 2.2, 2.3_

- [ ] 9. Polish and refinements
  - Add pull-to-refresh to PostFeedWidget
  - Implement smooth scroll behavior
  - Add haptic feedback to buttons
  - Ensure FAB stays above BottomNav (z-index)
  - Test on different screen sizes
  - Verify gradient displays correctly
  - Ensure all interactive elements have proper touch targets (48dp minimum)
  - _Requirements: 2.8, 3.6, 4.4_

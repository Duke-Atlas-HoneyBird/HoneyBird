# Implementation Plan

- [x] 1. Set up project dependencies and folder structure
  - Add all required packages to pubspec.yaml (dartz, equatable, firebase, get_it, shared_preferences, uuid)
  - Create the complete DDD folder structure (core, domain, application, infrastructure, presentation)
  - Initialize Firebase in the project
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 10.1, 10.2, 10.3, 10.4, 10.5_

- [x] 2. Implement core layer foundation
  - [x] 2.1 Create base Failure classes
    - Write abstract Failure class with message property
    - Implement ServerFailure, CacheFailure, ValidationFailure, and NetworkFailure classes
    - Ensure all failures extend Equatable for comparison
    - _Requirements: 7.4_

  - [x] 2.2 Set up dependency injection container
    - Create injection.dart file with GetIt configuration
    - Define init() function structure for registering dependencies
    - _Requirements: 9.1, 9.4, 9.5_

  - [x] 2.3 Create shared constants and utilities
    - Define Firebase collection names as constants
    - Create any shared utility functions needed across layers
    - _Requirements: 1.5_

- [x] 3. Implement domain layer entities and value objects
  - [x] 3.1 Create User entity
    - Write User class with all properties (id, userName, userBio, userBioLink, userUID, userEmail)
    - Implement Equatable for value equality
    - Ensure immutability with const constructor
    - _Requirements: 2.1, 2.2, 2.4_

  - [x] 3.2 Create Post entity
    - Write Post class with all properties (id, text, imageURL, imageReferenceID, publishedDate, upvoteIDs, downvoteIDs, userName, userUID)
    - Implement Equatable and ensure proper equality comparison
    - Use Uri type for imageURL and DateTime for publishedDate
    - _Requirements: 3.1, 3.2, 3.4_

  - [x] 3.3 Create UserPreference entity
    - Write UserPreference class with all dietary and experience preference properties
    - Implement copyWith method for creating modified instances
    - Set appropriate default values matching Swift implementation
    - _Requirements: 4.1, 4.2, 4.5_

  - [x] 3.4 Create SideMenuTab value object
    - Write SideMenuTab enum with all navigation options (home, store, notifications, profile, settings)
    - Add displayName property to each enum value
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

  - [x] 3.5 Create DropTask entity and DropStatus enum
    - Write DropStatus enum with todo, working, and completed values
    - Write DropTask class with id, title, and status properties
    - Implement Equatable for comparison
    - _Requirements: 6.1, 6.2, 6.3, 6.4_

- [x] 4. Implement domain layer repository interfaces
  - [x] 4.1 Create UserRepository interface
    - Define abstract class with methods for getUser, createUser, updateUser, deleteUser
    - Use Either<Failure, T> return types for all methods
    - Ensure methods accept and return User entities
    - _Requirements: 2.5, 7.1, 7.2, 7.3, 7.5_

  - [x] 4.2 Create PostRepository interface
    - Define abstract class with methods for getPosts, getPost, createPost, updatePost, deletePost, upvotePost, downvotePost
    - Use Either<Failure, T> return types for all methods
    - Ensure methods accept and return Post entities
    - _Requirements: 3.5, 7.1, 7.2, 7.3, 7.5_

  - [x] 4.3 Create UserPreferenceRepository interface
    - Define abstract class with methods for getPreferences and savePreferences
    - Use Either<Failure, T> return types for all methods
    - Ensure methods accept and return UserPreference entities
    - _Requirements: 4.4, 7.1, 7.2, 7.3, 7.5_

  - [x] 4.4 Create TaskRepository interface
    - Define abstract class with methods for getTasks, createTask, updateTask, deleteTask
    - Use Either<Failure, T> return types for all methods
    - Ensure methods accept and return DropTask entities
    - _Requirements: 6.5, 7.1, 7.2, 7.3, 7.5_

- [x] 5. Implement infrastructure layer models
  - [x] 5.1 Create UserModel with serialization
    - Write UserModel class extending User entity
    - Implement fromJson factory constructor for Firestore deserialization
    - Implement toJson method for Firestore serialization
    - Add fromEntity factory constructor for domain-to-infrastructure conversion
    - _Requirements: 2.3_

  - [x] 5.2 Create PostModel with serialization
    - Write PostModel class extending Post entity
    - Implement fromJson with proper type conversions (String to Uri, Timestamp to DateTime)
    - Implement toJson with proper type conversions (Uri to String, DateTime to Timestamp)
    - Add fromEntity factory constructor
    - _Requirements: 3.3_

  - [x] 5.3 Create UserPreferenceModel with serialization
    - Write UserPreferenceModel class extending UserPreference entity
    - Implement fromJson for local storage deserialization
    - Implement toJson for local storage serialization
    - Add fromEntity factory constructor
    - _Requirements: 4.3_

  - [x] 5.4 Create DropTaskModel with serialization
    - Write DropTaskModel class extending DropTask entity
    - Implement fromJson with enum conversion for DropStatus
    - Implement toJson with enum conversion
    - Add fromEntity factory constructor
    - _Requirements: 6.1, 6.2_

- [x] 6. Implement infrastructure layer data sources
  - [x] 6.1 Create FirebaseUserDataSource
    - Define abstract FirebaseUserDataSource interface
    - Implement FirebaseUserDataSourceImpl with FirebaseFirestore dependency
    - Write getUser method querying Firestore users collection
    - Write createUser method adding document to Firestore
    - Write updateUser method updating Firestore document
    - Write deleteUser method removing Firestore document
    - Handle exceptions and throw appropriate ServerException
    - _Requirements: 8.2_

  - [x] 6.2 Create FirebasePostDataSource
    - Define abstract FirebasePostDataSource interface
    - Implement FirebasePostDataSourceImpl with FirebaseFirestore dependency
    - Write getPosts method querying all posts from Firestore
    - Write getPost method querying single post by ID
    - Write createPost method adding post document
    - Write updatePost method updating post document
    - Write deletePost method removing post document
    - Implement upvotePost and downvotePost methods updating vote arrays
    - _Requirements: 8.2_

  - [x] 6.3 Create LocalPreferenceDataSource
    - Define abstract LocalPreferenceDataSource interface
    - Implement LocalPreferenceDataSourceImpl with SharedPreferences dependency
    - Write getPreferences method reading from local storage
    - Write savePreferences method writing to local storage
    - Handle missing data scenarios
    - _Requirements: 8.3_

  - [x] 6.4 Create LocalTaskDataSource
    - Define abstract LocalTaskDataSource interface
    - Implement LocalTaskDataSourceImpl with SharedPreferences dependency
    - Write getTasks method reading task list from local storage
    - Write createTask method adding task to local storage
    - Write updateTask method modifying existing task
    - Write deleteTask method removing task from local storage
    - _Requirements: 8.3_

- [x] 7. Implement infrastructure layer repository implementations
  - [x] 7.1 Create UserRepositoryImpl
    - Implement UserRepository interface
    - Inject FirebaseUserDataSource dependency
    - Implement getUser with try-catch converting exceptions to ServerFailure
    - Implement createUser with error handling
    - Implement updateUser with error handling
    - Implement deleteUser with error handling
    - Ensure all methods return Either<Failure, T>
    - _Requirements: 8.1, 8.4, 8.5_

  - [x] 7.2 Create PostRepositoryImpl
    - Implement PostRepository interface
    - Inject FirebasePostDataSource dependency
    - Implement all CRUD methods (getPosts, getPost, createPost, updatePost, deletePost)
    - Implement upvotePost and downvotePost with error handling
    - Convert all exceptions to appropriate Failures
    - Convert PostModel to Post entity in return values
    - _Requirements: 8.1, 8.4, 8.5_

  - [x] 7.3 Create UserPreferenceRepositoryImpl
    - Implement UserPreferenceRepository interface
    - Inject LocalPreferenceDataSource dependency
    - Implement getPreferences with error handling converting to CacheFailure
    - Implement savePreferences with error handling
    - Convert models to entities appropriately
    - _Requirements: 8.1, 8.4, 8.5_

  - [x] 7.4 Create TaskRepositoryImpl
    - Implement TaskRepository interface
    - Inject LocalTaskDataSource dependency
    - Implement all CRUD methods with error handling
    - Convert exceptions to CacheFailure
    - Convert models to entities in return values
    - _Requirements: 8.1, 8.4, 8.5_

- [x] 8. Implement application layer use cases
  - [x] 8.1 Create user-related use cases
    - Implement GetUser use case with UserRepository dependency
    - Implement CreateUser use case
    - Implement UpdateUser use case
    - Implement DeleteUser use case
    - Each use case should have a call method that delegates to repository
    - _Requirements: 7.3, 7.5_

  - [x] 8.2 Create post-related use cases
    - Implement GetPosts use case with PostRepository dependency
    - Implement GetPost use case
    - Implement CreatePost use case
    - Implement UpdatePost use case
    - Implement DeletePost use case
    - Implement UpvotePost use case
    - Implement DownvotePost use case
    - _Requirements: 7.3, 7.5_

  - [x] 8.3 Create preference-related use cases
    - Implement GetPreferences use case with UserPreferenceRepository dependency
    - Implement SavePreferences use case
    - _Requirements: 7.3, 7.5_

  - [x] 8.4 Create task-related use cases
    - Implement GetTasks use case with TaskRepository dependency
    - Implement CreateTask use case
    - Implement UpdateTask use case
    - Implement DeleteTask use case
    - _Requirements: 7.3, 7.5_

- [x] 9. Wire up dependency injection
  - [x] 9.1 Register external dependencies
    - Register FirebaseFirestore instance as lazy singleton
    - Register SharedPreferences instance as lazy singleton
    - _Requirements: 9.1_

  - [x] 9.2 Register data sources
    - Register FirebaseUserDataSource implementation as lazy singleton
    - Register FirebasePostDataSource implementation as lazy singleton
    - Register LocalPreferenceDataSource implementation as lazy singleton
    - Register LocalTaskDataSource implementation as lazy singleton
    - _Requirements: 9.5_

  - [x] 9.3 Register repositories
    - Register UserRepository implementation as lazy singleton bound to interface
    - Register PostRepository implementation as lazy singleton bound to interface
    - Register UserPreferenceRepository implementation as lazy singleton bound to interface
    - Register TaskRepository implementation as lazy singleton bound to interface
    - _Requirements: 9.2, 9.5_

  - [x] 9.4 Register use cases
    - Register all user-related use cases as factories
    - Register all post-related use cases as factories
    - Register all preference-related use cases as factories
    - Register all task-related use cases as factories
    - _Requirements: 9.3, 9.5_

  - [x] 9.5 Initialize dependency injection in main
    - Call dependency injection init() function in main() before runApp()
    - Ensure Firebase is initialized before dependency injection setup
    - _Requirements: 9.4_

- [ ]* 10. Create unit tests for domain layer
  - Write tests for User entity equality and immutability
  - Write tests for Post entity equality and immutability
  - Write tests for UserPreference entity and copyWith method
  - Write tests for DropTask entity equality
  - _Requirements: 2.2, 3.2, 4.2, 6.3_

- [ ]* 11. Create unit tests for use cases
  - Write tests for user use cases with mock UserRepository
  - Write tests for post use cases with mock PostRepository
  - Write tests for preference use cases with mock UserPreferenceRepository
  - Write tests for task use cases with mock TaskRepository
  - Verify correct repository method calls and error handling
  - _Requirements: 7.3, 7.5_

- [ ]* 12. Create unit tests for repository implementations
  - Write tests for UserRepositoryImpl with mock data source
  - Write tests for PostRepositoryImpl with mock data source
  - Write tests for UserPreferenceRepositoryImpl with mock data source
  - Write tests for TaskRepositoryImpl with mock data source
  - Verify error conversion from exceptions to Failures
  - Verify model-to-entity conversion
  - _Requirements: 8.4, 8.5_

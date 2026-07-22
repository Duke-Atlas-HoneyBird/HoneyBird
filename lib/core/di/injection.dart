import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../infrastructure/data_sources/firebase_auth_data_source.dart';
import '../../infrastructure/data_sources/firebase_comment_data_source.dart';
import '../../infrastructure/data_sources/firebase_post_data_source.dart';
import '../../infrastructure/data_sources/firebase_storage_data_source.dart';
import '../../infrastructure/data_sources/firebase_user_data_source.dart';
import '../../infrastructure/data_sources/firebase_favorite_data_source.dart';
import '../../infrastructure/data_sources/firebase_task_data_source.dart';
import '../../infrastructure/data_sources/firebase_preference_data_source.dart';
import '../../infrastructure/data_sources/firebase_message_data_source.dart';
import '../../infrastructure/data_sources/firebase_restaurant_data_source.dart';
import '../../infrastructure/data_sources/firebase_block_data_source.dart';
import '../../infrastructure/data_sources/local_preference_data_source.dart';
import '../../infrastructure/data_sources/local_task_data_source.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';
import '../../infrastructure/repositories/comment_repository_impl.dart';
import '../../infrastructure/repositories/post_repository_impl.dart';
import '../../infrastructure/repositories/task_repository_impl.dart';
import '../../infrastructure/repositories/user_preference_repository_impl.dart';
import '../../infrastructure/repositories/user_repository_impl.dart';
import '../../infrastructure/repositories/message_repository_impl.dart';
import '../../infrastructure/repositories/restaurant_repository_impl.dart';
import '../../infrastructure/repositories/favorite_repository_impl.dart';
import '../../infrastructure/repositories/block_repository_impl.dart';
import '../../infrastructure/repositories/storage_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/comment_repository.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/repositories/user_preference_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/message_repository.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../domain/repositories/storage_repository.dart';
import '../../domain/repositories/block_repository.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../../application/use_cases/auth/sign_in_use_case.dart';
import '../../application/use_cases/auth/sign_up_use_case.dart';
import '../../application/use_cases/auth/sign_out_use_case.dart';
import '../../application/use_cases/user/create_user.dart';
import '../../application/use_cases/user/delete_user.dart';
import '../../application/use_cases/user/get_user.dart';
import '../../application/use_cases/user/update_user.dart';
import '../../application/use_cases/comment/create_comment.dart';
import '../../application/use_cases/comment/get_comments_for_post.dart';
import '../../application/use_cases/post/create_post.dart';
import '../../application/use_cases/post/delete_post.dart';
import '../../application/use_cases/post/get_post.dart';
import '../../application/use_cases/post/get_posts.dart';
import '../../application/use_cases/post/get_posts_by_user_uid.dart';
import '../../application/use_cases/post/like_post.dart';
import '../../application/use_cases/post/update_post.dart';
import '../../application/use_cases/preferences/get_preferences.dart';
import '../../application/use_cases/preferences/save_preferences.dart';
import '../../application/use_cases/tasks/create_task.dart';
import '../../application/use_cases/tasks/delete_task.dart';
import '../../application/use_cases/tasks/get_tasks.dart';
import '../../application/use_cases/tasks/update_task.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/comment/comment_bloc.dart';
import '../../presentation/bloc/comment_count/comment_count_bloc.dart';
import '../../presentation/bloc/post/post_bloc.dart';
import '../../presentation/bloc/manage/manage_bloc.dart';
import '../../presentation/bloc/account/account_bloc.dart';
import '../../presentation/bloc/messages/messages_bloc.dart';
import '../../presentation/bloc/profile/profile_bloc.dart';
import '../../presentation/router/onboarding_session.dart';

final sl = GetIt.instance;

/// Initialize dependency injection
Future<void> init() async {
  // External dependencies
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<OnboardingSession>(
    () => OnboardingSession(sharedPreferences),
  );
  
  // Firebase data sources
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(firebaseAuth: sl()),
  );
  sl.registerLazySingleton<FirebaseCommentDataSource>(
    () => FirebaseCommentDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebasePostDataSource>(
    () => FirebasePostDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebaseStorageDataSource>(
    () => FirebaseStorageDataSourceImpl(storage: FirebaseStorage.instance),
  );
  sl.registerLazySingleton<FirebaseUserDataSource>(
    () => FirebaseUserDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebaseFavoriteDataSource>(
    () => FirebaseFavoriteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebaseTaskDataSource>(
    () => FirebaseTaskDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebasePreferenceDataSource>(
    () => FirebasePreferenceDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebaseMessageDataSource>(
    () => FirebaseMessageDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebaseRestaurantDataSource>(
    () => FirebaseRestaurantDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebaseBlockDataSource>(
    () => FirebaseBlockDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton<LocalPreferenceDataSource>(
    () => LocalPreferenceDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<LocalTaskDataSource>(
    () => LocalTaskDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );
  
  // Repositories - using Firebase data sources
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: sl(),
      userRepository: sl(),
      preferenceRepository: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(firebaseDataSource: sl()),
  );
  sl.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(firebaseDataSource: sl()),
  );
  sl.registerLazySingleton<UserPreferenceRepository>(
    () => UserPreferenceRepositoryImpl(dataSource: sl<FirebasePreferenceDataSource>()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(dataSource: sl<FirebaseTaskDataSource>()),
  );
  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(dataSource: sl<FirebaseMessageDataSource>()),
  );
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(dataSource: sl<FirebaseRestaurantDataSource>()),
  );
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(firebaseDataSource: sl()),
  );
  sl.registerLazySingleton<StorageRepository>(
    () => StorageRepositoryImpl(dataSource: sl<FirebaseStorageDataSource>()),
  );
  sl.registerLazySingleton<BlockRepository>(
    () => BlockRepositoryImpl(dataSource: sl<FirebaseBlockDataSource>()),
  );

  // Use cases - Auth
  sl.registerFactory(() => SignInUseCase(authRepository: sl()));
  sl.registerFactory(() => SignUpUseCase(authRepository: sl()));
  sl.registerFactory(() => SignOutUseCase(authRepository: sl()));
  
  // Use cases - User
  sl.registerFactory(() => GetUser(sl()));
  sl.registerFactory(() => CreateUser(sl()));
  sl.registerFactory(() => UpdateUser(sl()));
  sl.registerFactory(() => DeleteUser(sl()));
  
  // Use cases - Comment
  sl.registerFactory(() => GetCommentsForPost(sl()));
  sl.registerFactory(() => CreateComment(sl()));

  // Use cases - Post
  sl.registerFactory(() => GetPosts(sl()));
  sl.registerFactory(() => GetPostsByUserUID(sl()));
  sl.registerFactory(() => GetPost(sl()));
  sl.registerFactory(() => CreatePost(sl()));
  sl.registerFactory(() => UpdatePost(sl()));
  sl.registerFactory(() => DeletePost(sl()));
  sl.registerFactory(() => LikePost(sl()));
  
  // Use cases - Preferences
  sl.registerFactory(() => GetPreferences(sl()));
  sl.registerFactory(() => SavePreferences(sl()));
  
  // Use cases - Tasks
  sl.registerFactory(() => GetTasks(sl()));
  sl.registerFactory(() => CreateTask(sl()));
  sl.registerFactory(() => UpdateTask(sl()));
  sl.registerFactory(() => DeleteTask(sl()));
  
  // BLoCs
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => CommentBloc(
        commentRepository: sl(),
      ));
  sl.registerFactory(() => CommentCountBloc(
        commentRepository: sl(),
      ));
  sl.registerFactory(() => PostBloc(
        postRepository: sl(),
        authRepository: sl(),
        storageRepository: sl(),
      ));
  sl.registerFactory(() => ManageBloc(
        getTasks: sl(),
        createTask: sl(),
        updateTask: sl(),
        deleteTask: sl(),
      ));
  sl.registerFactory(() => AccountBloc(
        userRepository: sl(),
        preferenceRepository: sl(),
        postRepository: sl(),
        favoriteRepository: sl(),
        sharedPreferences: sl(),
      ));
  sl.registerFactory(() => MessagesBloc(
        messageRepository: sl(),
        restaurantRepository: sl(),
      ));
  sl.registerFactory(() => ProfileBloc(
        userRepository: sl(),
        preferenceRepository: sl(),
        blockRepository: sl(),
        postRepository: sl(),
        favoriteRepository: sl(),
      ));
}

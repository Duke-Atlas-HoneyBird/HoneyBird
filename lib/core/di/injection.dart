import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infrastructure/data_sources/firebase_post_data_source.dart';
import '../../infrastructure/data_sources/firebase_user_data_source.dart';
import '../../infrastructure/data_sources/local_preference_data_source.dart';
import '../../infrastructure/data_sources/local_task_data_source.dart';
import '../../infrastructure/repositories/post_repository_impl.dart';
import '../../infrastructure/repositories/task_repository_impl.dart';
import '../../infrastructure/repositories/user_preference_repository_impl.dart';
import '../../infrastructure/repositories/user_repository_impl.dart';
import '../../infrastructure/repositories/message_repository_impl.dart';
import '../../infrastructure/repositories/favorite_repository_impl.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/repositories/user_preference_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/message_repository.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../application/use_cases/user/create_user.dart';
import '../../application/use_cases/user/delete_user.dart';
import '../../application/use_cases/user/get_user.dart';
import '../../application/use_cases/user/update_user.dart';
import '../../application/use_cases/post/create_post.dart';
import '../../application/use_cases/post/delete_post.dart';
import '../../application/use_cases/post/downvote_post.dart';
import '../../application/use_cases/post/get_post.dart';
import '../../application/use_cases/post/get_posts.dart';
import '../../application/use_cases/post/update_post.dart';
import '../../application/use_cases/post/upvote_post.dart';
import '../../application/use_cases/preferences/get_preferences.dart';
import '../../application/use_cases/preferences/save_preferences.dart';
import '../../application/use_cases/tasks/create_task.dart';
import '../../application/use_cases/tasks/delete_task.dart';
import '../../application/use_cases/tasks/get_tasks.dart';
import '../../application/use_cases/tasks/update_task.dart';

final sl = GetIt.instance;

/// Initialize dependency injection
Future<void> init() async {
  // External dependencies
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton<FirebaseFirestore>(() => firestore);
  
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  
  // Data sources
  sl.registerLazySingleton<FirebaseUserDataSource>(
    () => FirebaseUserDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebasePostDataSource>(
    () => FirebasePostDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<LocalPreferenceDataSource>(
    () => LocalPreferenceDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<LocalTaskDataSource>(
    () => LocalTaskDataSourceImpl(sharedPreferences: sl()),
  );
  
  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<UserPreferenceRepository>(
    () => UserPreferenceRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(),
  );
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(),
  );
  
  // Use cases - User
  sl.registerFactory(() => GetUser(sl()));
  sl.registerFactory(() => CreateUser(sl()));
  sl.registerFactory(() => UpdateUser(sl()));
  sl.registerFactory(() => DeleteUser(sl()));
  
  // Use cases - Post
  sl.registerFactory(() => GetPosts(sl()));
  sl.registerFactory(() => GetPost(sl()));
  sl.registerFactory(() => CreatePost(sl()));
  sl.registerFactory(() => UpdatePost(sl()));
  sl.registerFactory(() => DeletePost(sl()));
  sl.registerFactory(() => UpvotePost(sl()));
  sl.registerFactory(() => DownvotePost(sl()));
  
  // Use cases - Preferences
  sl.registerFactory(() => GetPreferences(sl()));
  sl.registerFactory(() => SavePreferences(sl()));
  
  // Use cases - Tasks
  sl.registerFactory(() => GetTasks(sl()));
  sl.registerFactory(() => CreateTask(sl()));
  sl.registerFactory(() => UpdateTask(sl()));
  sl.registerFactory(() => DeleteTask(sl()));
}

import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Data Sources
import '../../infrastructure/data_sources/firebase_auth_data_source.dart';
import '../../infrastructure/data_sources/firebase_post_data_source.dart';
import '../../infrastructure/data_sources/firebase_user_data_source.dart';

// Repositories
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';
import '../../infrastructure/repositories/post_repository_impl.dart';
import '../../infrastructure/repositories/user_repository_impl.dart';

// Use Cases
import '../../application/use_cases/auth/sign_in_use_case.dart';
import '../../application/use_cases/auth/sign_up_use_case.dart';
import '../../application/use_cases/auth/sign_out_use_case.dart';

// BLoCs
import '../../presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Data sources
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(firebaseAuth: sl()),
  );
  sl.registerLazySingleton<FirebasePostDataSource>(
    () => FirebasePostDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FirebaseUserDataSource>(
    () => FirebaseUserDataSourceImpl(firestore: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: sl()),
  );
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(firebaseDataSource: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(firebaseDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(authRepository: sl()));

  // BLoCs
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
}
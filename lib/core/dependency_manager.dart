import '../features/todo/presentation/bloc/task/task_bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login.dart';
import '../features/auth/domain/usecases/logout.dart';
import '../features/auth/presentation/bloc/auth/auth_bloc.dart';

final getIt = GetIt.instance;

class DependencyManager {
  DependencyManager() {
    getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    // getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

    // ! Auth
    // * Bloc
    getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(getIt(), getIt()));
    getIt.registerLazySingleton<TaskBloc>(() => TaskBloc());

    // * Datasource
    getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(
          firebaseAuth: getIt(),
          googleSignIn: getIt(),
        ));
    // * Repository
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remotedatasource: getIt()));

    // * Usecase
    getIt.registerLazySingleton<Login>(() => Login(getIt()));
    getIt.registerLazySingleton<Logout>(() => Logout(getIt()));
  }
}

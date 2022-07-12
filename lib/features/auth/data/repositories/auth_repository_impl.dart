import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remotedatasource;

  AuthRepositoryImpl({required this.remotedatasource});

  @override
  Future<Either<Exception, AuthUser>> signIn() async {
    try {
      final user = await remotedatasource.signIn();
      return Right(user);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> signOut() async {
    try {
      final res = await remotedatasource.signOut();
      return Right(res);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}

import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  //TODO: create Failure class
  Future<Either<Exception, AuthUser>> signIn();
  Future<Either<Exception, void>> signOut();
}

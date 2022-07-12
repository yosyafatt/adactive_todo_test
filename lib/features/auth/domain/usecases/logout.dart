import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  Future<Either<Exception, void>> call() async {
    return await repository.signOut();
  }
}

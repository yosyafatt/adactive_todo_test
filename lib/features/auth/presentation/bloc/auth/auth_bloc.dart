import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/logout.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final Logout _logout;

  AuthBloc(this._login, this._logout) : super(AuthLoginInitial()) {
    on<AuthLogin>(_onAuthLogin);
    on<AuthLogout>(_onAuthLogout);
  }

  void _onAuthLogin(event, emit) async {
    emit(AuthLoginInProgress());
    final result = await _login();
    emit(
      result.fold(
        (error) => AuthLoginFailure(),
        (user) => AuthLoginSuccess(user),
      ),
    );
  }

  void _onAuthLogout(event, emit) async {
    emit(AuthLogoutInitial());
    emit(AuthLogoutInProgress());
    final result = await _logout();
    emit(
      result.fold(
        (error) => AuthLogoutFailure(),
        (_) => AuthLogoutSuccess(),
      ),
    );
  }
}

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoginInitial extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final AuthUser user;

  const AuthLoginSuccess(this.user);
}

class AuthLoginInProgress extends AuthState {}

class AuthLoginFailure extends AuthState {}

class AuthLogoutInitial extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutInProgress extends AuthState {}

class AuthLogoutFailure extends AuthState {}

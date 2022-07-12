import '../../domain/entities/user.dart';

class UserModel extends AuthUser {
  const UserModel({required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
    );
  }
}

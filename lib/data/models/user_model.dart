import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.name, super.avatarPath});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      avatarPath: json['avatarPath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'avatarPath': avatarPath};
  }
}

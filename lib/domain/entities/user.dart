import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String? avatarPath;

  const User({required this.name, this.avatarPath});

  @override
  List<Object?> get props => [name, avatarPath];
}

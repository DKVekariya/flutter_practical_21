import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String address;
  final String dob;
  final String bloodGroup;
  final String gender;

  const UserEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.dob,
    required this.bloodGroup,
    required this.gender,
  });

  @override
  List<Object?> get props => [name, email, password, address, dob, bloodGroup, gender];
}
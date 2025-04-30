
import '../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.address,
    required super.dob,
    required super.bloodGroup,
    required super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      dob: json['dob'],
      bloodGroup: json['bloodGroup'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'dob': dob,
      'bloodGroup': bloodGroup,
      'gender': gender,
    };
  }
}
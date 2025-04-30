import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

abstract class LocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser(String email);
  Future<void> clearUser();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveUser(UserModel user) async {
    await sharedPreferences.setString('user_${user.email}', jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel?> getUser(String email) async {
    final jsonString = sharedPreferences.getString('user_$email');
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.clear();
  }
}
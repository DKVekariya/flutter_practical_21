import '../datasource/local_datasource.dart';
import '../domain/entity/user_entity.dart';
import '../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<void> register(UserEntity user) async {
    final userModel = UserModel(
      name: user.name,
      email: user.email,
      password: user.password,
      address: user.address,
      dob: user.dob,
      bloodGroup: user.bloodGroup,
      gender: user.gender,
    );
    await localDataSource.saveUser(userModel);
  }

  @override
  Future<UserEntity?> login(String email, String password) async {
    final user = await localDataSource.getUser(email);
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearUser();
  }
}
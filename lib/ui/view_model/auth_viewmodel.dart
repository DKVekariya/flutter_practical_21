import '../../data/domain/entity/user_entity.dart';
import '../../data/domain/usecases/login.dart';
import '../../data/domain/usecases/register.dart';
import '../../utility/validators.dart';


class AuthViewModel {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthViewModel({
    required this.loginUseCase,
    required this.registerUseCase,
  });

  String? validateEmail(String? email) => Validators.validateEmail(email);

  String? validatePassword(String? password) => Validators.validatePassword(password);

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String address,
    required String dob,
    required String bloodGroup,
    required String gender,
  }) async {
    final hashedPassword = Validators.hashPassword(password);
    final user = UserEntity(
      name: name,
      email: email,
      password: hashedPassword,
      address: address,
      dob: dob,
      bloodGroup: bloodGroup,
      gender: gender,
    );
    await registerUseCase(user);
  }

  Future<UserEntity?> login(String email, String password) async {
    final hashedPassword = Validators.hashPassword(password);
    return await loginUseCase(email, hashedPassword);
  }
}
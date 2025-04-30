import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/presentation/bloc/auth_bloc.dart';
import '../../ui/view_model/auth_viewmodel.dart';
import '../datasource/local_datasource.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login.dart';
import '../domain/usecases/register.dart';
import '../repositories/auth_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Data sources
  getIt.registerSingleton<LocalDataSource>(LocalDataSourceImpl(getIt()));

  // Repositories
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(localDataSource: getIt()));

  // Use cases
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt()));
  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt()));

  // ViewModel
  getIt.registerSingleton<AuthViewModel>(AuthViewModel(
    loginUseCase: getIt(),
    registerUseCase: getIt(),
  ));

  // Bloc
  getIt.registerFactory<AuthBloc>(() => AuthBloc(
    loginUseCase: getIt(),
    registerUseCase: getIt(),
  ));
}
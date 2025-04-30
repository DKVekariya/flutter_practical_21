import 'package:flutter_practical_21/data/domain/entity/user_entity.dart';
import 'package:flutter_practical_21/data/domain/usecases/login.dart';
import 'package:flutter_practical_21/data/domain/usecases/register.dart';
import 'package:flutter_practical_21/ui/presentation/bloc/auth_bloc.dart';
import 'package:flutter_practical_21/ui/presentation/bloc/auth_event.dart';
import 'package:flutter_practical_21/ui/presentation/bloc/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_block_test.mocks.dart';

@GenerateMocks([LoginUseCase, RegisterUseCase])
void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    authBloc = AuthBloc(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  final testUser = UserEntity(
    name: 'John Doe',
    email: 'john@example.com',
    password: 'hashedPassword',
    address: '123 Main St',
    dob: '1990-01-01',
    bloodGroup: 'O+',
    gender: 'Male',
  );

  group('RegisterEvent', () {
    test('should emit [AuthLoading, AuthRegistered] when registration is successful', () async {
      // Arrange
      when(mockRegisterUseCase(any)).thenAnswer((_) async {});

      // Act
      authBloc.add(RegisterEvent(testUser));

      // Assert
      await expectLater(
        authBloc.stream,
        emitsInOrder([
          AuthLoading(),
          AuthRegistered(),
        ]),
      );
    });

    test('should emit [AuthLoading, AuthError] when registration fails', () async {
      // Arrange
      when(mockRegisterUseCase(any)).thenThrow(Exception('Registration failed'));

      // Act
      authBloc.add(RegisterEvent(testUser));

      // Assert
      await expectLater(
        authBloc.stream,
        emitsInOrder([
          AuthLoading(),
          isA<AuthError>(),
        ]),
      );
    });
  });

  group('LoginEvent', () {
    test('should emit [AuthLoading, AuthAuthenticated] when login is successful', () async {
      // Arrange
      when(mockLoginUseCase(any, any)).thenAnswer((_) async => testUser);

      // Act
      authBloc.add(const LoginEvent('john@example.com', 'password'));

      // Assert
      await expectLater(
        authBloc.stream,
        emitsInOrder([
          AuthLoading(),
          AuthAuthenticated(user: testUser),
        ]),
      );
    });

    test('should emit [AuthLoading, AuthError] when login fails', () async {
      // Arrange
      when(mockLoginUseCase(any, any)).thenAnswer((_) async => null);

      // Act
      authBloc.add(const LoginEvent('john@example.com', 'wrong'));

      // Assert
      await expectLater(
        authBloc.stream,
        emitsInOrder([
          AuthLoading(),
          isA<AuthError>(),
        ]),
      );
    });
  });

  group('LogoutEvent', () {
    test('should emit [AuthLoading, AuthUnauthenticated] when logout is triggered', () async {
      // Act
      authBloc.add(LogoutEvent());

      // Assert
      await expectLater(
        authBloc.stream,
        emitsInOrder([
          AuthLoading(),
          AuthUnauthenticated(),
        ]),
      );
    });
  });
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/di/injection.dart';
import '../../data/domain/entity/user_entity.dart';
import '../../utility/validators.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../presentation/bloc/auth_event.dart';
import '../presentation/bloc/auth_state.dart';
import '../view_model/auth_viewmodel.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _genderController = TextEditingController();
  final _viewModel = getIt<AuthViewModel>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _bloodGroupController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(RegisterEvent(
        UserEntity(
          name: _nameController.text,
          email: _emailController.text,
          password: Validators.hashPassword(_passwordController.text),
          address: _addressController.text,
          dob: _dobController.text,
          bloodGroup: _bloodGroupController.text,
          gender: _genderController.text,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegistered) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: _viewModel.validateEmail,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: _viewModel.validatePassword,
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: 'Address'),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your address' : null,
                      ),
                      TextFormField(
                        controller: _dobController,
                        decoration: const InputDecoration(labelText: 'Date of Birth'),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your DOB' : null,
                      ),
                      TextFormField(
                        controller: _bloodGroupController,
                        decoration: const InputDecoration(labelText: 'Blood Group'),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your blood group' : null,
                      ),
                      TextFormField(
                        controller: _genderController,
                        decoration: const InputDecoration(labelText: 'Gender'),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your gender' : null,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _register,
                        child: const Text('Register'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text('Already have an account? Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
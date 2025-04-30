import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_21/ui/presentation/bloc/auth_bloc.dart';
import 'package:flutter_practical_21/ui/presentation/bloc/auth_event.dart';
import 'app.dart';
import 'data/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(CheckAuthStatusEvent()),
      child: const App(),
    );
  }
}
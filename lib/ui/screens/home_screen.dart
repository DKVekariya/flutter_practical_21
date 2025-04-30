import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/domain/entity/user_entity.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../presentation/bloc/auth_event.dart';

class HomeScreen extends StatelessWidget {
  final UserEntity user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Profile',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text('Name: ${user.name}'),
                Text('Email: ${user.email}'),
                Text('Address: ${user.address}'),
                Text('Date of Birth: ${user.dob}'),
                Text('Blood Group: ${user.bloodGroup}'),
                Text('Gender: ${user.gender}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
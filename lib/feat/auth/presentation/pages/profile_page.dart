import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_cubit.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_states.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthCubit, AuthStates>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const CircularProgressIndicator();
            } else if (state is AuthError) {
              return Text('Error: ${state.message}');
            } else if (state is Authenticated) {
              final user = state.user;

              String initials =
                  [
                    user.firstName,
                    user.lastName,
                  ].where((name) => name.isNotEmpty).map((name) => name[0].toUpperCase()).join();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    radius: 32,
                    child: Text(initials, style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                  const SizedBox(height: 16),
                  Text('${user.firstName} ${user.lastName}', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              );
            }
            return const SizedBox.shrink(); // Fallback for other states
          },
        ),
      ),
    );
  }
}

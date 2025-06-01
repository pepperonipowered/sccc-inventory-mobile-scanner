import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_button_cubit.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_button_states.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  const AuthButton({required this.onPressed, this.title = '', this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthButtonCubit, AuthButtonStates>(
      builder: (context, state) {
        if (state is ButtonLoading) {
          return _loading(context);
        }
        return _initial(context);
      },
    );
  }

  Widget _loading(BuildContext context) {
    return FilledButton(
      onPressed: null,
      style: FilledButton.styleFrom(
        minimumSize: Size(width ?? MediaQuery.of(context).size.width, height ?? 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget _initial(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(minimumSize: Size(width ?? MediaQuery.of(context).size.width, height ?? 56)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}

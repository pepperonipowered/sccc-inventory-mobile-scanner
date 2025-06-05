import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/common/bloc/button/button_state_cubit.dart';

import '../../bloc/button/button_state.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final ButtonStyle? style;
  final ButtonStyle? loadingStyle;
  final TextStyle? textStyle;
  final IconData? icon;
  final double? iconSize;
  const BasicAppButton({
    required this.onPressed,
    this.title = '',
    this.style,
    this.textStyle,
    this.icon,
    super.key,
    this.loadingStyle,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
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
      style: style,
      child: SizedBox(width: 20, height: 20, child: const CircularProgressIndicator(color: Colors.white)),
    );
  }

  Widget _initial(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: style,
      label: Text(
        title,
        style:
            textStyle ??
            Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      icon: Icon(icon, size: iconSize),
    );
  }
}

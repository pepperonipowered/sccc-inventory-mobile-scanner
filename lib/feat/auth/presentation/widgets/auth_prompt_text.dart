import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPromptText extends StatelessWidget {
  final String promptText;
  final String actionText;
  final String route;

  const AuthPromptText({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$promptText ',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.secondary.withValues(
            alpha: 0.6,
          ),
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: actionText,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    GoRouter.of(context).go(route);
                  },
          ),
        ],
      ),
    );
  }
}

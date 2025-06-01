import 'package:flutter/material.dart';

class AuthPageInfoText extends StatelessWidget {
  final String pageTitle;
  final String? infoTextMain;
  final String? infoTextSub;

  const AuthPageInfoText({super.key, required this.pageTitle, this.infoTextMain, this.infoTextSub});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          alignment: Alignment.center,
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: '$pageTitle\n',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.normal,
              ),
              children: [
                if (infoTextMain != null)
                  TextSpan(
                    text: '$infoTextMain\n',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                if (infoTextSub != null)
                  TextSpan(
                    text: '$infoTextSub\n',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

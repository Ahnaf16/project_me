import 'package:flutter/material.dart';
import 'package:project_me/core/core.dart';

class InfoLabel extends StatelessWidget {
  InfoLabel({
    super.key,
    required this.child,
    required String label,
    TextStyle? labelStyle,
    this.message,
  }) : inlineSpan = TextSpan(text: label, style: labelStyle);

  const InfoLabel.rich({
    super.key,
    required this.child,
    required this.inlineSpan,
    this.message,
  });

  InfoLabel.required({
    super.key,
    required this.child,
    required String label,
    String suffix = '*',
    TextStyle? labelStyle,
    this.message,
  }) : inlineSpan = TextSpan(
          text: label,
          style: labelStyle,
          children: [
            TextSpan(
              text: suffix,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        );

  final Widget child;
  final InlineSpan inlineSpan;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                inlineSpan,
                style: context.textTheme.titleMedium,
              ),
              if (message != null) const Spacer(),
              if (message != null)
                Tooltip(
                  message: message ?? '',
                  child: const Icon(Icons.help_outline_rounded, size: 20),
                ),
            ],
          ),
        ),
        Flexible(child: child),
      ],
    );
  }
}

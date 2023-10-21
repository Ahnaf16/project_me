import 'package:flutter/material.dart';
import 'package:project_me/core/core.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.header,
    this.headerStyle,
    required this.children,
    this.actions,
    this.useWrap = false,
    this.wrapSpacing = 10,
    this.width,
    this.height,
  });

  final List<Widget>? actions;
  final List<Widget> children;
  final String header;
  final TextStyle? headerStyle;
  final bool useWrap;
  final double wrapSpacing;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    header,
                    style: headerStyle ?? context.textTheme.titleLarge,
                  ),
                  const Spacer(),
                  ...?actions,
                ],
              ),
              const SizedBox(height: 10),
              if (useWrap)
                Wrap(
                  spacing: wrapSpacing,
                  runSpacing: wrapSpacing,
                  children: [...children],
                )
              else
                ...children,
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

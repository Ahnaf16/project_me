import 'package:flutter/material.dart';
import 'package:project_me/core/extension/context_extension.dart';

class KDivider extends StatelessWidget {
  const KDivider({
    super.key,
    this.height = 20,
    this.thickness = 1,
    this.indent,
    this.endIndent,
    this.color,
  });
  final double height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 2),
      child: Container(
        height: thickness,
        margin: EdgeInsetsDirectional.only(
          start: indent ?? 10,
          end: endIndent ?? 10,
        ),
        decoration: BoxDecoration(
          color: color ?? (context.isDark ? Colors.grey.shade500 : Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

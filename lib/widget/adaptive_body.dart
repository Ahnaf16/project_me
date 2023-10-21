import 'package:flutter/material.dart';
import 'package:project_me/core/core.dart';

class AdaptiveBody extends StatelessWidget {
  const AdaptiveBody({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.physics,
    this.controller,
    this.margin,
  });

  final Widget child;
  final double? width;
  final double? height;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorTheme.background,
      child: Padding(
        padding: margin ?? const EdgeInsets.all(0),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: width ??
                context.adaptiveWidth(large: 700, small: context.width),
            height: height,
            decoration: context.isSmall
                ? null
                : BoxDecoration(
                    color: context.colorTheme.background,
                    border: Border.symmetric(
                      vertical: BorderSide(color: context.colorTheme.outline),
                    ),
                  ),
            child: child,
          ),
        ),
      ),
    );
  }
}

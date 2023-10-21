import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class KShimmer extends StatelessWidget {
  const KShimmer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(10),
    this.radius = 8,
  });

  KShimmer.card({
    super.key,
    double? height = 200,
    double? width,
    this.padding = const EdgeInsets.all(10),
    this.radius = 8,
  }) : child = Card(child: SizedBox(height: height, width: width));

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Shimmer(
          duration: const Duration(milliseconds: 1500),
          child: child,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_me/core/core.dart';

class AnimatedButton extends HookWidget {
  const AnimatedButton({
    super.key,
    required this.onTap,
    required this.child,
  }) : isSelected = false;

  const AnimatedButton.selectable({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  final Widget child;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final clicked = useState(false);
    final isHovering = useState(false);

    color() {
      if (clicked.value) return context.colorTheme.primary.withOpacity(.7);
      if (isHovering.value && isSelected) {
        return context.colorTheme.primary.withOpacity(.7);
      }
      if (isSelected) return context.colorTheme.primary;
      if (isHovering.value) return context.colorTheme.outline;

      return context.colorTheme.outline.withOpacity(.7);
    }

    return MouseRegion(
      onEnter: (event) => isHovering.value = true,
      onExit: (event) => isHovering.value = false,
      child: GestureDetector(
        onTapDown: (details) => clicked.value = true,
        onTapCancel: () => clicked.value = false,
        onTapUp: (details) => clicked.value = false,
        onTap: () => onTap.call(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: color()),
          ),
          child: AnimatedDefaultTextStyle(
            style: context.textTheme.labelLarge!.copyWith(
              color: isSelected ? context.colorTheme.primary : null,
              fontWeight: isSelected ? FontWeight.bold : null,
              letterSpacing: 1.5,
            ),
            duration: const Duration(milliseconds: 150),
            child: child,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_me/core/core.dart';

class MySelfView extends HookConsumerWidget {
  const MySelfView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(false);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('My Self'),
            RotatingButton(
              isSelected: selected.value,
              onTap: () {
                selected.value = !selected.value;
              },
              child: const Text('BUTTON'),
            )
          ],
        ),
      ),
    );
  }
}

class RotatingButton extends StatefulWidget {
  const RotatingButton({
    super.key,
    required this.child,
    required this.isSelected,
    required this.onTap,
  });
  final Widget child;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<RotatingButton> createState() => _RotatingButtonState();
}

class _RotatingButtonState extends State<RotatingButton> {
  bool clicked = false;
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    color() {
      if (clicked) return context.colorTheme.primary.withOpacity(.7);
      if (widget.isSelected) return context.colorTheme.primary;
      if (isHovering) return context.colorTheme.outline;

      return context.colorTheme.outline.withOpacity(.7);
    }

    return MouseRegion(
      onEnter: (event) {
        setState(() => isHovering = true);
      },
      onExit: (event) {
        setState(() => isHovering = false);
      },
      child: GestureDetector(
        onTapDown: (details) {
          setState(() => clicked = true);
        },
        onTapCancel: () {
          setState(() => clicked = false);
        },
        onTapUp: (details) {
          setState(() => clicked = false);
        },
        onTap: () {
          widget.onTap.call();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: color()),
          ),
          child: AnimatedDefaultTextStyle(
            style: context.textTheme.labelLarge!.copyWith(
              color: widget.isSelected ? context.colorTheme.primary : null,
              fontWeight: widget.isSelected ? FontWeight.bold : null,
              letterSpacing: 1.5,
            ),
            duration: const Duration(milliseconds: 150),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../core/core.dart';

enum SnackType {
  info,
  loading,
  success,
  error;

  IconData get icon => switch (this) {
        info => Icons.info_outline_rounded,
        success => Icons.check_rounded,
        error => Icons.error_outline,
        _ => Icons.info,
      };
}

class OverlayLoader {
  OverlayLoader();

  static bool _onScreen = false;
  static OverlayEntry? _overlayEntry;

  static bool isLoaderOn() => _onScreen;

  Future<void> show(BuildContext context) async =>
      _show(context, message: '', type: SnackType.loading);

  Future<void> showError(
      BuildContext context, String error, bool autoDismiss) async {
    _show(context, message: error, type: SnackType.error);
    if (autoDismiss) {
      await Future.delayed(const Duration(seconds: 5));
      remove();
    }
  }

  Future<void> showInfo(
    BuildContext context,
    String message, {
    Function()? onTap,
    bool autoDismiss = false,
  }) async {
    _show(context, message: message, type: SnackType.info, onTap: onTap);
    if (autoDismiss) {
      await Future.delayed(const Duration(seconds: 5));
      remove();
    }
  }

  Future<void> showSuccess(BuildContext context, String message) async {
    _show(context, message: message, type: SnackType.success);
    await Future.delayed(const Duration(seconds: 3));
    remove();
  }

  void remove() {
    if (_onScreen) {
      _overlayEntry!.remove();
      _onScreen = false;
    }
  }

  // Loader can be changed from here
  OverlayEntry createOverlayEntry({
    String message = '',
    Alignment alignment = Alignment.bottomCenter,
    required SnackType type,
    Function()? onTap,
  }) {
    return OverlayEntry(
      builder: (context) => _OverlayWidget(
        alignment: alignment,
        type: type,
        message: message,
        onClose: () => remove(),
        onTap: onTap,
      ),
    );
  }

  Future<void> _show(
    BuildContext context, {
    String message = '',
    required SnackType type,
    Function()? onTap,
  }) async {
    FocusScope.of(context).requestFocus(FocusNode());
    remove();
    _overlayEntry =
        createOverlayEntry(message: message, type: type, onTap: onTap);

    Overlay.of(context).insert(_overlayEntry!);
    _onScreen = true;
  }
}

class _OverlayWidget extends StatefulWidget {
  const _OverlayWidget({
    required this.alignment,
    required this.type,
    required this.message,
    required this.onClose,
    required this.onTap,
  });

  final Function()? onClose;
  final Function()? onTap;
  final Alignment alignment;
  final String message;
  final SnackType type;

  @override
  State<_OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<_OverlayWidget>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> ani;
  late AnimationController ctrl;

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    ani = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(curve: Curves.fastOutSlowIn, parent: ctrl));
    ctrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.type == SnackType.loading;
    final isError = widget.type == SnackType.error;

    return Align(
      alignment: isLoading ? Alignment.center : widget.alignment,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.all(10),
        child: SizedBox(
          height: 70,
          width: 800,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : GestureDetector(
                  onTap: () async {
                    if (widget.onTap != null) {
                      widget.onTap!.call();
                      // await ctrl.reverse();
                      // widget.onClose?.call() ?? () {};
                    }
                  },
                  child: SlideTransition(
                    position: ani,
                    child: Card(
                      color: isError
                          ? context.colorTheme.error
                          : context.colorTheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: context.colorTheme.outline),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              widget.type.icon,
                              color: isError
                                  ? context.colorTheme.onError
                                  : context.colorTheme.onSurface,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                widget.message,
                                style: context.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isError
                                      ? context.colorTheme.onError
                                      : context.colorTheme.onSurface,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await ctrl.reverse();
                                widget.onClose?.call() ?? () {};
                              },
                              icon: Icon(
                                Icons.close,
                                color: isError
                                    ? context.colorTheme.onError
                                    : context.colorTheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

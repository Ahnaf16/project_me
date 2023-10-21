import 'package:flutter/material.dart';

import '../../widget/widget.dart';

extension ContextEx on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);

  double get height => mq.size.height;

  double get width => mq.size.width;

  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorTheme => theme.colorScheme;

  Brightness get bright => theme.brightness;

  bool get isDark => bright == Brightness.dark;
  bool get isLight => bright == Brightness.light;

  void pop<T extends Object?>([T? result]) =>
      Navigator.canPop(this) ? Navigator.pop(this, result) : null;

  Future<void> showLoader() => OverlayLoader().show(this);

  Future<void> showInfo(String info,
          {Function()? onTap, bool autoDismiss = false}) =>
      OverlayLoader()
          .showInfo(this, info, onTap: onTap, autoDismiss: autoDismiss);

  Future<void> showError(String error, [bool autoDismiss = true]) =>
      OverlayLoader().showError(this, error, autoDismiss);

  Future<void> showSuccess(String success) =>
      OverlayLoader().showSuccess(this, success);

  void removeLoader() => OverlayLoader().remove();
}

extension LayoutEx on BuildContext {
  bool get isSmall => width <= 600;

  int get kCrossAxisCount {
    if (isSmall) return 2;
    return 4;
  }

  int crossAxisCustom(int small, int large) {
    if (isSmall) return small;

    return large;
  }

  double adaptiveWidth({double? small, double? large}) {
    if (!isSmall) return large ?? 700;

    return small ?? width;
  }
}

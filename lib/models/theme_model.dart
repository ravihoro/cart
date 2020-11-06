import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  static bool _isDark = false;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDark => _isDark;

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

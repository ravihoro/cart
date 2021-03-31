import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../viewmodel/theme_model.dart';

class ThemeSwitch extends ViewModelWidget<ThemeModel> {
  @override
  Widget build(BuildContext context, ThemeModel model) {
    return Switch(
      activeColor: Colors.deepPurpleAccent,
      value: model.isDark,
      onChanged: (value) {
        model.switchTheme();
      },
    );
  }
}

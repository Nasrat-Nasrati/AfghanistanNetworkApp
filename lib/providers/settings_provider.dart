import 'package:flutter/material.dart';

enum FontSizeOption { small, medium, large }

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  FontSizeOption _fontSize = FontSizeOption.medium;

  bool get isDarkMode => _isDarkMode;
  FontSizeOption get fontSize => _fontSize;

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void updateFontSize(FontSizeOption option) {
    _fontSize = option;
    notifyListeners();
  }

  double getFontSizeValue() {
    switch (_fontSize) {
      case FontSizeOption.small:
        return 12.0;
      case FontSizeOption.medium:
        return 16.0;
      case FontSizeOption.large:
        return 20.0;
    }
  }
}

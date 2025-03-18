import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor(bool isDarkMode) => isDarkMode ? Color(0xFF176D72) : Color(0xFF176D72);
  static Color backgroundColor(bool isDarkMode) => isDarkMode ? Color(0xFF121212) : Colors.white;
  static Color textColor(bool isDarkMode) => isDarkMode ? Colors.white : Colors.black;
  static Color scaffoldBackgroundColor(bool isDarkMode) => isDarkMode ? Color(0xFF1F1F1F) : Colors.white;
 // static Color scaffoldBackgroundColor(bool isDarkMode) => isDarkMode ? Color(0xFF176D72) : Color(0xFF176D72);
  static Color cardColor(bool isDarkMode) => isDarkMode ? Color(0xFF1e2336) : Colors.white;
}

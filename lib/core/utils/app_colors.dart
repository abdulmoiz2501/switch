import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor(bool isDarkMode) => isDarkMode ? Color(0xFF176D72) : Color(0xFF176D72);
  static Color backgroundColor(bool isDarkMode) => isDarkMode ? Color(0xFF121212) : Colors.white;
  static Color textColor(bool isDarkMode) => isDarkMode ? Colors.white : Colors.black;
  static Color scaffoldBackgroundColor(bool isDarkMode) => isDarkMode ? Color(0xFF1F1F1F) : Colors.white;
 // static Color scaffoldBackgroundColor(bool isDarkMode) => isDarkMode ? Color(0xFF176D72) : Color(0xFF176D72);
  static Color cardColor(bool isDarkMode) => isDarkMode ? Color(0xFF1e2336) : Colors.white;

  static Color searchBarColor(bool isDarkMode) =>
      isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFFF2F2F2);

  static Color chipBackgroundColor(bool isDarkMode) =>
      isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFFEFEFEF);

  static Color subtleTextColor(bool isDarkMode) =>
      isDarkMode ? Colors.white70 : Colors.grey;

  static Color ratingColor(bool isDarkMode) =>
      isDarkMode ? Colors.white70 : Colors.black54;

  static Color productCardBg(bool isDarkMode) =>
      isDarkMode ? const Color(0xFF2D2D2D) : primaryColor(false).withOpacity(0.06);

}

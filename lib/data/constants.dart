import 'package:flutter/material.dart';

class KTextStyle {
  static const TextStyle welcomeTitleText = TextStyle(
    color: Colors.green,
    fontSize: 70.0,
    letterSpacing: 15.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle playerNameText = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle settingsTitleText = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle settingsSubtitleText = TextStyle(
    fontSize: 14.0,
    color: Colors.grey,
  );
}

class KCardSize {
  static const double height = 100;
  static const double width = 75;
  static const Size size = Size(width, height);
}

class KConstants {
  static const String appName = 'REDACTED';
  static const String difficultyKey = 'difficulty';
  static const String themeModeKey = 'isDarkMode';
  static const String soundKey = 'isSoundEnabled';
}

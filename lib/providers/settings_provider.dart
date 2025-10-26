import 'package:flutter/material.dart';
import 'package:redacted_card_game/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Difficulty { normal, impossible }

class SettingsProvider extends ChangeNotifier {
  static const String _difficultyKey = KConstants.difficultyKey;
  static const String _themeKey = KConstants.themeModeKey;
  static const String _soundKey = KConstants.soundKey;

  Difficulty _difficulty = Difficulty.normal;
  bool _isDarkMode = true;
  bool _isSoundEnabled = true;

  late SharedPreferences _prefs;

  Difficulty get difficulty => _difficulty;
  bool get isDarkMode => _isDarkMode;
  bool get isSoundEnabled => _isSoundEnabled;

  SettingsProvider() {
    _loadSettings();
  }

  /// Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();

    // Load difficulty
    final difficultyIndex = _prefs.getInt(_difficultyKey) ?? 0;
    _difficulty = Difficulty.values[difficultyIndex];

    // Load theme
    _isDarkMode = _prefs.getBool(_themeKey) ?? true;

    // Load sound
    _isSoundEnabled = _prefs.getBool(_soundKey) ?? true;

    notifyListeners();
  }

  /// Set difficulty level
  Future<void> setDifficulty(Difficulty difficulty) async {
    _difficulty = difficulty;
    await _prefs.setInt(_difficultyKey, difficulty.index);
    notifyListeners();
  }

  /// Toggle theme mode
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  /// Toggle sound
  Future<void> toggleSound() async {
    _isSoundEnabled = !_isSoundEnabled;
    await _prefs.setBool(_soundKey, _isSoundEnabled);
    notifyListeners();
  }

  /// Get theme data based on current mode
  ThemeData getThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.lightGreenAccent,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
  }
}

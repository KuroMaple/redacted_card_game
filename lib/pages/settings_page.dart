import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redacted_card_game/data/constants.dart';
import 'package:redacted_card_game/providers/game_provider.dart';
import 'package:redacted_card_game/providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How to play REDACTED'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Game Rules:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Players take turns removing cards from any single row\n'
                  '• You can remove any number of cards, but only from ONE row per turn\n'
                  '• The player who takes the LAST card loses the game\n'
                  '• Try to force your opponent into taking the final card',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it!'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Difficulty Setting
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.speed, size: 32),
                  title: const Text(
                    'Difficulty',
                    style: KTextStyle.settingsTitleText,
                  ),
                  subtitle: const Text(
                    'Adjust AI challenge level',
                    style: KTextStyle.settingsSubtitleText,
                  ),
                  trailing: DropdownButton<Difficulty>(
                    value: settings.difficulty,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: Difficulty.normal,
                        child: Text('Normal'),
                      ),
                      DropdownMenuItem(
                        value: Difficulty.impossible,
                        child: Text('Impossible'),
                      ),
                    ],
                    onChanged: (Difficulty? value) {
                      if (value != null) {
                        settings.setDifficulty(value);

                        // Update Games Provider for next game before restart of app
                        if(value == Difficulty.impossible){
                          context.read<GameProvider>().changeTurn();
                        }
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Theme Setting
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(
                    settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    size: 32,
                  ),
                  title: const Text(
                    'Theme',
                    style: KTextStyle.settingsTitleText,
                  ),
                  subtitle: Text(
                    settings.isDarkMode ? 'Dark mode' : 'Light mode',
                    style: KTextStyle.settingsSubtitleText,
                  ),
                  trailing: Switch(
                    value: settings.isDarkMode,
                    onChanged: (_) => settings.toggleTheme(),
                    activeTrackColor: Colors.lightGreenAccent.withOpacity(0.5),
                  ),
                ),
              ),
              // const SizedBox(height: 12),

              // // Sound Setting
              // Card(
              //   elevation: 2,
              //   child: ListTile(
              //     leading: Icon(
              //       settings.isSoundEnabled
              //           ? Icons.volume_up
              //           : Icons.volume_off,
              //       size: 32,
              //     ),
              //     title: const Text(
              //       'Sound',
              //       style: KTextStyle.settingsTitleText,
              //     ),
              //     subtitle: Text(
              //       settings.isSoundEnabled ? 'Enabled' : 'Disabled',
              //       style: KTextStyle.settingsSubtitleText,
              //     ),
              //     trailing: Switch(
              //       value: settings.isSoundEnabled,
              //       onChanged: (_) => settings.toggleSound(),
              //       activeTrackColor: Colors.lightGreenAccent.withOpacity(0.5),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 24),

              // Instructions Button
              Card(
                elevation: 2,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: InkWell(
                  onTap: () => _showInstructions(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help_outline,
                          size: 28,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'How to Play',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

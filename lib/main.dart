import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redacted_card_game/data/constants.dart';
import 'package:redacted_card_game/pages/welcome_page.dart';
import 'package:redacted_card_game/providers/game_provider.dart';
import 'package:redacted_card_game/providers/settings_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProxyProvider<SettingsProvider, GameProvider>(
          create: (context) => GameProvider(
            settingsProvider: context.read<SettingsProvider>(),
          ),
          update: (_, settingsProvider, gameProvider) => gameProvider ?? GameProvider(settingsProvider: settingsProvider),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: KConstants.appName,
          theme: settingsProvider.getThemeData(),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return WelcomePage();
  }
}

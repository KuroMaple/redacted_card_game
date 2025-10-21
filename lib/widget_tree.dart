import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redacted_card_game/pages/game_page.dart';
import 'package:redacted_card_game/providers/game_provider.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => GameProvider(),
        child: GamePage()
        ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:redacted_card_game/pages/game_page.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Center(child: GamePage())),
    );
  }
}

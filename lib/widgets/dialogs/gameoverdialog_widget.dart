import 'package:flutter/material.dart';
import 'package:redacted_card_game/pages/welcome_page.dart';
import 'package:redacted_card_game/providers/game_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GameoverdialogWidget extends StatelessWidget {
  const GameoverdialogWidget({super.key, required this.gameProvider});

  final GameProvider gameProvider;
  @override
  Widget build(BuildContext context) {
    // prize url:
    final Uri prizeUrl = Uri.parse('https://www.youtube.com/watch?v=EE-xtCF3T94');

    // If it's not the player's turn when game ends, player wins.
    final bool isPlayerTurn = gameProvider.isPlayerTurn;
    final bool playerWon = !isPlayerTurn;

    return AlertDialog(
      title: Text(playerWon ? 'You Win' : 'You Lose'),
      content: playerWon ? Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('You beat the CPU! Click below to claim your prize:'),
          TextButton.icon(onPressed: () async {
            await launchUrl(prizeUrl, mode: LaunchMode.externalApplication);
          }, 
          icon: Icon(Icons.catching_pokemon),
          label: Text("Prize link"))
        ],
      ) : Text('Tough luck! You were left the last card.'),
      actions: [
        TextButton(
          onPressed: () {
            // Go back to main menu and clear game state.
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const WelcomePage()),
              (route) => false,
            );
            gameProvider.resetGame();
          },
          child: const Text('Main Menu'),
        ),
        FilledButton(
          onPressed: () {
            // Reset the game and close dialog, staying on the game screen.
            Navigator.of(context).pop();
            gameProvider.resetGame();
          },
          child: const Text('Play Again'),
        ),
      ],
    );
  }
}

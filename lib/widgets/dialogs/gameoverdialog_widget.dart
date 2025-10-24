import 'package:flutter/material.dart';
import 'package:redacted_card_game/pages/welcome_page.dart';
import 'package:redacted_card_game/providers/game_provider.dart';

class GameoverdialogWidget extends StatelessWidget {
  const GameoverdialogWidget({super.key, required this.gameProvider});

  final GameProvider gameProvider;
  @override
  Widget build(BuildContext context) {
    // If it's not the player's turn when game ends, player wins.
    final bool isPlayerTurn = gameProvider.isPlayerTurn;

    final bool playerWon = !isPlayerTurn;

    return AlertDialog(
      title: Text(playerWon ? 'You Win' : 'You Lose'),
      content: Text(
        playerWon
            ? 'Nice! The CPU took the last turn and left the final card for itself.'
            : 'Tough luck! You ended up taking the last move.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Go back to main menu and clear game state.
            gameProvider.resetGame();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const WelcomePage()),
              (route) => false,
            );
          },
          child: const Text('Main Menu'),
        ),
        FilledButton(
          onPressed: () {
            // Reset the game and close dialog, staying on the game screen.
            gameProvider.resetGame();
            Navigator.of(context).pop();
          },
          child: const Text('Play Again'),
        ),
      ],
    );
  }
}

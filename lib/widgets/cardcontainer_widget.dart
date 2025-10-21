import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redacted_card_game/providers/game_provider.dart';
import 'package:redacted_card_game/widgets/gamecard/gamecard_widget.dart';

class CardcontainerWidget extends StatefulWidget {
  const CardcontainerWidget({super.key});

  @override
  State<CardcontainerWidget> createState() => _CardcontainerWidgetState();
}

class _CardcontainerWidgetState extends State<CardcontainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Selector<GameProvider, List<List<CardState>>>(
      selector: (_, gameProvider) => gameProvider.gameState,
      builder: (context, gameState, child) {
        return FittedBox(
          child: Column(
            children: [
              ...List.generate(gameState.length, (row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(gameState[row].length, (col) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GamecardWidget(rowIdx: row, colIdx: col),
                    );
                  }),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

/*

switch (gameState[row][col]) {
                            case CardState.untouched:
                              return GamecardWidget(rowIdx: row, colIdx: col);
                            case CardState.removed:
                              return PlaceholdercardWidget();
                            case CardState.selected:
                              return SelectedcardWidget();
                          }
 */
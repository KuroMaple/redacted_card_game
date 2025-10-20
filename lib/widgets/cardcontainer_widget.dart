import 'package:flutter/material.dart';
import 'package:redacted_card_game/widgets/gamecard_widget.dart';
import 'package:redacted_card_game/widgets/placeholdercard_widget.dart';

class CardcontainerWidget extends StatefulWidget {
  const CardcontainerWidget({
    super.key,
    required this.gameState,
    required this.cardTappedCallback,
  });

  final Function(int, int) cardTappedCallback;
  final List<List<bool>> gameState;

  @override
  State<CardcontainerWidget> createState() => _CardcontainerWidgetState();
}

class _CardcontainerWidgetState extends State<CardcontainerWidget> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          ...List.generate(widget.gameState.length, (row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.gameState[row].length, (col) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.gameState[row][col]
                      ? GamecardWidget(
                          rowIdx: row,
                          colIdx: col,
                          cardTappedCallback: widget.cardTappedCallback,
                        )
                      : PlaceholdercardWidget(),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}

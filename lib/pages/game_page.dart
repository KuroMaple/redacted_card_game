import 'package:flutter/material.dart';
import 'package:redacted_card_game/widgets/cardcontainer_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<List<bool>> gameState = [
    [true],
    [true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true, true, true],
  ];

  void cardTappedCallback(int rowIdx, int colIdx) {
    print("Row: " + rowIdx.toString() + " Col:" + colIdx.toString());
    // gameState[rowIdx][colIdx] = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Player Turn"), Text("CPU Turn")],
              ),
              CardcontainerWidget(
                cardTappedCallback: cardTappedCallback,
                gameState: gameState,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

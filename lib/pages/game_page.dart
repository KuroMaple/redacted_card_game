import 'package:flutter/material.dart';
import 'package:redacted_card_game/data/constants.dart';
import 'package:redacted_card_game/widgets/cardcontainer_widget.dart';
import 'package:redacted_card_game/widgets/dialogs/introdialog_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<List<bool>> gameState = [
    [true],
    [true, true, true],
    [true, true, true, true],
    [true, true, true, true],
    [true, true, true]
  ];
  bool isPlayerTurn = true;

  void cardTappedCallback(int rowIdx, int colIdx) {
    setState(() {
      gameState[rowIdx][colIdx] = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return IntrodialogWidget();
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Player Turn",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: isPlayerTurn ? Colors.green : null,
                  ),
                ),
                Text("CPU Turn", style: KTextStyle.playerNameText),
              ],
            ),
            SizedBox(height: 50.0),
            CardcontainerWidget(
              cardTappedCallback: cardTappedCallback,
              gameState: gameState,
            ),
          ],
        ),
      ),
    );
  }
}

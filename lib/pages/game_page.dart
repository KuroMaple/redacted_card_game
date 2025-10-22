import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redacted_card_game/providers/game_provider.dart';
import 'package:redacted_card_game/widgets/cardcontainer_widget.dart';
import 'package:redacted_card_game/widgets/dialogs/introdialog_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
            Selector<GameProvider, bool>(
              selector: (_, gameProvider) => gameProvider.isPlayerTurn,
              builder: (context, isPlayerTurn, child) {
                return Row(
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
                    Text(
                      "CPU Turn",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: !isPlayerTurn ? Colors.green : null,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 50.0),
            CardcontainerWidget(),
            SizedBox(height: 50.0),
            
            IconButton(
              iconSize: 100,
              onPressed: () {
                final gameProvider = context.read<GameProvider>();
                gameProvider.endPlayerTurn();
              },
              color: Colors.green,
              icon: Icon(Icons.check_circle),
            ),
          ],
        ),
      ),
    );
  }
}

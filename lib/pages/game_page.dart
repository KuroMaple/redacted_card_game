import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redacted_card_game/providers/game_provider.dart';
import 'package:redacted_card_game/widgets/cardcontainer_widget.dart';
import 'package:redacted_card_game/widgets/dialogs/introdialog_widget.dart';
import 'package:redacted_card_game/widgets/dialogs/gameoverdialog_widget.dart';

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
  Widget build(BuildContext parentContext) {
    final currOrientation = MediaQuery.of(context).orientation;

    final bool isPlayerTurn = context.select<GameProvider, bool>(
      (gameProvider) => gameProvider.isPlayerTurn,
    );
    final GameProvider gameProvider = context.read<GameProvider>();

    if (currOrientation == Orientation.landscape) {
      return FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  if (gameProvider.isGameOver) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return GameoverdialogWidget(
                            gameProvider: gameProvider,
                          );
                        },
                      );
                    });
                  }
                  return SizedBox.shrink();
                },
              ),
              Column(
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
                  IconButton(
                    iconSize: 100,
                    enableFeedback: isPlayerTurn,
                    onPressed: () {
                      if (isPlayerTurn) {
                        gameProvider.endPlayerTurn();
                      }
                    },
                    color: isPlayerTurn ? Colors.green : Colors.grey,
                    icon: Icon(Icons.check_circle),
                  ),
                ],
              ),
              CardcontainerWidget(),
              Text(
                "CPU Turn",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: !isPlayerTurn ? Colors.green : null,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Builder(
              builder: (context) {
                if (gameProvider.isGameOver) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return GameoverdialogWidget(gameProvider: gameProvider);
                      },
                    );
                  });
                }
                return SizedBox.shrink();
              },
            ),
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
                Text(
                  "CPU Turn",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: !isPlayerTurn ? Colors.green : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.0),
            CardcontainerWidget(),
            SizedBox(height: 50.0),
            IconButton(
              iconSize: 100,
              enableFeedback: isPlayerTurn,
              onPressed: () {
                if (isPlayerTurn) {
                  gameProvider.endPlayerTurn();
                }
              },
              color: isPlayerTurn ? Colors.green : Colors.grey,
              icon: Icon(Icons.check_circle),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redacted_card_game/providers/game_provider.dart';
import 'package:redacted_card_game/widgets/gamecard/removedcard_widget.dart';
import 'package:redacted_card_game/widgets/gamecard/selectedcard_widget.dart';
import 'package:redacted_card_game/widgets/gamecard/untouchedcard_widget.dart';

class GamecardWidget extends StatefulWidget {
  const GamecardWidget({super.key, required this.rowIdx, required this.colIdx});

  final int rowIdx, colIdx;
  @override
  State<GamecardWidget> createState() => _GamecardWidgetState();
}

class _GamecardWidgetState extends State<GamecardWidget> {
  String getRandomCardPath() {
    //TODO Dark mode swap with light based on theme
    String res = 'assets/images/DarkCards/';

    Random random = Random();
    int min = 1;
    int max = 18;
    int cardNumber = random.nextInt(max - min) + min;

    if (cardNumber == 18) {
      res += 'K';
    } else if (cardNumber == 17) {
      res += 'Q';
    } else if (cardNumber == 16) {
      res += 'J';
    } else if (cardNumber == 15) {
      res += 'A';
    } else {
      res += cardNumber.toString();
    }

    res += '-';

    List<String> houses = ['C', 'D', 'H', 'P'];
    int houseNumber = random.nextInt(3 - 0) + 0;
    res += '${houses[houseNumber]}.png';

    return res;
  }

  late String cardPath;

  @override
  void initState() {
    super.initState();
    cardPath = getRandomCardPath();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<GameProvider, ({CardState state, int? selectedRow})>(
      selector: (_, gameProvider) => gameProvider.cardInfo(widget.rowIdx, widget.colIdx), // multi selection
      builder: (context, cardInfo, child) {
        Widget subCard;
        switch (cardInfo.state) {
          case CardState.untouched:
            subCard = UntouchedcardWidget(cardPath: cardPath);
            break;
          case CardState.removed:
            subCard = RemovedcardWidget();
            break;
          case CardState.selected:
            subCard = SelectedcardWidget();
            break;
        }
        return AbsorbPointer(
          absorbing: isTappable(cardInfo.selectedRow, widget.rowIdx),
          child: Opacity(
            opacity: isTappable(cardInfo.selectedRow, widget.rowIdx) ? 0.5 : 1,
            child: InkWell(
              onTap: () {
                final gameProvider = context.read<GameProvider>();
                gameProvider.handleCardTap(
                  rowIdx: widget.rowIdx,
                  colIdx: widget.colIdx,
                );
              },
              child: subCard,
            ),
          ),
        );
      },
    );
  }

  bool isTappable(int? selectedRow, int currRow){
    if(selectedRow != null && selectedRow != currRow){
      return true;
    }
    return false;
  }
}

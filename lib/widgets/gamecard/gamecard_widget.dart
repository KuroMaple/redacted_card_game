import 'dart:math';

import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: () {
        print(
          "Card tapped: row ${widget.rowIdx} and col ${widget.colIdx}",
        );
      },
      child: Ink.image(
        image: AssetImage(cardPath),
        height: 100,
        width: 75,
      ),
    );
  }
}

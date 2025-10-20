import 'dart:math';

import 'package:flutter/material.dart';

class GamecardWidget extends StatelessWidget {
  const GamecardWidget({
    super.key,
    required this.rowIdx,
    required this.colIdx,
    required this.cardTappedCallback,
  });

  final int rowIdx, colIdx;
  final Function(int, int) cardTappedCallback;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cardTappedCallback(rowIdx, colIdx);
      },
      child: Ink.image(
        image: AssetImage('assets/images/DarkCards/${getRandomCardName()}.png'),
        height: 100,
        width: 75,
      ),
    );
  }
  
  String getRandomCardName(){
    String res = '';

    Random random = Random();
    int min = 1;
    int max = 18;
    int cardNumber = random.nextInt(max - min) + min;

    if(cardNumber == 18){
      res += 'K';
    }
    else if(cardNumber == 17){
      res += 'Q';
    }
    else if(cardNumber == 16){
      res += 'J';
    }
    else if(cardNumber == 15){
      res += 'A';
    }
    else {
      res += cardNumber.toString();
    }

    res += '-';

    List<String> houses = ['C', 'D', 'H', 'P']; 
    int houseNumber = random.nextInt(3 - 0) + 0;
    res += houses[houseNumber];
    print("Res is: " + res);
    return res;
  }
}

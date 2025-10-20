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
        image: const AssetImage('assets/images/1-D.png'),
        height: 100,
        width: 75,
      ),
    );
  }
}

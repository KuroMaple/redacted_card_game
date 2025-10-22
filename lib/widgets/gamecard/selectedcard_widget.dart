import 'package:flutter/material.dart';
import 'package:redacted_card_game/data/constants.dart';

class SelectedcardWidget extends StatelessWidget {
  const SelectedcardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: KCardSize.height,
      width: KCardSize.width,
      child: ColoredBox(color: Colors.green),
    );
  }
}

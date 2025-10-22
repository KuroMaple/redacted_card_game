import 'package:flutter/material.dart';
import 'package:redacted_card_game/data/constants.dart';

class RemovedcardWidget extends StatelessWidget {
  const RemovedcardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: KCardSize.height,
      width: KCardSize.width,
    );
  }
}

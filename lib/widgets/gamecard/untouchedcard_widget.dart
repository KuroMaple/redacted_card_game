import 'package:flutter/material.dart';

class UntouchedcardWidget extends StatelessWidget {
  const UntouchedcardWidget({super.key, required this.cardPath});

  final String cardPath;
  @override
  Widget build(BuildContext context) {
    return Ink.image(image: AssetImage(cardPath), height: 100, width: 75);
  }
}

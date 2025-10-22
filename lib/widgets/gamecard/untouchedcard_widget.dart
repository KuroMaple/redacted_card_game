import 'package:flutter/material.dart';

import '../../data/constants.dart';

class UntouchedcardWidget extends StatelessWidget {
  const UntouchedcardWidget({super.key, required this.cardPath});

  final String cardPath;
  @override
  Widget build(BuildContext context) {
    return Image.asset(cardPath, height:  KCardSize.height, width: KCardSize.width, fit: BoxFit.fill,);
  }
}

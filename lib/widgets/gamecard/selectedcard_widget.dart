import 'package:flutter/material.dart';

class SelectedcardWidget extends StatelessWidget {
  const SelectedcardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 75,
      child: ColoredBox(color: Colors.green),
    );
  }
}

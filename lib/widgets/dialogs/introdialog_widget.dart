import 'package:flutter/material.dart';

class IntrodialogWidget extends StatefulWidget {
  const IntrodialogWidget({super.key});

  @override
  State<IntrodialogWidget> createState() => _IntrodialogWidgetState();
}

class _IntrodialogWidgetState extends State<IntrodialogWidget> {
  int instructionIdx = 0;

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'Welcome to REDACTED',
      'How to play?',
      'How to play?',
      'How to play?',
      'Enough talk lets fight',
    ];
    List<String> instructions = [
      'In this game you\'ll take turns picking cards up against a CPU.',
      'Once you choose a row to pick from, you can take 1 to all of the cards',
      'BUT you can only take from one row at a time so choose carefully.',
      'The person who has to pick up the last card on their turn loses.',
      'Good luck!',
    ];
    return AlertDialog(
      title: Text(titles[instructionIdx]),
      content: Text(instructions[instructionIdx]),
      actions: [
        FilledButton(
          onPressed: () {
            setState(() {
              if (instructionIdx < instructions.length - 1) {
                instructionIdx++;
              } else {
                Navigator.of(context).pop();
              }
            });
          },
          child: (instructionIdx < instructions.length - 1)
              ? Text('Next ${instructionIdx + 1}/${instructions.length}')
              : Text('Let me at em'),
        ),
      ],
    );
  }
}

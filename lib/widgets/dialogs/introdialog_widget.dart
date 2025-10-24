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
      'Enough talk let\'s fight',
    ];
    List<String> instructions = [
      'In this game, you\'ll take turns picking up cards against a CPU opponent.',
      'When you choose a row, you can take any number of cards — from just one to the entire row.',
      'But here\'the catch: you can only pick from one row per turn, so choose wisely.',
      'Whoever is forced to pick up the very last card loses the game.',
      'That\'s all you need to know.',
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
              : Text('Play'),
        ),
      ],
    );
  }
}

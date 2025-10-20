import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [Text("cards here"),
          Card(
            child: Image.asset('assets/images/1-D.png', scale: 2,),
          ),
        ],
      ),
    );
  }
}
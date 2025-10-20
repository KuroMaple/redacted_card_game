import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:redacted_card_game/data/constants.dart';
import 'package:redacted_card_game/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Lottie.asset('assets/lotties/ace_of_spade.json'),
                FittedBox(
                  child: Text('REDACTED', style: KTextStyle.welcomeTitleText),
                ),
                SizedBox(height: 40.0),
                FilledButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size(200, 75)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return WidgetTree();
                    },));
                  },
                  child: Text("Play", style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

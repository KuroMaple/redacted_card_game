import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:redacted_card_game/data/constants.dart';
import 'package:redacted_card_game/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive work
    final currOrientation = MediaQuery.of(context).orientation;
    final currWinWidth = MediaQuery.of(context).size.width;

    print('Current width is $currWinWidth');
    // 850 px

    if (currOrientation == Orientation.landscape || currWinWidth > 850) {
      return Scaffold(
        appBar: AppBar(),
        body: FittedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  child: Column(
                    children: [
                      Text('REDACTED', style: KTextStyle.welcomeTitleText),
                      Lottie.asset('assets/lotties/ace_of_spade.json'),
                    ],
                  ),
                ),
                FilledButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size(200, 75)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WidgetTree();
                        },
                      ),
                    );
                  },
                  child: Text("Play", style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WidgetTree();
                    },
                  ),
                );
              },
              child: Text("Play", style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}

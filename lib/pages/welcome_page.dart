import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:redacted_card_game/data/constants.dart';
import 'package:redacted_card_game/pages/settings_page.dart';
import 'package:redacted_card_game/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive work
    final currOrientation = MediaQuery.of(context).orientation;
    final currWinAR = MediaQuery.of(context).size.aspectRatio;

    if (currWinAR > 2.1) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('REDACTED', style: KTextStyle.welcomeTitleText),
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
                  SizedBox(height: 10.0),
                  OutlinedButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(Size(200, 75)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SettingsPage();
                          },
                        ),
                      );
                    },
                    child: Text('Settings', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (currOrientation == Orientation.landscape) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lotties/ace_of_spade.json'),
                  Text('REDACTED', style: KTextStyle.welcomeTitleText),
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
                  IconButton(
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
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
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
            SizedBox(height: 10.0),
            OutlinedButton(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(200, 75)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage();
                    },
                  ),
                );
              },
              child: Text('Settings', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int difficulty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Diffifculty:     ", style: TextStyle(fontSize: 20)),
                  DropdownButton(
                    value: difficulty,
                    items: [
                      DropdownMenuItem(value: 1, child: Text("Normal")),
                      DropdownMenuItem(value: 2, child: Text("Impossible")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        difficulty = value ?? 1;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Theme:     ', style: TextStyle(fontSize: 20)),
                  IconButton(
                    onPressed: () async {
                      // isDarkModeNotifier.value = !isDarkModeNotifier.value;
                      // final SharedPreferences prefs = await SharedPreferences.getInstance();
                      // await prefs.setBool(KConstants.themeModeKey, isDarkModeNotifier.value);
                    },
                    icon: /*isDarkMode ?*/ Icon(
                      Icons.dark_mode,
                    ) /*: Icon(Icons.light_mode),*/,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Sound:     ', style: TextStyle(fontSize: 20)),
                  IconButton(
                    onPressed: () async {
                      // isDarkModeNotifier.value = !isDarkModeNotifier.value;
                      // final SharedPreferences prefs = await SharedPreferences.getInstance();
                      // await prefs.setBool(KConstants.themeModeKey, isDarkModeNotifier.value);
                    },
                    icon: /*isDarkMode ?*/ Icon(
                      Icons.music_note_sharp,
                    ) /*: Icon(Icons.light_mode),*/,
                  ),
                ],
              ),
              ElevatedButton(onPressed: () {
                //TODO: Open detailed instruction dialog/navigate to instructions page
              }, child: Text('Instructions'))
            ],
          ),
        ),
      ),
    );
  }
}

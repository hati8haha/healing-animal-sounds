import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String selectedLanguage = '繁體中文';
  bool showLanguageOptions = false;

  List<String> languageOptions = [
    '繁體中文',
    'English',
    'Spanish',
    'French',
    'German',
    'Japanese',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "設定",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text('語言'),
                      subtitle: Text(selectedLanguage),
                      trailing: Icon(showLanguageOptions
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                      onTap: () {
                        setState(() {
                          showLanguageOptions = !showLanguageOptions;
                        });
                      },
                    ),
                    if (showLanguageOptions)
                      ...languageOptions.map((language) => ListTile(
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  50.0, 10.0, 0, 10.0),
                              child: Text(language),
                            ),
                            onTap: () {
                              setState(() {
                                selectedLanguage = language;
                                showLanguageOptions = false;
                              });
                            },
                          )),
                    ListTile(
                      leading: Icon(Icons.dark_mode),
                      title: Text('暗夜模式'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        ///
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.emoji_events),
                      title: Text('升級VIP'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        ///
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.thumb_up),
                      title: Text('在Play Store給我們 ⭐'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        ///
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.message),
                      title: Text('意見與反饋'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        ///
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.gpp_maybe_outlined),
                      title: Text('隱私權條款'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        ///
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/animals/bird.png',
                  height: 300.0,
                  width: 300.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

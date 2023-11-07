import 'package:flutter/material.dart';
import 'package:healing_animal_sounds/pages/auth_gate.dart';
import 'package:healing_animal_sounds/pages/setting.dart';
import 'package:healing_animal_sounds/pages/sound.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:json_theme/json_theme.dart';

import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode

import './pages/home.dart';
import './pages/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final themeLightStr = await rootBundle.loadString('assets/theme/light.json');
  final themeLightJson = jsonDecode(themeLightStr);
  final themeLight = ThemeDecoder.decodeThemeData(themeLightJson)!;
  final themeDarkStr = await rootBundle.loadString('assets/theme/dark.json');
  final themeDarkJson = jsonDecode(themeDarkStr);
  final themeDark = ThemeDecoder.decodeThemeData(themeDarkJson)!;


  runApp(MyApp(themeLight: themeLight, themeDark: themeDark));
}

class MyApp extends StatelessWidget {
    final ThemeData themeLight;
    final ThemeData themeDark;

  const MyApp( {super.key, required this.themeLight, required this.themeDark});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '會動的療癒夥伴－動物叫聲、白噪音、放鬆、睡眠、紓壓',
        theme: themeLight,
        darkTheme: themeDark,
        initialRoute: '/landing',
        routes: {
          '/landing': ( context) => LandingPage(),
          '/auth': (context) => AuthGate(),
          '/home': (context) => HomePage(),
          '/sound': (context) => SoundPage(
                animalName: 'Crow_Animations',
              ),
          '/setting': (context) => SettingPage(),
        },
    );
  }
}

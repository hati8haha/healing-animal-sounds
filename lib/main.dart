import 'package:flutter/material.dart';
import 'package:healing_animal_sounds/pages/auth_gate.dart';
import 'package:healing_animal_sounds/pages/setting.dart';
import 'package:healing_animal_sounds/pages/sound.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'utils/theme_provider.dart';
import 'constants/theme.dart';
import './pages/home.dart';
import './pages/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.watch(darkModeProvider);
    final themeString = ThemeString();
    final themeLightStr = themeString.themeLight;
    final themeLightJson = jsonDecode(themeLightStr);
    final themeLight =
        ThemeDecoder.decodeThemeData(themeLightJson) ?? ThemeData();
    final themeDarkStr = themeString.themeDark;
    final themeDarkJson = jsonDecode(themeDarkStr);
    final themeDark =
        ThemeDecoder.decodeThemeData(themeDarkJson) ?? ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '會動的療癒夥伴－動物叫聲、白噪音、放鬆、睡眠、紓壓',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => LandingPage(),
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

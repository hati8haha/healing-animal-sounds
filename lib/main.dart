import 'package:flutter/material.dart';
import 'package:healing_animal_sounds/pages/auth_gate.dart';
import 'package:healing_animal_sounds/pages/setting.dart';
import 'package:healing_animal_sounds/pages/sound.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './pages/home.dart';
import './pages/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '會動的療癒夥伴－動物叫聲、白噪音、放鬆、睡眠、紓壓',
        theme: _kShrineTheme,
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

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: Colors.blue,
      onPrimary: Colors.blue[900],
      secondary: Colors.greenAccent,
      error: Colors.redAccent,
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.blueAccent,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.blueAccent,
      backgroundColor: Colors.amberAccent,
    ),

  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headlineSmall: base.headlineSmall!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        titleLarge: base.titleLarge!.copyWith(
          fontSize: 18.0,
        ),
        bodySmall: base.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyLarge: base.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: Colors.blueAccent[800],
        bodyColor: Colors.blue,
      );
}

// class MyAppState extends ChangeNotifier {
//   void getNext() {
//     notifyListeners();
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {

//     return LayoutBuilder(builder: (context, constraints) {
//       return Scaffold(
//    body: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 color: Theme.of(context).colorScheme.primaryContainer,
//                 child: SizedBox(),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

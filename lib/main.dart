import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lunar_calendar/router.dart' as router;
import 'pages/home_screen.dart';
import 'pages/setting_screen.dart';

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LunarCalendarApp(),
    );
  }
}

class LunarCalendarApp extends StatelessWidget {
  const LunarCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lunar Calendar",
      initialRoute: '/',
      routes: {
        router.defaultRoute: (context) => const HomeScreen(),
        router.settingScreen: (context) => const SettingScreen()
      },
    );
  }
}

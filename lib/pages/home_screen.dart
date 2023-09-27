import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lunar_calendar/router.dart' as router;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lunar Calendar"),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: 'Today',
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Setting',
            onPressed: () {
              Navigator.pushNamed(context, router.settingScreen);
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text("Home screen data"),
        ),
      ),
    );
  }
}
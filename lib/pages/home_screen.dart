import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context).homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: AppLocalizations.of(context).todayActionDescription,
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: AppLocalizations.of(context).settingActionDescription,
            onPressed: () {
              Navigator.pushNamed(context, router.settingScreen);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text(AppLocalizations.of(context).demoData((30 / 4).toString())),
        ),
      ),
    );
  }
}
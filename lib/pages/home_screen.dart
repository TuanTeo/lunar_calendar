import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lunar_calendar/router.dart' as router;
import 'package:lunar_calendar/widgets/calendar/calendar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime _today = DateTime.now();

  void _onTodayPress() {
    setState(() {
      _today = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homeTitle),
        actions: [
          IconButton(
            icon: Stack(alignment: Alignment.center,children: [
              const Icon(Icons.calendar_today),
              Padding(
                  padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 6),
                  child: Text("${_today.day}", style: const TextStyle(fontSize: 10),))
            ],),
            tooltip: AppLocalizations.of(context).todayActionDescription,
            onPressed: () {
              _onTodayPress();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: AppLocalizations.of(context).todayActionDescription,
            onPressed: () {
              _onTodayPress();
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
        child: CalendarWidget(today: _today),
      ),
    );
  }
}
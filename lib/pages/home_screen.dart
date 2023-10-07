import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lunar_calendar/router.dart' as router;
import 'package:lunar_calendar/widgets/calendar/calendar_widget.dart';
import 'package:lunar_calendar/widgets/today_icon/today_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime _startCalendarDate = DateTime.utc(1900, 1, 1);
  final DateTime _endCalendarDate = DateTime.utc(2100, 12, 31);
  final DateTime _today = DateTime.now();

  DateTime _selectedDay = DateTime.now();

  void _onTodayPress() {
    setState(() {
      _selectedDay = DateTime.now();
    });
  }

  Future<void> _showDatePickerDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDay,
        firstDate: _startCalendarDate,
        lastDate: _endCalendarDate);

    if (picked != null) {
      setState(() {
        _selectedDay = picked;
      });
    }
  }


  void _onSelectedDateChange(DateTime selectedDate) {
    _selectedDay = selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homeTitle),
        actions: [
          IconButton(
            icon: TodayIcon(date: _today),
            tooltip: AppLocalizations.of(context).todayActionDescription,
            onPressed: () {
              _onTodayPress();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: AppLocalizations.of(context).todayActionDescription,
            onPressed: () {
              _showDatePickerDialog(context);
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
        child: CalendarWidget(
          today: _selectedDay,
          startCalendarDate: _startCalendarDate,
          endCalendarDate: _endCalendarDate,
          onSelectedDayChange: _onSelectedDateChange
        ),
      ),
    );
  }
}
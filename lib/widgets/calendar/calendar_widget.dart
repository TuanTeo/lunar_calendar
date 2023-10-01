import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../extension/date_time_extension.dart';
import '../../table_calendar_lib/shared/utils.dart';
import 'table_calendar_customize.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  final DateTime _now = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();

  final _availableCalendarFormats = const {
    CalendarFormat.month: 'Month',
    CalendarFormat.week: 'Week',
  };

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  bool _selectedDayPredicate(DateTime day) {
    return !_now.isSameDate(_selectedDay) && _selectedDay == day;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendarCustom(
      firstDay: DateTime.utc(1900, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: _selectedDay,
      currentDay: DateTime.now(),
      locale: 'vi',
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: _availableCalendarFormats,
      calendarFormat: _calendarFormat,
      onFormatChanged: _onFormatChanged,
      onDaySelected: _onDaySelected,
      selectedDayPredicate: _selectedDayPredicate,
      pageJumpingEnabled: true
    );
  }
}

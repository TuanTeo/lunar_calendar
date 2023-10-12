import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../table_calendar_lib/shared/utils.dart';
import '../../utils/calendar_page_utils.dart';
import 'table_calendar_customize.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime today;
  final DateTime startCalendarDate;
  final DateTime endCalendarDate;
  final Function onSelectedDayChange;

  const CalendarWidget(
      {super.key,
      required this.today,
      required this.startCalendarDate,
      required this.endCalendarDate,
      required this.onSelectedDayChange});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int _selectedPage = -1;

  Map<CalendarFormat, String>? _availableCalendarFormats;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  PageController? _pageController;

  DateTime getSelectedDate() {
    return _selectedDay;
  }

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      widget.onSelectedDayChange(selectedDay);
    });
  }

  bool _selectedDayPredicate(DateTime day) {
    return isSameDay(_selectedDay, day);
  }

  bool _isMonthPageFormat() {
    return _calendarFormat == CalendarFormat.month;
  }

  @override
  void didUpdateWidget(covariant CalendarWidget oldWidget) {
    /// Calculate page of selected day
    _selectedPage = _isMonthPageFormat()
        ? getMonthCount(widget.startCalendarDate, widget.today)
        : getWeekCount(widget.startCalendarDate, widget.today);

    /// Scroll to initialPage
    _pageController?.animateToPage(
        _selectedPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear);

    /// Select today
    setState(() {
      _selectedDay = widget.today;
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _availableCalendarFormats ??= {
        CalendarFormat.month: AppLocalizations.of(context).monthCalendarFormat,
        CalendarFormat.week: AppLocalizations.of(context).weekCalendarFormat,
      };

    return TableCalendarCustom(
      firstDay: widget.startCalendarDate,
      lastDay: widget.endCalendarDate,
      focusedDay: _selectedDay,
      locale: 'vi',
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: _availableCalendarFormats!,
      calendarFormat: _calendarFormat,
      onFormatChanged: _onFormatChanged,
      onDaySelected: _onDaySelected,
      selectedDayPredicate: _selectedDayPredicate,
      pageJumpingEnabled: true,
      onCalendarCreated: (pageController) {
        _pageController = pageController;
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../table_calendar_lib/shared/utils.dart';
import '../../utils/calendar_page_utils.dart';
import 'table_calendar_customize.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime? today;

  const CalendarWidget({super.key, this.today});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late final int _initialWeekPage;
  final DateTime _startCalendarDate = DateTime.utc(1900, 1, 1);
  final DateTime _endCalendarDate = DateTime.utc(2100, 12, 31);
  final DateTime _nowDate = DateTime.now();
  final _availableCalendarFormats = const {
    CalendarFormat.month: 'Month',
    CalendarFormat.week: 'Week',
  };

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  PageController? _pageController;

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
    // Todo Lỗi TH chưa load xong đã chọn ngày khác
    return isSameDay(_selectedDay, day);
  }

  bool _isMonthPageFormat() {
    return _calendarFormat == CalendarFormat.month;
  }

  @override
  void initState() {
    super.initState();
    _initialWeekPage = getWeekCount(_startCalendarDate, _selectedDay);
  }

  @override
  void didUpdateWidget(covariant CalendarWidget oldWidget) {
    /// Scroll to initialPage
    _pageController?.animateToPage(
        _isMonthPageFormat() ? _pageController!.initialPage : _initialWeekPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear);

    /// Select today
    setState(() {
      _selectedDay = widget.today ?? _nowDate;
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendarCustom(
      firstDay: _startCalendarDate,
      lastDay: _endCalendarDate,
      focusedDay: _selectedDay,
      locale: 'vi',
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: _availableCalendarFormats,
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

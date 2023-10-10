import 'package:flutter/cupertino.dart';
import 'package:lunar_calendar/widgets/calendar/day_cell_content.dart';

import '../../table_calendar_lib/customization/calendar_builders.dart';
import '../../table_calendar_lib/customization/calendar_style.dart';
import '../../table_calendar_lib/table_calendar.dart';

class TableCalendarCustom<T> extends TableCalendar {

  TableCalendarCustom({
    super.key,
    required DateTime focusedDay,
    required DateTime firstDay,
    required DateTime lastDay,
    super.locale,
    super.startingDayOfWeek,
    super.availableCalendarFormats,
    super.calendarFormat,
    super.onFormatChanged,
    super.onDaySelected,
    super.currentDay,
    super.selectedDayPredicate,
    super.pageJumpingEnabled,
    super.onCalendarCreated,
  }) : super(focusedDay: focusedDay, firstDay: firstDay, lastDay: lastDay);

  @override
  _TableCalendarCustomState createState() => _TableCalendarCustomState();
}

class _TableCalendarCustomState<T> extends TableCalendarState<T> {

  @override
  void didUpdateWidget(TableCalendar oldWidget) {
    // super.didUpdateWidget(oldWidget);

    if (pRangeSelectionMode != widget.rangeSelectionMode) {
      pRangeSelectionMode = widget.rangeSelectionMode;
    }

    if (widget.rangeStartDay == null && widget.rangeEndDay == null) {
      pFirstSelectedDay = null;
    }
  }

  @override
  Widget createDayCellContent(
      {required ValueKey<String> key,
        required DateTime day,
        required DateTime focusedDay,
        required CalendarStyle calendarStyle,
        required CalendarBuilders<T> calendarBuilders,
        required bool isTodayHighlighted,
        required bool isToday,
        required bool isSelected,
        required bool isRangeStart,
        required bool isRangeEnd,
        required bool isWithinRange,
        required bool isOutside,
        required bool isDisabled,
        required bool isWeekend,
        required bool isHoliday,
        required locale}) {

    return DayCellInfo(
      key: key,
      day: day,
      focusedDay: focusedDay,
      calendarStyle: calendarStyle,
      calendarBuilders: calendarBuilders,
      isTodayHighlighted: isTodayHighlighted,
      isToday: isToday,
      isSelected: isSelected,
      isRangeStart: isRangeStart,
      isRangeEnd: isRangeEnd,
      isWithinRange: isWithinRange,
      isOutside: isOutside,
      isDisabled: isDisabled,
      isWeekend: isWeekend,
      isHoliday: isHoliday,
      locale: locale,
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:lunar_calendar/widgets/table_calendar_lib_custom/cell_content_customize.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import '../../table_calendar_lib/customization/calendar_builders.dart';
import '../../table_calendar_lib/customization/calendar_style.dart';
import '../../table_calendar_lib/shared/utils.dart';
import '../../table_calendar_lib/table_calendar.dart';
import 'calendar_style_customize.dart';
import 'table_calendar_base_customize.dart';

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

    return CellContentCustom(
      key: key,
      day: day,
      focusedDay: focusedDay,
      calendarStyle: const CalendarStyleCustom(),
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

  @override
  createTableCalendarBase(
      {required Null Function(dynamic pageController) onCalendarCreated,
        required DateTime focusedDay,
        required CalendarFormat calendarFormat,
        required AvailableGestures availableGestures,
        required DateTime firstDay,
        required DateTime lastDay,
        required StartingDayOfWeek startingDayOfWeek,
        required Decoration dowDecoration,
        required Decoration rowDecoration,
        required TableBorder tableBorder,
        required EdgeInsets tablePadding,
        required bool dowVisible,
        required double dowHeight,
        required double rowHeight,
        required Duration formatAnimationDuration,
        required Curve formatAnimationCurve,
        required bool pageAnimationEnabled,
        required Duration pageAnimationDuration,
        required Curve pageAnimationCurve,
        required Map<CalendarFormat, String> availableCalendarFormats,
        required SimpleSwipeConfig simpleSwipeConfig,
        required bool sixWeekMonthsEnforced,
        required void Function(SwipeDirection direction) onVerticalSwipe,
        required Null Function(dynamic focusedDay) onPageChanged,
        required bool weekNumbersVisible,
        required Widget Function(BuildContext context, DateTime day) weekNumberBuilder,
        required Widget Function(BuildContext context, DateTime day) dowBuilder,
        required GestureDetector Function(dynamic context, dynamic day, dynamic focusedMonth) dayBuilder
      }) {
    return TableCalendarBaseCustom(
      onCalendarCreated: onCalendarCreated,
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      availableGestures: availableGestures,
      firstDay: firstDay,
      lastDay: lastDay,
      startingDayOfWeek: startingDayOfWeek,
      dowDecoration: dowDecoration,
      rowDecoration: rowDecoration,
      tableBorder: tableBorder,
      tablePadding: tablePadding,
      dowVisible: dowVisible,
      dowHeight: dowHeight,
      rowHeight: rowHeight,
      formatAnimationDuration: formatAnimationDuration,
      formatAnimationCurve: formatAnimationCurve,
      pageAnimationEnabled: pageAnimationEnabled,
      pageAnimationDuration: pageAnimationDuration,
      pageAnimationCurve: pageAnimationCurve,
      availableCalendarFormats: availableCalendarFormats,
      simpleSwipeConfig: simpleSwipeConfig,
      sixWeekMonthsEnforced: sixWeekMonthsEnforced,
      onVerticalSwipe: onVerticalSwipe,
      onPageChanged: onPageChanged,
      weekNumbersVisible: weekNumbersVisible,
      weekNumberBuilder: weekNumberBuilder,
      dowBuilder: dowBuilder,
      dayBuilder: dayBuilder,
    );
  }
}
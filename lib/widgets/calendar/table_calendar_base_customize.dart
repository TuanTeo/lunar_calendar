import 'package:flutter/material.dart';
import 'package:lunar_calendar/table_calendar_lib/table_calendar_base.dart';
import 'package:lunar_calendar/themes/dimens.dart';
import 'package:lunar_calendar/widgets/calendar/calendar_core_customize.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import '../../table_calendar_lib/shared/utils.dart';

class TableCalendarBaseCustom extends TableCalendarBase {
  TableCalendarBaseCustom(
      {super.key,
      required super.firstDay,
      required super.lastDay,
      required super.focusedDay,
      super.calendarFormat = CalendarFormat.month,
      super.dowBuilder,
      required super.dayBuilder,
      super.dowHeight,
      required super.rowHeight,
      super.sixWeekMonthsEnforced = false,
      super.dowVisible = true,
      super.weekNumberBuilder,
      super.weekNumbersVisible = false,
      super.dowDecoration,
      super.rowDecoration,
      super.tableBorder,
      super.tablePadding,
      super.formatAnimationDuration = const Duration(milliseconds: 200),
      super.formatAnimationCurve = Curves.linear,
      super.pageAnimationEnabled = true,
      super.pageAnimationDuration = const Duration(milliseconds: 300),
      super.pageAnimationCurve = Curves.easeOut,
      super.startingDayOfWeek = StartingDayOfWeek.sunday,
      super.availableGestures = AvailableGestures.all,
      super.simpleSwipeConfig = const SimpleSwipeConfig(
          verticalThreshold: 25.0,
          swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
        ),
      super.availableCalendarFormats = const {
          CalendarFormat.month: 'Month',
          CalendarFormat.twoWeeks: '2 weeks',
          CalendarFormat.week: 'Week',
        },
      super.onVerticalSwipe,
      super.onPageChanged,
      super.onCalendarCreated,
      });

  @override
  TableCalendarBaseCustomState createState() => TableCalendarBaseCustomState();
}

class TableCalendarBaseCustomState extends TableCalendarBaseState {

  @override
  double customPadding() {
    return Dimens.mediumPadding;
  }

  @override
  Widget createCalendarCore(
      {required BoxConstraints constraints,
        required PageController pageController,
        required ScrollPhysics scrollPhysics,
        required DateTime firstDay,
        required DateTime lastDay,
        required StartingDayOfWeek startingDayOfWeek,
        required CalendarFormat calendarFormat,
        required int previousIndex,
        required DateTime focusedDay,
        required bool sixWeekMonthsEnforced,
        required bool dowVisible,
        double? dowHeight,
        required double rowHeight,
        required bool weekNumbersVisible,
        DayBuilder? weekNumberBuilder,
        Decoration? dowDecoration,
        Decoration? rowDecoration,
        TableBorder? tableBorder,
        EdgeInsets? tablePadding,
        required Null Function(dynamic index, dynamic focusedMonth) onPageChanged,
        DayBuilder? dowBuilder,
        required FocusedDayBuilder dayBuilder}
      ) {
    return CalendarCoreCustom(
      constraints: constraints,
      pageController: pageController,
      scrollPhysics: scrollPhysics,
      firstDay: firstDay,
      lastDay: lastDay,
      startingDayOfWeek: startingDayOfWeek,
      calendarFormat: calendarFormat,
      previousIndex: previousIndex,
      focusedDay: focusedDay,
      sixWeekMonthsEnforced: sixWeekMonthsEnforced,
      dowVisible: dowVisible,
      dowHeight: dowHeight,
      rowHeight: rowHeight,
      weekNumbersVisible: weekNumbersVisible,
      weekNumberBuilder: weekNumberBuilder,
      dowDecoration: dowDecoration,
      rowDecoration: rowDecoration,
      tableBorder: tableBorder,
      tablePadding: tablePadding,
      onPageChanged: onPageChanged,
      dowBuilder: dowBuilder,
      dayBuilder: dayBuilder,
    );
  }
}
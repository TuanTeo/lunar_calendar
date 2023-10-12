import 'package:flutter/material.dart';
import 'package:lunar_calendar/widgets/table_calendar_lib_custom/calendar_page_customize.dart';

import '../../table_calendar_lib/shared/utils.dart';
import '../../table_calendar_lib/widgets/calendar_core.dart';

class CalendarCoreCustom extends CalendarCore {
  const CalendarCoreCustom(
      {super.key,
      super.dowBuilder,
      required super.dayBuilder,
      required super.onPageChanged,
      required super.firstDay,
      required super.lastDay,
      required super.constraints,
      super.dowHeight,
      super.rowHeight,
      super.startingDayOfWeek = StartingDayOfWeek.sunday,
      super.calendarFormat = CalendarFormat.month,
      super.pageController,
      super.focusedDay,
      super.previousIndex,
      super.sixWeekMonthsEnforced = false,
      super.dowVisible = true,
      super.weekNumberBuilder,
      required super.weekNumbersVisible,
      super.dowDecoration,
      super.rowDecoration,
      super.tableBorder,
      super.tablePadding,
      super.scrollPhysics});

  @override
  Widget createCalendarPage(
      {required List<DateTime> visibleDays,
          required bool dowVisible,
          Decoration? dowDecoration,
          Decoration? rowDecoration,
          TableBorder? tableBorder,
          EdgeInsets? tablePadding,
          required SizedBox Function(dynamic context, dynamic day) dowBuilder,
          required SizedBox Function(dynamic context, dynamic day) dayBuilder,
          double? dowHeight,
          required bool weekNumberVisible,
          required SizedBox Function(dynamic context, dynamic day)
          weekNumberBuilder}) {
      return CalendarPageCustom(
          visibleDays: visibleDays,
          dowVisible: dowVisible,
          dowDecoration: dowDecoration,
          rowDecoration: rowDecoration,
          tableBorder: tableBorder,
          tablePadding: tablePadding,
          dowBuilder: dowBuilder,
          dayBuilder: dayBuilder,
          dowHeight: dowHeight,
          weekNumberVisible: weekNumberVisible,
          weekNumberBuilder: weekNumberBuilder,
      );
  }
}

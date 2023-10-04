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

class _TableCalendarCustomState extends TableCalendarState {

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
}
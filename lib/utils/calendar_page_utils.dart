enum StartingDayOfWeekCustom {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

/// Tính initial page number theo CalendarFormat.month
int getMonthCount(DateTime first, DateTime last) {
  final yearDif = last.year - first.year;
  final monthDif = last.month - first.month;

  return yearDif * 12 + monthDif;
}

/// Tính initial page number theo CalendarFormat.week
int getWeekCount(DateTime first, DateTime last) {
  var selectedDate = DateTime(last.year, last.month, last.day);
  return selectedDate.difference(_firstDayOfWeek(first)).inDays ~/ 7;
}

DateTime _firstDayOfWeek(DateTime week) {
  final daysBefore = _getDaysBefore(week);
  return week.subtract(Duration(days: daysBefore));
}

int _getDaysBefore(DateTime firstDay) {
  return (firstDay.weekday + 7 - _getWeekdayNumber(StartingDayOfWeekCustom.sunday)) % 7;
}

int _getWeekdayNumber(StartingDayOfWeekCustom weekday) {
  return StartingDayOfWeekCustom.values.indexOf(weekday) + 1;
}
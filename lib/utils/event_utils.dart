import 'package:flutter/foundation.dart';
import 'package:lunar_calendar/data/event/event_default_data.dart';
import 'package:lunar_calendar/viet_calendar/viet_calendar.dart';

class EventUtils {

  static final List<String> eventNameId = listDefaultEvent.map((event) => event.name).toList();

  static final List<String> eventSolarDate = listDefaultEvent
      .expand((event) => [if (!event.isLunar) event.date else ""])
      .toList();

  static final List<String> eventLunarDate = listDefaultEvent
      .expand((event) => [if (event.isLunar) event.date else ""])
      .toList();

  /// Return [0] isEvent, [1] isLunarEvent
  static List<int> isEventDay(DateTime dateTime) {

    /* [0] day, [1] month, [2] year, [3] leap */
    var lunarDay = VietCalendar.convertSolar2Lunar(
        dateTime.day, dateTime.month, dateTime.year, VietCalendar.TIME_ZONE);

    var isSolarEvent = _isSolarEventDay(dateTime.day, dateTime.month);
    var isLunarEvent = _isLunarEventDay(lunarDay[0], lunarDay[1], lunarDay[3]);

    var isEvent = (isSolarEvent != -1) || (isLunarEvent != -1);

    if (kDebugMode) {
      print("tuanteo: $dateTime isEventDay = $isEvent");
    }

    return [isEvent ? 1 : 0, isSolarEvent, isLunarEvent];
  }

  static String eventDayName(int eventIndex) {
    try {
      return eventNameId[eventIndex];
    } on RangeError {
      return "";
    }
  }

  static int _isSolarEventDay(int solarDay, int solarMonth) {
    return eventSolarDate.indexOf("$solarDay/$solarMonth", 0);
  }

  static int _isLunarEventDay(int lunarDay, int lunarMonth, int isLeap) {
    if (isLeap == 0) {
      return eventLunarDate.indexOf("$lunarDay/$lunarMonth", 0);
    }
    return -1;
  }
}
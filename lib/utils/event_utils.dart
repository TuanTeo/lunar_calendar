import 'package:flutter/foundation.dart';
import 'package:lunar_calendar/data/event/event_default_data.dart';
import 'package:lunar_calendar/viet_calendar/viet_calendar.dart';

class EventUtils {

  static final List<String> eventDate = listDefaultEvent.map((event) => event.date).toList();

  /// Return [0] isEvent, [1] isLunarEvent
  static List<bool> isEventDay(DateTime dateTime) {

    /* [0] day, [1] month, [2] year, [3] leap */
    var lunarDay = VietCalendar.convertSolar2Lunar(
        dateTime.day, dateTime.month, dateTime.year, VietCalendar.TIME_ZONE);

    var isSolarEvent = _isSolarEventDay(dateTime.day, dateTime.month);
    var isLunarEvent = _isLunarEventDay(lunarDay[0], lunarDay[1], lunarDay[3]);

    var isEvent = (isSolarEvent || isLunarEvent);

    if (kDebugMode) {
      print("tuanteo: $dateTime isEventDay = $isEvent");
    }

    return [isEvent, isLunarEvent];
  }

  static String eventDayName(DateTime dateTime, bool isLunarEvent) {
    var isEvent = false;

    var lunarDay = VietCalendar.convertSolar2Lunar(
        dateTime.day, dateTime.month, dateTime.year, VietCalendar.TIME_ZONE);

    var isSolarEvent = _isSolarEventDay(dateTime.day, dateTime.month);

    return "isEvent";
  }

  static bool _isSolarEventDay(int solarDay, int solarMonth) {
    if (eventDate.contains("$solarDay/$solarMonth")) {
      return true;
    }
    return false;
  }

  static _isLunarEventDay(int lunarDay, int lunarMonth, int isLeap) {
    if (isLeap == 0 && eventDate.contains("$lunarDay/$lunarMonth")) {
      return true;
    }
    return false;
  }
}
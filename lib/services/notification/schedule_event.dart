import 'package:lunar_calendar/viet_calendar/viet_calendar.dart';

import '../../data/event/event_default_data.dart';

class ScheduleEvent {

  static final List<String> listEventLunarDate = listDefaultEvent
      .expand((event) => [if (event.isLunar) event.date])
      .toList();

  static final List<String> listEventSolarDate = listDefaultEvent
      .expand((event) => [if (!event.isLunar) event.date])
      .toList();


  /// B1: Chuyển các ngày lễ sang dương lịch
  /// B2: So sánh nếu ngày hiện tại lớn hơn ngày lễ -> ngày lễ năm sau (+1 năm)
  /// B3: So sánh ngày vừa tính với ngày đã lưu trước đó (nếu rỗng thì gán luôn)
  /// B4: Gán ngày gần nhất bằng ngày nhỏ.
  DateTime nearestEventDay() {
    var today = DateTime.now();
    var todayDay = today.day;
    var todayMonth = today.month;
    var todayYear = today.year;

    var nearestDate;
    DateTime tempDate = DateTime.now();
    List<String> eventDate;
    int eventDay;
    int eventMonth;

    /// B1: Chuyển các ngày lễ sang dương lịch
    for (var i = 0; i < listEventSolarDate.length - 1; i++) {
      eventDate = listEventSolarDate[i].split("/");
      eventDay = int.parse(eventDate[0]);
      eventMonth = int.parse(eventDate[1]);

      /// B2: So sánh nếu ngày hiện tại lớn hơn ngày lễ -> ngày lễ năm sau (+1 năm)
      if (eventMonth < todayMonth || (eventDay <= todayDay && eventMonth == todayMonth)) {
        tempDate = DateTime(todayYear + 1, eventMonth, eventDay);
      } else {
        tempDate = DateTime(todayYear, eventMonth, eventDay);
      }

      /// B3: So sánh ngày vừa tính với ngày đã lưu trước đó (nếu rỗng thì gán luôn)
      nearestDate ??= tempDate;
      if (nearestDate.year > tempDate.year) {
        nearestDate = tempDate;
      } else if (nearestDate.year == tempDate.year && nearestDate.month > tempDate.month) {
        nearestDate = tempDate;
      } else if (nearestDate.month == tempDate.month && nearestDate.day > tempDate.day) {
        nearestDate = tempDate;
      }
    }

    var todayLunarDate;
    var todayLunarDay;
    var todayLunarMonth;
    var todayLunarYear;

    var tempLunarEvent;

    for (var i = 0; i < listEventLunarDate.length; i++) {
      todayLunarDate ??= VietCalendar.convertSolar2Lunar(
          todayDay, todayMonth, todayYear, VietCalendar.TIME_ZONE);
      todayLunarDay = todayLunarDate[0];
      todayLunarMonth = todayLunarDate[1];
      todayLunarYear = todayLunarDate[2];

      /// B1: Chuyển các ngày lễ sang dương lịch
      eventDate = listEventLunarDate[i].split("/");
      eventDay = int.parse(eventDate[0]);
      eventMonth = int.parse(eventDate[1]);

      /// B2: So sánh nếu ngày hiện tại lớn hơn ngày lễ -> ngày lễ năm sau (+1 năm)
      if (eventMonth < todayLunarMonth || (eventDay <= todayLunarDay && eventMonth == todayLunarMonth)) {
        tempLunarEvent = VietCalendar.convertLunar2Solar(
            eventDay, eventMonth, todayLunarYear + 1, 0, VietCalendar.TIME_ZONE);
        tempDate = DateTime(tempLunarEvent[2], tempLunarEvent[1], tempLunarEvent[0]);
      } else {
        tempLunarEvent = VietCalendar.convertLunar2Solar(
            eventDay, eventMonth, todayLunarYear, 0, VietCalendar.TIME_ZONE);
        tempDate = DateTime(tempLunarEvent[2], tempLunarEvent[1], tempLunarEvent[0]);
      }

      /// B3: So sánh ngày vừa tính với ngày đã lưu trước đó (nếu rỗng thì gán luôn)
      nearestDate ??= tempDate;
      if (nearestDate.year > tempDate.year) {
        nearestDate = tempDate;
      } else if (nearestDate.year == tempDate.year && nearestDate.month > tempDate.month) {
        nearestDate = tempDate;
      } else if (nearestDate.year == tempDate.year && nearestDate.month == tempDate.month && nearestDate.day > tempDate.day) {
        nearestDate = tempDate;
      }
    }

    return nearestDate;
  }

}
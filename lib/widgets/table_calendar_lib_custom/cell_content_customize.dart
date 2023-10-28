import 'package:flutter/cupertino.dart';
import 'package:lunar_calendar/table_calendar_lib/widgets/cell_content.dart';
import 'package:lunar_calendar/themes/dimens.dart';

import '../../utils/event_utils.dart';
import '../../viet_calendar/viet_calendar.dart';
import 'calendar_style_customize.dart';

class CellContentCustom extends CellContent {

  const CellContentCustom(
      {super.key,
      required super.day,
      required super.focusedDay,
      required super.calendarStyle,
      required super.calendarBuilders,
      required super.isTodayHighlighted,
      required super.isToday,
      required super.isSelected,
      required super.isRangeStart,
      required super.isRangeEnd,
      required super.isWithinRange,
      required super.isOutside,
      required super.isDisabled,
      required super.isHoliday,
      required super.isWeekend,
      super.locale});

  List<String> _displayLunarDay() {
    var result = "";
    var isFirstDay = "";
    var lunarDate = VietCalendar.convertSolar2Lunar(
        super.day.day, super.day.month, super.day.year, VietCalendar.TIME_ZONE);

    var lunarDay = lunarDate[0];
    var lunarMonth = lunarDate[1];
    var isLeap = lunarDate[3];

    if (lunarDay == 1) {
      if (isLeap == 1) {
        result = "$lunarDay/$lunarMonth N";
      } else {
        result = "$lunarDay/$lunarMonth";
      }
    } else {
      result = "$lunarDay";
    }

    if (lunarDay == 1 || lunarDay == 15) {
      isFirstDay = 'true';
    }

    var isEventDay = EventUtils.isEventDay(day);
    var isEvent = isEventDay[0][0] != 0;

    return [result, isFirstDay, isEvent ? 'true' : ''];
  }

  @override
  Widget isDisabledDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    var lunarTextStyle = (lunarDay[1].isNotEmpty || lunarDay[2].isNotEmpty)
        ? (calendarStyle as CalendarStyleCustom).normalLunarDayEventTextStyle
        : (calendarStyle as CalendarStyleCustom).normalLunarTextStyle;
    var solarTextStyle = lunarDay[2].isNotEmpty
        ? (calendarStyle as CalendarStyleCustom).disableSolarDayEventTextStyle
        : calendarStyle.disabledTextStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(solarDay, style: solarTextStyle),
        Text(lunarDay[0],
            style: lunarTextStyle.copyWith(
                fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }

  @override
  Widget isSelectedDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(solarDay, style: calendarStyle.selectedTextStyle),
        Text(lunarDay[0],
            style: (calendarStyle as CalendarStyleCustom).selectedLunarTextStyle
                .copyWith(fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }

  @override
  Widget isRangeStartDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    var lunarTextStyle = (lunarDay[1].isNotEmpty || lunarDay[2].isNotEmpty)
        ? (calendarStyle as CalendarStyleCustom).normalLunarDayEventTextStyle
        : (calendarStyle as CalendarStyleCustom).normalLunarTextStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(solarDay, style: calendarStyle.rangeStartTextStyle),
        Text(lunarDay[0],
            style:lunarTextStyle.copyWith(fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }

  @override
  Widget isRangeEndDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    var lunarTextStyle = (lunarDay[1].isNotEmpty || lunarDay[2].isNotEmpty)
        ? (calendarStyle as CalendarStyleCustom).normalLunarDayEventTextStyle
        : (calendarStyle as CalendarStyleCustom).normalLunarTextStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(solarDay, style: calendarStyle.rangeEndTextStyle),
        Text(lunarDay[0],
            style: lunarTextStyle.copyWith(fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }

  @override
  Widget isTodayHighlightedDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    var lunarTextStyle = (lunarDay[1].isNotEmpty || lunarDay[2].isNotEmpty)
        ? (calendarStyle as CalendarStyleCustom).todayFirstLunarDayTextStyle
        : (calendarStyle as CalendarStyleCustom).todayLunarTextStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(solarDay, style: calendarStyle.todayTextStyle),
        Text(lunarDay[0],
            style: lunarTextStyle.copyWith(fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }

  @override
  Widget isHolidayDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    var lunarTextStyle = (lunarDay[1].isNotEmpty || lunarDay[2].isNotEmpty)
        ? (calendarStyle as CalendarStyleCustom).normalLunarDayEventTextStyle
        : (calendarStyle as CalendarStyleCustom).normalLunarTextStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(solarDay, style: calendarStyle.holidayTextStyle),
        Text(lunarDay[0],
            style: lunarTextStyle.copyWith(fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }

  @override
  Widget isWithinRangeDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    var lunarTextStyle = (lunarDay[1].isNotEmpty || lunarDay[2].isNotEmpty)
        ? (calendarStyle as CalendarStyleCustom).normalLunarDayEventTextStyle
        : (calendarStyle as CalendarStyleCustom).normalLunarTextStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(solarDay, style: calendarStyle.withinRangeTextStyle),
        Text(lunarDay[0],
            style: lunarTextStyle.copyWith(fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }

  @override
  Widget isOutsideDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    var lunarTextStyle = (lunarDay[1].isNotEmpty || lunarDay[2].isNotEmpty)
        ? (calendarStyle as CalendarStyleCustom).disableLunarDayEventTextStyle
        : (calendarStyle as CalendarStyleCustom).normalLunarTextStyle;
    var solarTextStyle = lunarDay[2].isNotEmpty
        ? (calendarStyle as CalendarStyleCustom).disableSolarDayEventTextStyle
        : calendarStyle.disabledTextStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(solarDay, style: solarTextStyle),
        Text(lunarDay[0],
            style: lunarTextStyle.copyWith(fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }

  @override
  Widget isNormalDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    var lunarTextStyle = (lunarDay[1].isNotEmpty || lunarDay[2].isNotEmpty)
        ? (calendarStyle as CalendarStyleCustom).normalLunarDayEventTextStyle
        : (calendarStyle as CalendarStyleCustom).normalLunarTextStyle;
    TextStyle solarTextStyle;
    if (lunarDay[2].isNotEmpty) {
      solarTextStyle = (calendarStyle as CalendarStyleCustom).normalSolarDayEventTextStyle;
    } else if (isWeekend) {
      solarTextStyle = calendarStyle.weekendTextStyle;
    } else {
      solarTextStyle = calendarStyle.defaultTextStyle;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(solarDay,
            style:solarTextStyle),
        Text(lunarDay[0],
            style: lunarTextStyle.copyWith(fontSize: Dimens.lunarDayCalendar)),
      ],
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:lunar_calendar/table_calendar_lib/widgets/cell_content.dart';
import 'package:lunar_calendar/themes/dimens.dart';

import '../../viet_calendar/viet_calendar.dart';

class DayCellInfo extends CellContent {

  const DayCellInfo(
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

  String _displayLunarDay() {
    var result = "";
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

    return result;
  }

  @override
  Widget isDisabledDay(String solarDay) {
    var lunarDay = _displayLunarDay();
    return Column(
      children: [
        Text(solarDay, style: calendarStyle.disabledTextStyle),
        Text(lunarDay, style: calendarStyle.disabledTextStyle.copyWith(fontSize: Dimens.smallTextSize)),
      ],
    );
  }

  @override
  Widget isSelectedDay(String solarDay) {
    return Text(solarDay, style: calendarStyle.selectedTextStyle);
  }

  @override
  Widget isRangeStartDay(String text) {
    return Text(text, style: calendarStyle.rangeStartTextStyle);
  }

  @override
  Widget isRangeEndDay(String text) {
    return Text(text, style: calendarStyle.rangeEndTextStyle);
  }

  @override
  Widget isTodayHighlightedDay(String text) {
    return Text(text, style: calendarStyle.todayTextStyle);
  }

  @override
  Widget isHolidayDay(String text) {
    return Text(text, style: calendarStyle.holidayTextStyle);
  }

  @override
  Widget isWithinRangeDay(String text) {
    return Text(text, style: calendarStyle.withinRangeTextStyle);
  }

  @override
  Widget isOutsideDay(String text) {
    return Text(text, style: calendarStyle.outsideTextStyle);
  }

  @override
  Widget isNormalDay(String text) {
    return Text(
        text,
        style: isWeekend
            ? calendarStyle.weekendTextStyle
            : calendarStyle.defaultTextStyle
    );
  }
}
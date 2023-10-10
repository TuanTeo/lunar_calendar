import 'package:flutter/material.dart';
import 'package:lunar_calendar/table_calendar_lib/customization/calendar_style.dart';

class CalendarStyleCustom extends CalendarStyle {


  const CalendarStyleCustom({
    super.isTodayHighlighted = true,
    super.canMarkersOverflow = true,
    super.outsideDaysVisible = true,
    super.markersAutoAligned = true,
    super.markerSize,
    super.markerSizeScale = 0.2,
    super.markersAnchor = 0.7,
    super.rangeHighlightScale = 1.0,
    super.markerMargin = const EdgeInsets.symmetric(horizontal: 0.3),
    super.markersAlignment = Alignment.bottomCenter,
    super.markersMaxCount = 4,
    super.cellMargin = const EdgeInsets.all(0.0),
    super.cellPadding = const EdgeInsets.all(0),
    super.cellAlignment = Alignment.center,
    super.markersOffset = const PositionedOffset(),
    super.rangeHighlightColor = const Color(0xFFBBDDFF),
    super.markerDecoration = const BoxDecoration(
      color: Color(0xFF263238),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.todayTextStyle = const TextStyle(
      color: Color(0xFFFAFAFA),
      fontSize: 16.0,
    ), //
    super.todayDecoration = const BoxDecoration(
      color: Color(0xFF9FA8DA),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.selectedTextStyle = const TextStyle(
      color: Color(0xFFFAFAFA),
      fontSize: 16.0,
    ),
    super.selectedDecoration = const BoxDecoration(
      color: Color(0xFF5C6BC0),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.rangeStartTextStyle = const TextStyle(
      color: Color(0xFFFAFAFA),
      fontSize: 16.0,
    ),
    super.rangeStartDecoration = const BoxDecoration(
      color: Color(0xFF6699FF),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.rangeEndTextStyle = const TextStyle(
      color: Color(0xFFFAFAFA),
      fontSize: 16.0,
    ),
    super.rangeEndDecoration = const BoxDecoration(
      color: Color(0xFF6699FF),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.withinRangeTextStyle = const TextStyle(),
    super.withinRangeDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.outsideTextStyle = const TextStyle(color: Color(0xFFAEAEAE)),
    super.outsideDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.disabledTextStyle = const TextStyle(color: Color(0xFFBFBFBF)),
    super.disabledDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.holidayTextStyle = const TextStyle(color: Color(0xFF5C6BC0)),
    super.holidayDecoration = const BoxDecoration(
      border: Border.fromBorderSide(
        BorderSide(color: Color(0xFF9FA8DA), width: 1.4),
      ),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.weekendTextStyle = const TextStyle(color: Color(0xFF5A5A5A)),
    super.weekendDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.weekNumberTextStyle =
    const TextStyle(fontSize: 12, color: Color(0xFFBFBFBF)),
    super.defaultTextStyle = const TextStyle(),
    super.defaultDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.rowDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    super.tableBorder = const TableBorder(),
    super.tablePadding = const EdgeInsets.all(0),
  });
}
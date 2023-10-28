import 'package:flutter/material.dart';
import 'package:lunar_calendar/table_calendar_lib/customization/calendar_style.dart';

class CalendarStyleCustom extends CalendarStyle {

  final TextStyle normalLunarTextStyle;
  final TextStyle selectedLunarTextStyle;
  final TextStyle todayLunarTextStyle;
  final TextStyle normalLunarDayEventTextStyle;
  final TextStyle disableLunarDayEventTextStyle;
  final TextStyle todayFirstLunarDayTextStyle;
  final TextStyle normalSolarDayEventTextStyle;
  final TextStyle disableSolarDayEventTextStyle;

  const CalendarStyleCustom({
    /// Add custom
    this.normalLunarTextStyle = const TextStyle(color: Color(0xFF9D9D9D)),
    this.selectedLunarTextStyle = const TextStyle(color: Color(0xFFEAEAEA)),
    this.todayLunarTextStyle = const TextStyle(color: Color(0xFFE7E7E7)),
    this.normalLunarDayEventTextStyle = const TextStyle(color: Color(0xFFFF5E5E)),
    this.disableLunarDayEventTextStyle = const TextStyle(color: Color(
        0xFFFFBBBB)),
    this.todayFirstLunarDayTextStyle = const TextStyle(color: Color(0xFFF8FCBC)),
    this.normalSolarDayEventTextStyle = const TextStyle(color: Color(0xFFFD4C4C)),
    this.disableSolarDayEventTextStyle = const TextStyle(color: Color(
        0xFFFFB5B5)),
    super.selectedDecoration = const BoxDecoration(
      color: Color(0xFFCE486C),
      shape: BoxShape.circle,
    ),
    super.todayDecoration = const BoxDecoration(
      color: Color(0xFFF8819D),
      shape: BoxShape.circle,
    ),
  });
}
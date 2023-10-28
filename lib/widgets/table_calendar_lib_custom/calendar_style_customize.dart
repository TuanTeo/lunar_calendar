import 'package:flutter/material.dart';
import 'package:lunar_calendar/table_calendar_lib/customization/calendar_style.dart';

class CalendarStyleCustom extends CalendarStyle {

  final TextStyle normalLunarTextStyle;
  final TextStyle selectedLunarTextStyle;
  final TextStyle todayLunarTextStyle;
  final TextStyle firstLunarDayTextStyle;
  final TextStyle todayFirstLunarDayTextStyle;

  const CalendarStyleCustom({
    /// Add custom
    this.normalLunarTextStyle = const TextStyle(color: Color(0xFF9D9D9D)),
    this.selectedLunarTextStyle = const TextStyle(color: Color(0xFFEAEAEA)),
    this.todayLunarTextStyle = const TextStyle(color: Color(0xFFE7E7E7)),
    this.firstLunarDayTextStyle = const TextStyle(color: Color(0xFFFF5E5E)),
    this.todayFirstLunarDayTextStyle = const TextStyle(color: Color(0xFFF8FCBC)),
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
import 'package:flutter/material.dart';
import 'package:lunar_calendar/table_calendar_lib/customization/calendar_style.dart';

class CalendarStyleCustom extends CalendarStyle {

  final TextStyle normalLunarTextStyle;
  final TextStyle selectedLunarTextStyle;
  final TextStyle todayLunarTextStyle;

  const CalendarStyleCustom({
    /// Add custom
    this.normalLunarTextStyle = const TextStyle(color: Color(0xFF9D9D9D)),
    this.selectedLunarTextStyle = const TextStyle(color: Color(0xFFD3D3D3)),
    this.todayLunarTextStyle = const TextStyle(color: Color(0xFFE7E7E7)),
    super.selectedDecoration = const BoxDecoration(
      color: Color(0xFFB93C5D),
      shape: BoxShape.circle,
    ),
    super.todayDecoration = const BoxDecoration(
      color: Color(0xFFC08A9B),
      shape: BoxShape.circle,
    ),
  });
}
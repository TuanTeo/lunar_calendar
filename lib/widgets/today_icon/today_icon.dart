import 'package:flutter/material.dart';
import 'package:lunar_calendar/themes/dimens.dart';

class TodayIcon extends StatelessWidget {
  final DateTime? date;

  const TodayIcon({super.key, this.date});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      const Icon(Icons.calendar_today),
      Padding(
          padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 6),
          child: Text(
            "${date != null ? date?.day : DateTime.now().day}",
            style: const TextStyle(fontSize: Dimens.smallTextSize),
          ))
    ]);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:lunar_calendar/data/author.dart';
import 'package:lunar_calendar/data/poem.dart';
import 'package:lunar_calendar/viet_calendar/viet_calendar.dart';

import '../../themes/dimens.dart';

class DayEntertainmentInfo extends StatelessWidget {

  final DateTime day;
  const DayEntertainmentInfo({super.key, required this.day});

  String _poem(DateTime day) {
    var can = VietCalendar.dayCanIndex(day.day, day.month, day.year);
    var chi = VietCalendar.dayChiIndex(day.day, day.month, day.year);
    return Poem.poem[1];
  }

  String _author(DateTime day) {
    var can = VietCalendar.dayCanIndex(day.day, day.month, day.year);
    var chi = VietCalendar.dayChiIndex(day.day, day.month, day.year);
    return Author.author[1];
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimens.smallPadding),
        Text(_poem(day)),
        const SizedBox(height: Dimens.smallPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: Dimens.smallPadding),
            Text(_author(day)),
          ],
        ),
        const SizedBox(height: Dimens.smallPadding),
      ],
    );
  }
}
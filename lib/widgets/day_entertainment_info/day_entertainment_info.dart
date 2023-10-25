import 'package:flutter/cupertino.dart';
import 'package:lunar_calendar/data/author.dart';
import 'package:lunar_calendar/data/poem.dart';
import 'package:lunar_calendar/viet_calendar/viet_calendar.dart';

import '../../themes/dimens.dart';

class DayEntertainmentInfo extends StatelessWidget {

  final DateTime day;
  const DayEntertainmentInfo({super.key, required this.day});

  String _poem(DateTime day) {
    var jd = VietCalendar.jdFromDate(day.day, day.month, day.year);
    // return Author.author[Poem.poem.length - 1];
    return Poem.poem[jd % Poem.poem.length];
  }

  String _author(DateTime day) {
    var jd = VietCalendar.jdFromDate(day.day, day.month, day.year);
    // return Author.author[Author.author.length - 1];
    return Author.author[jd % Author.author.length];
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimens.mediumPadding),
        Text(_poem(day)),
        const SizedBox(height: Dimens.smallPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: Dimens.smallPadding),
            Text(_author(day)),
          ],
        ),
        const SizedBox(height: Dimens.largePadding),
      ],
    );
  }
}
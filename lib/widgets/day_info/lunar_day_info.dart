import 'package:flutter/cupertino.dart';

import '../../themes/dimens.dart';
import '../../vietnamese_calendar/vietnamese_calendar.dart';

class LunarDayInfo extends StatelessWidget {
  final DateTime lunarDay;

  const LunarDayInfo({super.key, required this.lunarDay});

  @override
  Widget build(BuildContext context) {
    var vietnameseCalendar = VietnameseCalendar(lunarDay);
    var strVietnameseDay = vietnameseCalendar.vietnameseDate.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: Dimens.smallPadding),
        const Text(
          "Âm lịch",
          style: TextStyle(fontSize: Dimens.mediumTextSize),
        ),
        const SizedBox(height: Dimens.smallPadding),
        Text(
          "${strVietnameseDay/*lunarDay.day*/}",
          style: const TextStyle(
              fontSize: Dimens.largestTextSize, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Dimens.smallPadding),
        Text(
          "Tháng ${lunarDay.month} năm ${lunarDay.year}",
          style: const TextStyle(fontSize: Dimens.mediumTextSize),
        ),
        const SizedBox(height: Dimens.smallPadding),
      ],
    );
  }
}

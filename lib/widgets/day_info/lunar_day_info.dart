import 'package:flutter/cupertino.dart';

import '../../themes/dimens.dart';
import '../../viet_calendar/viet_calendar.dart';

class LunarDayInfo extends StatelessWidget {
  final DateTime lunarDay;

  const LunarDayInfo({super.key, required this.lunarDay});

  @override
  Widget build(BuildContext context) {
    var timeZone = 7.0;
    var jd = VietCalendar.jdFromDate(lunarDay.day, lunarDay.month, lunarDay.year);
    var s = VietCalendar.jdToDate(jd);
    var l = VietCalendar.convertSolar2Lunar(s[0], s[1], s[2], timeZone);
    var s2 = VietCalendar.convertLunar2Solar(l[0], l[1], l[2], l[3], timeZone);
    if (s[0] == s2[0] && s[1] == s2[1] && s[2] == s2[2]) {
      print("OK! " + s[0].toString() + "/" + s[1].toString() + "/" + s[2].toString() + " -> " + l[0].toString() + "/" + l[1].toString() + "/" + l[2].toString() + ((l[3] == 0) ? "" : " leap"));
    } else {
      print("ERROR! " + s[0].toString() + "/" + s[1].toString() + "/" + s[2].toString() + " -> " + l[0].toString() + "/" + l[1].toString() + "/" + l[2].toString() + ((l[3] == 0) ? "" : " leap"));
    }


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
          l[0].toString(),
          style: const TextStyle(
              fontSize: Dimens.largestTextSize, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Dimens.smallPadding),
        Text(
          "Tháng ${l[1].toString()} ${(l[3] == 0) ? "" : "nhuận "}năm ${l[2].toString()}",
          style: const TextStyle(fontSize: Dimens.mediumTextSize),
        ),
        const SizedBox(height: Dimens.smallPadding),
      ],
    );
  }
}

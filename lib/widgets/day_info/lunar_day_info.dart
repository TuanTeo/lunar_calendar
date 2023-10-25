import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/colors/light_colors.dart';
import '../../themes/dimens.dart';
import '../../viet_calendar/viet_calendar.dart';

class LunarDayInfo extends StatelessWidget {
  final DateTime lunarDay;

  const LunarDayInfo({super.key, required this.lunarDay});

  @override
  Widget build(BuildContext context) {
    var jd =
        VietCalendar.jdFromDate(lunarDay.day, lunarDay.month, lunarDay.year);
    var s = VietCalendar.jdToDate(jd);
    var l = VietCalendar.convertSolar2Lunar(
        s[0], s[1], s[2], VietCalendar.TIME_ZONE);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
            right: Dimens.smallPadding,
            left: Dimens.tinyPadding,
            bottom: 0,
            top: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorConstants.lunarDayInfoBackground,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                right: Dimens.smallPadding,
                left: Dimens.smallPadding,
                bottom: Dimens.smallPadding,
                top: Dimens.smallPadding),
            child: Column(
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
                      fontSize: Dimens.largestTextSize,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: Dimens.smallPadding),
                Text(
                  "Tháng ${l[1].toString()} ${(l[3] == 0) ? "" : "nhuận "}năm ${"${VietCalendar.yearCan(l[2])} ${VietCalendar.yearChi(l[2])}"}",
                  style: const TextStyle(fontSize: Dimens.mediumTextSize),
                ),
                const SizedBox(height: Dimens.smallPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

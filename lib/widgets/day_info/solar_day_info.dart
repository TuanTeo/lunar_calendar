import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/colors/light_colors.dart';
import '../../themes/dimens.dart';

class SolarDayInfo extends StatelessWidget {
  final DateTime solarDay;

  const SolarDayInfo({super.key, required this.solarDay});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
            right: Dimens.tinyPadding,
            left: Dimens.smallPadding,
            bottom: 0,
            top: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorConstants.solarDayInfoBackground,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 0,
                left: 0,
                bottom: Dimens.smallPadding,
                top: Dimens.smallPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: Dimens.smallPadding),
                const Text(
                  "Dương lịch",
                  style: TextStyle(fontSize: Dimens.mediumTextSize),
                ),
                const SizedBox(height: Dimens.smallPadding),
                Text(
                  "${solarDay.day}",
                  style: const TextStyle(
                      fontSize: Dimens.largestTextSize,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: Dimens.smallPadding),
                Text(
                  "Tháng ${solarDay.month} năm ${solarDay.year}",
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

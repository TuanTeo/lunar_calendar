import 'package:flutter/cupertino.dart';

import '../../themes/dimens.dart';

class SolarDayInfo extends StatelessWidget {
  final DateTime solarDay;

  const SolarDayInfo({super.key, required this.solarDay});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              fontSize: Dimens.largestTextSize, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Dimens.smallPadding),
        Text(
          "Tháng ${solarDay.month} năm ${solarDay.year}",
          style: const TextStyle(fontSize: Dimens.mediumTextSize),
        ),
        const SizedBox(height: Dimens.smallPadding),
      ],
    );
  }
}

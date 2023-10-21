import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../themes/dimens.dart';
import '../../utils/event_utils.dart';

class DayEventInfo extends StatelessWidget {

  final DateTime day;
  const DayEventInfo({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    var isEventDay = EventUtils.isEventDay(day);
    var isEvent = isEventDay[0] != 0;
    var solarEvent = EventUtils.eventDayName(isEventDay[1]);
    var lunarEvent = EventUtils.eventDayName(isEventDay[2]);

    Widget createEventWidget() {
      if (isEvent) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (solarEvent.isNotEmpty)
            Text(
              AppLocalizations.of(context).event(solarEvent),
              style: const TextStyle(fontWeight: FontWeight.w200),
            ),
          if (lunarEvent.isNotEmpty)
            Text(
              AppLocalizations.of(context).event(lunarEvent),
              style: const TextStyle(fontWeight: FontWeight.w200),
            )
        ]);
      } else {
        return Text(
          AppLocalizations.of(context).eventEmpty,
          style: const TextStyle(fontWeight: FontWeight.w200),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(
        right: Dimens.largePadding, left: Dimens.largePadding, bottom: 0, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.smallPadding),
          Text(AppLocalizations.of(context).eventTitle),
          const SizedBox(height: Dimens.smallPadding),
          createEventWidget(),
          const SizedBox(height: Dimens.smallPadding),
        ],
      ),
    );
  }
}
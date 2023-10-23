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
    var isEvent = isEventDay[0][0] != 0;
    var solarEvents = isEventDay[1];
    var lunarEvents = isEventDay[2];

    List<Widget> solarEventItems = List.empty();
    List<Widget> lunarEventItems = List.empty();

    if (isEvent) {
      solarEventItems = List<Widget>.generate(
        solarEvents.length,
            (i) => Text(
          AppLocalizations.of(context).event(EventUtils.eventDayName(solarEvents[i])),
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
      );

      lunarEventItems = List<Widget>.generate(
        lunarEvents.length,
            (i) => Text(
          AppLocalizations.of(context).event(EventUtils.eventDayName(lunarEvents[i])),
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
      );
    }

    Widget createEventWidget() {
      if (isEvent) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: solarEventItems,),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: lunarEventItems,),
        ]);
      } else {
        return Text(
          AppLocalizations.of(context).eventEmpty,
          style: const TextStyle(fontWeight: FontWeight.w300),
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
          Text(
            AppLocalizations.of(context).eventTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Dimens.smallPadding),
          createEventWidget(),
          const SizedBox(height: Dimens.smallPadding),
        ],
      ),
    );
  }
}
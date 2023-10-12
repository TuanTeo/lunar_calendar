import 'package:flutter/cupertino.dart';
import 'package:lunar_calendar/themes/dimens.dart';

import '../../table_calendar_lib/widgets/calendar_page.dart';

class CalendarPageCustom extends CalendarPage {

  const CalendarPageCustom({
    super.key,
    required super.visibleDays,
    super.dowBuilder,
    required super.dayBuilder,
    super.weekNumberBuilder,
    super.dowDecoration,
    super.rowDecoration,
    super.tableBorder,
    super.tablePadding,
    super.dowVisible = true,
    super.weekNumberVisible = false,
    super.dowHeight,
  });

  @override
  TableRow paddingTableRow() {
    return TableRow(
      decoration: dowDecoration,
      children: List.generate(
        7,
        (index) => const SizedBox(height: Dimens.smallPadding),
      ).toList(),
    );
  }
}
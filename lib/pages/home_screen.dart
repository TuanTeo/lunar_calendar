import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lunar_calendar/router.dart' as router;
import 'package:lunar_calendar/themes/dimens.dart';
import 'package:lunar_calendar/widgets/table_calendar_lib_custom/calendar_widget.dart';
import 'package:lunar_calendar/widgets/day_entertainment_info/day_entertainment_info.dart';
import 'package:lunar_calendar/widgets/day_info/solar_day_info.dart';
import 'package:lunar_calendar/widgets/today_icon/today_icon.dart';

import '../table_calendar_lib/shared/utils.dart';
import '../themes/colors/light_colors.dart';
import '../widgets/card_widget.dart';
import '../widgets/day_event_info/day_event_info.dart';
import '../widgets/day_info/lunar_day_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime _startCalendarDate = DateTime.utc(1900, 1, 1);
  final DateTime _endCalendarDate = DateTime.utc(2100, 12, 31);
  final DateTime _today = DateTime.now();

  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final ScrollController _scrollController = ScrollController();

  void _onTodayPress() {
    setState(() {
      _selectedDay = DateTime.now();
    });
  }

  Future<void> _showDatePickerDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDay,
        firstDate: _startCalendarDate,
        lastDate: _endCalendarDate);

    if (picked != null) {
      setState(() {
        _selectedDay = picked;
      });
    }
  }


  void _onSelectedDateChange(DateTime selectedDate) {
    setState(() {
      _selectedDay = selectedDate;
    });
  }

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      debugPrint("HomeScreenState _onFormatChanged $format");
      _calendarFormat = format;
    });
  }

  void _onScrollDownListener() {
    if (_calendarFormat == CalendarFormat.month) {
      setState(() {
        debugPrint("HomeScreenState _onFormatChanged CalendarFormat.month");
        _calendarFormat = CalendarFormat.week;
      });
    }
  }

  void _onScrollUpListener() {
    if (_calendarFormat == CalendarFormat.week) {
      setState(() {
        debugPrint("HomeScreenState _onFormatChanged CalendarFormat.week");
        _calendarFormat = CalendarFormat.month;
      });
    }
  }

  Widget _bodyHomeScreen() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      color: ColorConstants.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.smallPadding),
        child: Column(
          children: <Widget>[
            CardWidget(
              child: CalendarWidget(
                  today: _selectedDay,
                  startCalendarDate: _startCalendarDate,
                  endCalendarDate: _endCalendarDate,
                  onSelectedDayChange: _onSelectedDateChange,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: _onFormatChanged,
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (_scrollController.position.userScrollDirection ==
                          ScrollDirection.reverse
                      && _scrollController.position.pixels == 0) {
                    // debugPrint('down _scrollController.position.pixels ${_scrollController.position.pixels}');
                    _onScrollDownListener();
                  } else if (_scrollController.position.userScrollDirection ==
                          ScrollDirection.forward
                      && _scrollController.position.pixels == 0) {
                    _onScrollUpListener();
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 0,
                            left: 0,
                            bottom: Dimens.smallPadding,
                            top: Dimens.smallPadding),
                        child: CardWidget(
                            // bgImage: 'lib/assets/images/bg_day_info.jpg',
                          bgColor: ColorConstants.backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SolarDayInfo(solarDay: _selectedDay),
                                LunarDayInfo(lunarDay: _selectedDay),
                              ],
                            ))),
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 0, left: 0, bottom: Dimens.smallPadding, top: 0),
                        child: CardWidget(
                          // bgImage: 'lib/assets/images/bg_day_event.jpg',
                          child: Row(
                            children: [
                              Expanded(child: DayEventInfo(day: _selectedDay)),
                            ],
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 0, left: 0, bottom: Dimens.smallPadding, top: 0),
                        child: CardWidget(
                          minHeight: 200,
                          // bgImage: 'lib/assets/images/bg_day_event.jpg',
                          child: Row(
                            children: [
                              Expanded(
                                  child: DayEntertainmentInfo(day: _selectedDay)),
                            ],
                          ),
                        )),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homeTitle),
        actions: [
          IconButton(
            icon: TodayIcon(date: _today),
            tooltip: AppLocalizations.of(context).todayActionDescription,
            onPressed: () {
              _onTodayPress();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: AppLocalizations.of(context).chooseDate,
            onPressed: () {
              _showDatePickerDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: AppLocalizations.of(context).settingActionDescription,
            onPressed: () {
              // Navigator.pushNamed(context, router.settingScreen);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: !kIsWeb
            ? _bodyHomeScreen()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _bodyHomeScreen(),
                ],
              ),
      ),
    );
  }
}
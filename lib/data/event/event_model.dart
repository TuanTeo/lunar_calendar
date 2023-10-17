import 'package:lunar_calendar/data/event/event_database_helper.dart';

class Event {
  final int? id;
  final String name;
  final String date;
  final bool isLunar;

  const Event({
    this.id,
    required this.name,
    required this.date,
    required this.isLunar
  });

  // Convert a Event into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      EventDBHelper.ID_COLUMN: id,
      EventDBHelper.EVENT_NAME_COLUMN: name,
      EventDBHelper.EVENT_DATE_COLUMN: date,
      EventDBHelper.IS_LUNAR_COLUMN: isLunar
    };
  }
}
import 'package:sqflite/sqflite.dart' as sql;

import 'event_model.dart';
import '../event/event_default_data.dart';

class EventDBHelper {
  /// Database
  static const String EVENT_DATABASE = 'events.db';
  static const int DB_VERSION = 1;

  /// Table
  static const String EVENT_TABLE_NAME = 'event';

  /// Column
  static const String ID_COLUMN = 'id';
  static const String EVENT_NAME_COLUMN = 'name';
  static const String EVENT_DATE_COLUMN = 'date';
  static const String IS_LUNAR_COLUMN = 'is_lunar';

  /// Create table
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE $EVENT_TABLE_NAME(
        $ID_COLUMN INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $EVENT_NAME_COLUMN TEXT,
        $EVENT_DATE_COLUMN TEXT,
        $IS_LUNAR_COLUMN BOOLEAN NOT NULL DEFAULT false
      )
      """);

    /* Add default events data */
    for (var event in listDefaultEvent) {
      addDefaultData(database, event);
    }
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      EVENT_DATABASE,
      version: DB_VERSION,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

  static Future<void> addDefaultData(sql.Database database, Event event) async {
    await database.execute("""INSERT INTO $EVENT_TABLE_NAME(
        "$EVENT_NAME_COLUMN",
        "$EVENT_DATE_COLUMN",
        "$IS_LUNAR_COLUMN"
      ) VALUES ("${event.name}", "${event.date}", "${event.isLunar}")
      """);
  }

  // Create new event item
  static Future<int> createEvent(Event event) async {
    final db = await EventDBHelper.db();
    final id = await db.insert(EVENT_TABLE_NAME, event.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all event items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await EventDBHelper.db();
    return db.query(EVENT_TABLE_NAME, orderBy: ID_COLUMN);
  }

  static Future<List<Event>> getEvents() async {
    // Get a reference to the database.
    final db = await EventDBHelper.db();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await db.query(EVENT_TABLE_NAME, orderBy: ID_COLUMN);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i][ID_COLUMN],
        name: maps[i][EVENT_NAME_COLUMN],
        date: maps[i][EVENT_DATE_COLUMN],
        isLunar: maps[i][IS_LUNAR_COLUMN] == 1 ? true : false
      );
    });
  }
}
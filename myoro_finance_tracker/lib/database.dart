import 'package:myoro_finance_tracker/helpers/platform_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Database {
  static late sqflite.Database _database;

  static Future<String> getDatabasePath() async => join(
        (await getApplicationSupportDirectory()).path,
        'myoro_finance_tracker.db',
      );

  static Future<void> init() async {
    if (PlatformHelper.isDesktop) sqflite.databaseFactory = databaseFactoryFfi;

    _database = await sqflite.openDatabase(await getDatabasePath());

    // Dark mode table
    await _database.execute('CREATE TABLE IF NOT EXISTS dark_mode(id INTEGER PRIMARY KEY, enabled INTEGER);');
    if ((await get('dark_mode')).isEmpty) insert('dark_mode', {'enabled': 1});

    // Finances cubit
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS finances(
        id    INTEGER PRIMARY KEY AUTOINCREMENT,
        name  TEXT,
        spent TEXT,
        date  TEXT
      );
    ''');
  }

  static Future<List<Map<String, Object?>>> select(
    String table, [
    String? where,
    List<Object?>? whereArgs,
  ]) async =>
      await _database.query(table, where: where, whereArgs: whereArgs);

  static Future<Map<String, Object?>> get(
    String table, [
    String? where,
    List<Object?>? whereArgs,
  ]) async {
    final List<Map<String, Object?>> rows = await select(table, where, whereArgs);
    return rows.isEmpty ? {} : rows[0];
  }

  static Future<void> insert(String table, Map<String, Object?> data) async => _database.insert(table, data);

  static Future<void> update(
    String table,
    Map<String, Object?> data, [
    String? where,
    List<Object?>? whereArgs,
  ]) async =>
      _database.update(table, data, where: where, whereArgs: whereArgs);
}

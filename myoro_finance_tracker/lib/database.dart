import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/enums/paying_or_receiving_enum.dart';
import 'package:myoro_finance_tracker/enums/payment_frequency_enum.dart';
import 'package:myoro_finance_tracker/helpers/platform_helper.dart';
import 'package:myoro_finance_tracker/models/timely_payment_model.dart';
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

    // Finances
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS finances(
        id    INTEGER PRIMARY KEY AUTOINCREMENT,
        name  TEXT,
        spent TEXT,
        date  TEXT
      );
    ''');

    // Goals
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS goals(
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        name        TEXT,
        goal_amount TEXT,
        finish_date TEXT
      );
    ''');

    // Total income
    await _database.execute('CREATE TABLE IF NOT EXISTS total_income(id INTEGER PRIMARY KEY, income TEXT);');
    if ((await get('total_income')).isEmpty) insert('total_income', {'income': '0'});

    // Timely payments
    await _database.execute('''
      CREATE TABLE IF NOT EXISTS timely_payments(
        id                  INTEGER PRIMARY KEY AUTOINCREMENT,
        name                TEXT,
        spent               TEXT,
        date_paid           TEXT,
        payment_frequency   TEXT,
        paying_or_receiving TEXT
      );
    ''');
    // Checking if any payments are due
    final List<TimelyPaymentModel> timelyPayments = (await select('timely_payments')).map((json) => TimelyPaymentModel.fromJSON(json)).toList();
    for (final TimelyPaymentModel timelyPayment in timelyPayments) {
      if (timelyPayment.datePaid.isBefore(DateTime.now())) {
        if (timelyPayment.payingOrReceiving == PayingOrReceivingEnum.paying) {
          await update(
            'total_income',
            {
              'income': double.parse((await get('total_income'))['income'] as String) - timelyPayment.spent,
            },
          );
        } else {
          await update(
            'total_income',
            {
              'income': double.parse((await get('total_income'))['income'] as String) + timelyPayment.spent,
            },
          );
        }

        late final String data;
        switch (timelyPayment.paymentFrequency) {
          case PaymentFrequencyEnum.daily:
            data = DateFormat('dd/MM/yyyy').format(timelyPayment.datePaid.add(const Duration(days: 1)));
            break;
          case PaymentFrequencyEnum.weekly:
            data = DateFormat('dd/MM/yyyy').format(timelyPayment.datePaid.add(const Duration(days: 7)));
            break;
          case PaymentFrequencyEnum.monthly:
            data = DateFormat('dd/MM/yyyy').format(
              DateTime(timelyPayment.datePaid.year, timelyPayment.datePaid.month + 1, timelyPayment.datePaid.day),
            );
            break;
          case PaymentFrequencyEnum.yearly:
            data = DateFormat('dd/MM/yyyy').format(
              DateTime(timelyPayment.datePaid.year + 1, timelyPayment.datePaid.month, timelyPayment.datePaid.day),
            );
            break;
        }

        await update(
          'timely_payments',
          {'date_paid': data},
          timelyPayment.toJSON,
        );
      }
    }
  }

  static Future<void> reset() async {
    if (PlatformHelper.isDesktop) sqflite.databaseFactory = databaseFactoryFfi;
    await sqflite.deleteDatabase(await getDatabasePath());
  }

  static Future<List<Map<String, Object?>>> select(String table, [Map<String, dynamic>? conditions]) async {
    conditions = formatConditions(conditions);
    return await _database.query(table, where: conditions?['where'], whereArgs: conditions?['where_args']);
  }

  static Future<Map<String, Object?>> get(String table, [Map<String, dynamic>? conditions]) async {
    final List<Map<String, Object?>> rows = await select(table, conditions);
    return rows.isEmpty ? {} : rows[0];
  }

  static Future<void> insert(String table, Map<String, Object?> data) async => _database.insert(table, data);

  static Future<void> update(String table, Map<String, Object?> data, [Map<String, dynamic>? conditions]) async {
    conditions = formatConditions(conditions);
    await _database.update(
      table,
      data,
      where: conditions?['where'],
      whereArgs: conditions?['where_args'],
    );
  }

  static Future<void> delete(String table, [Map<String, dynamic>? conditions]) async {
    conditions = formatConditions(conditions);
    await _database.delete(table, where: conditions?['where'], whereArgs: conditions?['where_args']);
  }

  static Map<String, dynamic>? formatConditions(Map<String, Object?>? conditions) {
    if (conditions == null) return null;

    final List<MapEntry> conditionsList = conditions.entries.toList();
    String where = '';
    final List<Object?> whereArgs = [];
    for (final MapEntry entry in conditionsList) {
      if (entry.key != 'id') {
        where += '${entry.key} = ?${conditionsList.indexOf(entry) != conditionsList.length - 1 ? ' AND ' : ''}';
        whereArgs.add(entry.value);
      }
    }

    return {'where': where, 'where_args': whereArgs};
  }
}

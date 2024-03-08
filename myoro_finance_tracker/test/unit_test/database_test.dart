import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // ignore: deprecated_member_use
    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationSupportDirectory') return '.';
    });
  });

  test('Database.getDatabasePath', () async {
    expect(
      (await Database.getDatabasePath()).contains('myoro_finance_tracker.db'),
      isTrue,
    );
  });

  test('Database.formatConditions', () async {
    expect(
      Database.formatConditions({
        'foo': 5,
        'foo_foo': 10,
        'fi_fi': 'boo_boo',
      }),
      {
        'where': 'foo = ? AND foo_foo = ? AND fi_fi = ?',
        'where_args': [ 5, 10, 'boo_boo' ],
      },
    );
  });
}
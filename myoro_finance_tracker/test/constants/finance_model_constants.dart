import 'dart:math';

import 'package:myoro_finance_tracker/models/finance_model.dart';

class FinanceModelConstants {
  static FinanceModel get finance => FinanceModel(
        id: 0,
        name: 'Finance Model Constant',
        spent: Random().nextDouble() * 9000000,
        date: DateTime.now(),
      );
}

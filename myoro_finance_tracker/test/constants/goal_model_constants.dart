import 'dart:math';

import 'package:myoro_finance_tracker/models/goal_model.dart';

class GoalModelConstants {
  static GoalModel get goal => GoalModel(
        name: 'GoalModel Constant',
        goalAmount: Random().nextDouble() * 90000000,
        finishDate: DateTime.now(),
      );
}

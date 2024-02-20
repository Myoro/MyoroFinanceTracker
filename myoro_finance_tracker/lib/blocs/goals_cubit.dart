import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/database.dart';
import 'package:myoro_finance_tracker/models/goal_model.dart';

class GoalsCubit extends Cubit<List<GoalModel>> {
  GoalsCubit(super.goals);

  void add(GoalModel goal) async {
    await Database.insert('goals', goal.toJSON);
    final GoalModel result = GoalModel.fromJSON(await Database.get('goals', goal.toJSON));
    emit(state..add(result));
  }

  void remove(GoalModel goal) async {
    await Database.delete('goals', goal.toJSON);
    emit(state..remove(goal));
  }
}
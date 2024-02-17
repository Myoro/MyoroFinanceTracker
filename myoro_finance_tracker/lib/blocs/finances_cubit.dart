import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/database.dart';
import 'package:myoro_finance_tracker/models/finance_model.dart';

class FinancesCubit extends Cubit<List<FinanceModel>> {
  FinancesCubit(super.finances);

  void add(FinanceModel finance) async {
    await Database.insert('finances', finance.toJSON);

    final List<FinanceModel> finances = (await Database.select('finances')).map((json) => FinanceModel.fromJSON(json)).toList();
    final FinanceModel financeWithId = finances.last;

    emit(state..add(financeWithId));
  }

  // TODO: Remove from database
  void remove(FinanceModel finance) => emit(state..remove(finance));
}

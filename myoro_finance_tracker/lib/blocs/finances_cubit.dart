import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/database.dart';
import 'package:myoro_finance_tracker/models/finance_model.dart';

class FinancesCubit extends Cubit<List<FinanceModel>> {
  FinancesCubit(super.finances);

  void add(FinanceModel finance) async {
    await Database.insert('finances', finance.toJSON);
    final FinanceModel result = FinanceModel.fromJSON(await Database.get('finances', finance.toJSON));
    emit(state..add(result));
  }

  void update(FinanceModel oldFinance, FinanceModel newFinance) async {
    await Database.update('finances', newFinance.toJSON, oldFinance.toJSON);
    final FinanceModel result = FinanceModel.fromJSON(await Database.get('finances', newFinance.toJSON));
    final List<FinanceModel> finances = List.from(state);
    finances[finances.indexOf(oldFinance)] = result;
    emit(finances);
  }

  void remove(FinanceModel finance) async {
    await Database.delete('finances', finance.toJSON);
    emit(state..remove(finance));
  }
}

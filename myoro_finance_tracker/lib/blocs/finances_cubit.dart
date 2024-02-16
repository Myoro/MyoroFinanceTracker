import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/models/finance_model.dart';

class FinancesCubit extends Cubit<List<FinanceModel>> {
  FinancesCubit(super.finances);
  void add(FinanceModel finance) => emit(state..add(finance));
  void remove(FinanceModel finance) => emit(state..remove(finance));
}
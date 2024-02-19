import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/database.dart';

class TotalIncomeCubit extends Cubit<double> {
  TotalIncomeCubit(super.totalIncome);

  void add(double totalIncome) async {
    await Database.update('total_income', {'income': totalIncome.toStringAsFixed(2)});
    emit(totalIncome);
  }
}

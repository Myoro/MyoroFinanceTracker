import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/database.dart';
import 'package:myoro_finance_tracker/models/timely_payment_model.dart';

class TimelyPaymentsCubit extends Cubit<List<TimelyPaymentModel>> {
  TimelyPaymentsCubit(super.timelyPayments);

  void add(TimelyPaymentModel timelyPayment) async {
    Database.insert('timely_payments', timelyPayment.toJSON);
    emit(state..add(timelyPayment));
  }

  void remove(TimelyPaymentModel timelyPayment) async {
    Database.delete('timely_payments', timelyPayment.toJSON);
    emit(state..remove(timelyPayment));
  }
}

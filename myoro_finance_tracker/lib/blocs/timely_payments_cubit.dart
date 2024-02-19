import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/models/timely_payment.dart';

class TimelyPaymentsCubit extends Cubit<List<TimelyPayment>> {
  TimelyPaymentsCubit(super.timelyPayments);
}

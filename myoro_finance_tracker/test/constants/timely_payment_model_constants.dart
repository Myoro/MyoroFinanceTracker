import 'dart:math';

import 'package:myoro_finance_tracker/enums/paying_or_receiving_enum.dart';
import 'package:myoro_finance_tracker/enums/payment_frequency_enum.dart';
import 'package:myoro_finance_tracker/models/timely_payment_model.dart';

class TimelyPaymentModelConstants {
  static TimelyPaymentModel get timelyPayment => TimelyPaymentModel(
        name: 'TimelyPaymentModel Constant',
        spent: Random().nextDouble() * 9000000,
        datePaid: DateTime.now(),
        paymentFrequency: PaymentFrequencyEnum.values[Random().nextInt(PaymentFrequencyEnum.values.length)],
        payingOrReceiving: PayingOrReceivingEnum.values[Random().nextInt(PayingOrReceivingEnum.values.length)],
      );
}

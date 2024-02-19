import 'package:myoro_finance_tracker/enums/paying_or_receiving_enum.dart';
import 'package:myoro_finance_tracker/enums/payment_frequency_enum.dart';

class TimelyPayment {
  final String? name;
  final double spent;
  final DateTime datePaid;
  final PaymentFrequencyEnum paymentFrequency;
  final PayingOrReceivingEnum payingOrReceiving;

  TimelyPayment({
    this.name,
    required this.spent,
    required this.datePaid,
    required this.paymentFrequency,
    required this.payingOrReceiving,
  });

  TimelyPayment.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        spent = json['spent'],
        datePaid = json['date_paid'],
        paymentFrequency = json['payment_frequency'],
        payingOrReceiving = json['paying_or_receiving'];
}

import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/enums/paying_or_receiving_enum.dart';
import 'package:myoro_finance_tracker/enums/payment_frequency_enum.dart';

class TimelyPaymentModel {
  final String? name;
  final double spent;
  final DateTime datePaid;
  final PaymentFrequencyEnum paymentFrequency;
  final PayingOrReceivingEnum payingOrReceiving;

  TimelyPaymentModel({
    this.name,
    required this.spent,
    required this.datePaid,
    required this.paymentFrequency,
    required this.payingOrReceiving,
  });

  TimelyPaymentModel.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        spent = double.parse(json['spent']),
        datePaid = DateFormat('dd/MM/yyyy').parse(json['date_paid']),
        paymentFrequency = PaymentFrequencyEnum.values.firstWhere((value) => value.title.toLowerCase() == json['payment_frequency']),
        payingOrReceiving = PayingOrReceivingEnum.values.firstWhere((value) => value.title.toLowerCase() == json['paying_or_receiving']);

  Map<String, Object?> get toJSON => {
        'name': name,
        'spent': spent,
        'date_paid': DateFormat('dd/MM/yyyy').format(datePaid),
        'payment_frequency': paymentFrequency.name,
        'paying_or_receiving': payingOrReceiving.name,
      };
}

import 'package:intl/intl.dart';

class FinanceModel {
  final int? id;
  final String? name;
  final double spent;
  final DateTime date;

  const FinanceModel({
    required this.spent,
    required this.date,
    this.id,
    this.name,
  });

  FinanceModel.fromJSON(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      spent = json['spent'],
      date = DateFormat('dd/MM/yyyy').parse(json['date']);
}

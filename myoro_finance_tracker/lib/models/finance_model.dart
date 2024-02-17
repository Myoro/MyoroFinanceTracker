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
        spent = double.parse(json['spent']),
        date = DateFormat('dd/MM/yyyy').parse(json['date']);

  Map<String, Object?> get toJSON => {
        'id': id,
        'name': name,
        'spent': spent,
        'date': DateFormat('dd/MM/yyyy').format(date),
      };

  @override
  String toString() => '''
    FinanceModel(
      id: $id,
      name: $name,
      spent: $spent,
      date: ${DateFormat('dd/MM/yyyy').format(date)},
    );
  ''';
}

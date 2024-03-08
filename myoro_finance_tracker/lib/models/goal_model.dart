import 'package:intl/intl.dart';

class GoalModel {
  final String? name;
  final double goalAmount;
  final DateTime? finishDate;

  GoalModel({
    this.name,
    required this.goalAmount,
    required this.finishDate,
  });

  GoalModel.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        goalAmount = double.parse(json['goal_amount']),
        finishDate = json['finish_date'] != null ? DateFormat('dd/MM/yyyy').parse(json['finish_date']) : null;

  Map<String, Object?> get toJSON => {
        'name': name,
        'goal_amount': goalAmount,
        'finish_date': finishDate != null ? DateFormat('dd/MM/yyyy').format(finishDate!) : '',
      };

  @override
  String toString() => '''
    GoalModel(
      name: $name,
      goalAmount: $goalAmount,
      finishDate: $finishDate,
    ),
  ''';
}

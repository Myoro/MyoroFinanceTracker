class FinanceModel {
  final int id;
  final String? name;
  final double spent;
  final DateTime date;

  const FinanceModel({
    required this.id,
    required this.spent,
    required this.date,
    this.name,
  });
}

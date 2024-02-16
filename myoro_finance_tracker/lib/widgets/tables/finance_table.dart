import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/models/finance_model.dart';
import 'package:myoro_finance_tracker/widgets/bodies/home_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/tables/base_table.dart';

/// Table in which all finances of the user is shown
///
/// Used in [HomeScreenBody]
class FinanceTable extends StatelessWidget {
  const FinanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle bodyMedium = Theme.of(context).textTheme.bodyMedium!;

    return BaseTable(
      titleRow: const ['Name', 'Spent'],
      // TODO: Remove this mock
      rows: List.generate(5, (_) => const FinanceModel(name: 'Test', spent: 123)),
      builder: (finance) => TableRow(
        children: [
          Text(
            finance.name ?? '',
            style: bodyMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            finance.spent.toStringAsFixed(2),
            style: bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

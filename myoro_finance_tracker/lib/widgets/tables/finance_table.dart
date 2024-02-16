import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;

    return BaseTable(
      titleRow: [
        if (screenWidth > 400) 'ID',
        'Name',
        'Spent',
        if (screenWidth > 500) 'Date',
      ],
      // TODO: Remove this mock
      rows: List.generate(20, (_) => FinanceModel(id: _ + 1, name: 'Test', spent: 123, date: DateTime.now())),
      builder: (finance) => TableRow(
        children: [
          if (screenWidth > 400) _Text(finance.id.toString()),
          _Text(finance.name ?? ''),
          _Text('\$${finance.spent.toStringAsFixed(2)}'),
          if (screenWidth > 500) _Text(DateFormat('dd/MM/yyyy').format(finance.date)),
        ],
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;

  const _Text(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
}

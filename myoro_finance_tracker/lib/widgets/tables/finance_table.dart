import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/blocs/finances_cubit.dart';
import 'package:myoro_finance_tracker/models/finance_model.dart';
import 'package:myoro_finance_tracker/widgets/bodies/home_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_text_hover_button.dart';
import 'package:myoro_finance_tracker/widgets/tables/base_table.dart';

/// Table in which all finances of the user is shown
///
/// Used in [HomeScreenBody]
class FinanceTable extends StatelessWidget {
  const FinanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool showID = screenWidth > 480;
    final bool showDate = screenWidth > 580;

    final List<String> titleColumns = ['ID', 'Name', 'Spent', 'Date', '', ''];
    if (!showID) titleColumns.remove('ID');
    if (!showDate) titleColumns.remove('Date');

    return BlocBuilder<FinancesCubit, List<FinanceModel>>(
      builder: (context, finances) => BaseTable(
        columnWidths: {
          titleColumns.length - 2: const FixedColumnWidth(36),
          titleColumns.length - 1: const FixedColumnWidth(36),
        },
        titleRow: titleColumns,
        rows: finances,
        builder: (finance) => TableRow(
          children: [
            if (showID) _Text(finance.id.toString()),
            _Text(finance.name ?? ''),
            _Text('\$${finance.spent.toStringAsFixed(2)}'),
            if (showDate) _Text(DateFormat('dd/MM/yyyy').format(finance.date)),
            Padding(
              padding: const EdgeInsets.only(top: 2.5),
              child: IconTextHoverButton(
                onTap: () {}, // TODO
                icon: Icons.edit,
                iconSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.5),
              child: IconTextHoverButton(
                onTap: () {}, // TODO
                icon: Icons.delete,
                iconSize: 20,
              ),
            ),
          ],
        ),
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

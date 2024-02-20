import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';

/// [Widget] in which all tables will be created from
class BaseTable<T> extends StatefulWidget {
  /// [String]s containing each column of the title row
  final List<String> titleRow;

  /// Table rows/data
  final List<T> rows;

  /// [TableRow] builder
  final TableRow Function(T) builder;

  /// (Optional) [Map] of specific columns to have a specific width
  final Map<int, TableColumnWidth>? columnWidths;

  const BaseTable({
    super.key,
    required this.titleRow,
    required this.rows,
    required this.builder,
    this.columnWidths,
  });

  @override
  State<BaseTable<T>> createState() => _BaseTableState<T>();
}

class _BaseTableState<T> extends State<BaseTable<T>> {
  final ValueNotifier<int> _pageNumber = ValueNotifier<int>(1);

  @override
  void dispose() {
    _pageNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ValueListenableBuilder(
        valueListenable: _pageNumber,
        builder: (context, pageNumber, child) {
          final int pageNumberStartingIndex = (pageNumber - 1) * 10 - 1 != -1 ? (pageNumber - 1) * 10 : 0;

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.colorScheme.onPrimary,
                    width: 2,
                  ),
                ),
                child: Table(
                  columnWidths: widget.columnWidths,
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(5),
                          topRight: const Radius.circular(5),
                          bottomLeft: widget.rows.isEmpty ? const Radius.circular(5) : Radius.zero,
                          bottomRight: widget.rows.isEmpty ? const Radius.circular(5) : Radius.zero,
                        ),
                      ),
                      children: [for (final String column in widget.titleRow) _TitleColumn(column)],
                    ),
                    for (int i = pageNumberStartingIndex; i < pageNumberStartingIndex + 10; i++)
                      if (i <= widget.rows.length - 1) widget.builder(widget.rows[i]),
                  ],
                ),
              ),
              if (widget.rows.length > 10) ...[
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButtonWithoutFeedback(
                      icon: Icons.arrow_left,
                      size: 30,
                      onTap: () {
                        if (pageNumber > 1 && pageNumber <= widget.rows.length ~/ 10) {
                          _pageNumber.value -= 1;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        pageNumber.toString(),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    IconButtonWithoutFeedback(
                      icon: Icons.arrow_right,
                      size: 30,
                      onTap: () {
                        if (pageNumber < widget.rows.length ~/ 10) {
                          _pageNumber.value += 1;
                        }
                      },
                    ),
                  ],
                ),
              ],
            ],
          );
        });
  }
}

class _TitleColumn extends StatelessWidget {
  final String text;

  const _TitleColumn(this.text);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Wrap(
      spacing: 5,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          text,
          style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
        ),
      ],
    );
  }
}

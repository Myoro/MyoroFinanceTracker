import 'package:flutter/material.dart';

/// [Widget] in which all tables will be created from
class BaseTable<T> extends StatelessWidget {
  final List<String> titleRow;

  /// Table rows/data
  final List<T> rows;

  /// [TableRow] builder
  final TableRow Function(T) builder;

  const BaseTable({
    super.key,
    required this.titleRow,
    required this.rows,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Table(
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft: rows.isEmpty ? const Radius.circular(10) : Radius.zero,
              bottomRight: rows.isEmpty ? const Radius.circular(10) : Radius.zero,
            ),
          ),
          children: [
            for (final String column in titleRow)
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  column,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
        for (final T row in rows) builder(row)
      ],
    );
  }
}

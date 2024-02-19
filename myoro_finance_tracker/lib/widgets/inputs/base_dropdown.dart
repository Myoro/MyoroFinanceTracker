import 'package:flutter/material.dart';

/// [Widget] that all dropdowns (every in this directory) derives from
class BaseDropdown extends StatefulWidget {
  /// Contents of [BaseDropdown]
  final List<String> items;

  /// Function to get the value [BaseDropdown]
  final Function(String) onChanged;

  /// (Optional) width [DropdownButton]
  final double? width;

  const BaseDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.width,
  });

  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
  final ValueNotifier<String?> _selected = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _selected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: _selected,
      builder: (context, selected, child) => SizedBox(
        width: widget.width,
        child: DropdownButton<String>(
          value: selected,
          padding: EdgeInsets.zero,
          isExpanded: true,
          underline: Container(
            width: double.infinity,
            height: 2,
            color: theme.colorScheme.onPrimary,
          ),
          onChanged: (value) {
            widget.onChanged(value!);
            _selected.value = value;
          },
          items: widget.items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/inputs/base_dropdown.dart';

/// The dropdown for of the application
class BaseDropdownForm extends StatelessWidget {
  /// Title of [BaseTextFieldForm]
  final String title;

  /// Items of [BaseDropdown]
  final List<String> items;

  /// onChanged of [BaseDropdown] to get it's value
  final Function(String) onChanged;

  /// If [BaseDropdownForm] is obligatory, will show a * next to the title
  final bool obligatory;

  /// (Optional) Width of title [Text]
  final double? titleWidth;

  /// (Optional) Width of [BaseDropdown]
  final double? dropdownWidth;

  /// (Optional) [TextStyle] of title
  final TextStyle? titleTextStyle;

  const BaseDropdownForm({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.obligatory = false,
    this.titleWidth,
    this.dropdownWidth,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          SizedBox(
            width: titleWidth,
            child: Text(
              '$title:${obligatory ? ' *' : ''}',
              textAlign: TextAlign.center,
              style: titleTextStyle ?? Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 24),
          BaseDropdown(
            items: items,
            onChanged: onChanged,
            width: dropdownWidth,
          ),
        ],
      );
}

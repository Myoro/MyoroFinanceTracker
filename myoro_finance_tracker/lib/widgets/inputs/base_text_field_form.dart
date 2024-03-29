import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myoro_finance_tracker/enums/size_enum.dart';
import 'package:myoro_finance_tracker/widgets/inputs/base_text_field.dart';

/// Base form with a title [Text] and [TextField]
class BaseTextFieldForm extends StatelessWidget {
  /// Title of [BaseTextFieldForm]
  final String title;

  /// [SizeEnum] of [BaseTextField]
  final SizeEnum size;

  /// Width of [BaseTextField]
  final double textFieldWidth;

  /// If [BaseTextFieldForm] is obligatory, will show a * next to the title
  final bool obligatory;

  /// (Optional) Width of title [Text]
  final double? titleWidth;

  /// (Optional) Input formatters of [TextField] in [BaseTextField]
  final List<TextInputFormatter> formatters;

  /// (Optional) Focus node of [TextField] in [BaseTextField]
  final FocusNode? focusNode;

  /// (Optional) [TextStyle] of title
  final TextStyle? titleTextStyle;

  /// [TextEditingController of [TextField] in [BaseTextField]
  final TextEditingController controller;

  const BaseTextFieldForm({
    super.key,
    required this.title,
    required this.textFieldWidth,
    required this.controller,
    this.obligatory = false,
    this.formatters = const [],
    this.focusNode,
    this.size = SizeEnum.medium,
    this.titleWidth,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: titleWidth,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '$title:${obligatory ? ' *' : ''}',
                textAlign: TextAlign.center,
                style: titleTextStyle ?? Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(width: 10),
          BaseTextField(
            size: size,
            width: textFieldWidth,
            controller: controller,
            focusNode: focusNode,
            formatters: formatters,
          ),
        ],
      );
}

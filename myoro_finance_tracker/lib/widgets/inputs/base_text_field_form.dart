import 'package:flutter/material.dart';
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

  /// (Optional) Width of title [Text]
  final double? titleWidth;

  /// (Optional) Focus node of [TextField] in [BaseTextField]
  final FocusNode? focusNode;

  /// [TextEditingController of [TextField] in [BaseTextField]
  final TextEditingController controller;

  const BaseTextFieldForm({
    super.key,
    required this.title,
    required this.textFieldWidth,
    required this.controller,
    this.focusNode,
    this.size = SizeEnum.medium,
    this.titleWidth,
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
            '$title:',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      const SizedBox(width: 10),
      BaseTextField(
        size: size,
        width: textFieldWidth,
        controller: controller,
        focusNode: focusNode,
      ),
    ],
  );
}
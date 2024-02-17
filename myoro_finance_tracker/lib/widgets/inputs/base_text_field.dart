import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myoro_finance_tracker/enums/size_enum.dart';

/// Widget that replaces [TextField] in our application
class BaseTextField extends StatelessWidget {
  /// [SizeEnum] (small, medium, or large) of [BaseTextField]
  final SizeEnum size;

  /// (Optional) Widget of [BaseTextField]
  final double? width;

  /// (Optional) List of input formatters that [TextField] will use
  final List<TextInputFormatter> formatters;

  /// (Optional) [FocusNode] of [TextField]
  final FocusNode? focusNode;

  /// [TextEditingController] of [TextField]
  final TextEditingController controller;

  const BaseTextField({
    super.key,
    required this.controller,
    this.formatters = const [],
    this.focusNode,
    this.size = SizeEnum.medium,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    late final TextStyle textStyle;
    late final double height;
    final UnderlineInputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: theme.colorScheme.onPrimary,
      ),
    );

    switch (size) {
      case SizeEnum.small:
        textStyle = theme.textTheme.bodySmall!;
        height = 36;
        break;
      case SizeEnum.medium:
        textStyle = theme.textTheme.bodyMedium!;
        height = 46;
        break;
      case SizeEnum.large:
        textStyle = theme.textTheme.bodyLarge!;
        height = 56;
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        inputFormatters: formatters,
        style: textStyle,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}

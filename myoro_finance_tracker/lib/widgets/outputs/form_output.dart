import 'package:flutter/material.dart';

/// [Widget] to display a piece of information with a title attached to it
class FormOutput extends StatelessWidget {
  /// Title of [FormOutput]
  final String title;

  /// Message/output of [FormOutput]
  final String output;

  const FormOutput({
    super.key,
    required this.title,
    required this.output,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title:',
          style: textTheme.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: 10),
        Text(
          output,
          style: textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

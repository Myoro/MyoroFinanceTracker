import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth - 65,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: theme.colorScheme.onPrimary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: theme.colorScheme.onPrimary,
                ),
                width: (constraints.maxWidth - 65) / 2,
                height: 20,
              ),
            ),
          );
        }),
        Text(
          '100%',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

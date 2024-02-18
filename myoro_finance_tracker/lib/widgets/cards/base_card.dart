import 'package:flutter/material.dart';

/// [Widget] that all card files (i.e. files in this directory) will derive from
class BaseCard extends StatelessWidget {
  /// Contents of [BaseCard]
  final Widget content;

  /// (Optional) width of [BaseCard]
  final double? width;

  /// (Optional) height of [BaseCard]
  final double? height;

  const BaseCard({
    super.key,
    required this.content,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: content,
        ),
      );
}

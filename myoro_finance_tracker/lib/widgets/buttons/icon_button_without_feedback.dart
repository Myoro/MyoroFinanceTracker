import 'package:flutter/material.dart';

/// Button without feedback that only contains an [Icon]
class IconButtonWithoutFeedback extends StatelessWidget {
  /// Icon of the button
  final IconData icon;

  /// Size of the icon
  final double size;

  /// FUnction called when the button is tapped
  final Function onTap;

  const IconButtonWithoutFeedback({
    super.key,
    required this.icon,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => onTap(),
        child: Icon(
          icon,
          size: size,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
}

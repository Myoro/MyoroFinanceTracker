import 'package:flutter/material.dart';

/// Simple button without feedback that accepts a [Widget]
class ButtonWithoutFeedback extends StatelessWidget {
  /// Function called when [ButtonWithoutFeedback] is tapped
  final Function onTap;

  /// [Widget] that [ButtonWithoutFeedback] accepts
  final Widget child;

  const ButtonWithoutFeedback({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => onTap(),
        child: child,
      );
}

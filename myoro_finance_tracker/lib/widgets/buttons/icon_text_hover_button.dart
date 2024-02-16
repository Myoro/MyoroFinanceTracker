import 'package:flutter/material.dart';

/// Hover button that can hold an [Icon] and/or a [Text] widget
class IconTextHoverButton extends StatefulWidget {
  /// Function that is executed when [IconTextHoverButton] is tapped
  final Function onTap;

  /// (Optional) Text of [Text] of [IconTextHoverButton]
  final String? text;

  /// (Optional) [IconData] of [Icon] of [IconTextHoverButton]
  final IconData? icon;

  /// Size of [Icon]
  final double? iconSize;

  /// If [IconTextHoverButton] has a rounded border around it
  final bool bordered;

  IconTextHoverButton({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.iconSize,
    this.bordered = false,
  }) {
    assert(text != null || (icon != null && iconSize != null));
  }

  @override
  State<IconTextHoverButton> createState() => _IconTextHoverButtonState();
}

class _IconTextHoverButtonState extends State<IconTextHoverButton> {
  final ValueNotifier<bool> _hovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _hovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: _hovered,
      builder: (context, hovered, child) => InkWell(
        onTap: () => widget.onTap(),
        onHover: (value) => _hovered.value = value,
        child: Container(
          decoration: BoxDecoration(
            color: !hovered ? Colors.transparent : theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: !widget.bordered ? Colors.transparent : theme.colorScheme.onPrimary,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    size: widget.iconSize,
                    color: !hovered ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
                  ),
                if (widget.icon != null && widget.text != null) const SizedBox(width: 5),
                if (widget.text != null)
                  Text(
                    widget.text!,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: !hovered ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

  /// Padding of the content
  final EdgeInsets padding;

  /// If [IconTextHoverButton] has a rounded border around it
  final bool bordered;

  /// If [IconTextHoverButton] will have a filled background
  final bool filled;

  IconTextHoverButton({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.iconSize,
    this.bordered = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    this.filled = false,
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

    Color textHoverColor() {
      if (widget.filled) {
        return theme.colorScheme.primary;
      } else if (!_hovered.value) {
        return theme.colorScheme.onPrimary;
      } else {
        return theme.colorScheme.primary;
      }
    }

    return ValueListenableBuilder(
      valueListenable: _hovered,
      builder: (context, hovered, child) => InkWell(
        onTap: () => widget.onTap(),
        onHover: (value) => _hovered.value = value,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: hovered || widget.filled ? theme.colorScheme.onPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: !widget.bordered ? Colors.transparent : theme.colorScheme.onPrimary,
            ),
          ),
          child: Padding(
            padding: widget.padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    size: widget.iconSize,
                    color: hovered || widget.filled ? theme.colorScheme.primary : theme.colorScheme.onPrimary,
                  ),
                if (widget.icon != null && widget.text != null) const SizedBox(width: 5),
                if (widget.text != null)
                  Text(
                    widget.text!,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: hovered || widget.filled ? theme.colorScheme.primary : theme.colorScheme.onPrimary,
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

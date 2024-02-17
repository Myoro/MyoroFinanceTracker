import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_text_hover_button.dart';

/// [Widget] that all modal [Widget]s (a.k.a every file in this folder) will derive from
///
/// A [StatelessWidget], however every modal [Widget] in this directory must have a static [showDialog] function
class BaseModal extends StatelessWidget {
  /// [Size] of the modal
  final Size size;

  /// Title of the modal
  final String? title;

  /// Shows the yes and no buttons at the bottom of [BaseModal]
  final bool showFooterButtons;

  /// Text of the yes button
  final String? yesText;

  /// Function that is executed when the yes button is pressed
  final Function? yesOnTap;

  /// [Widget]/contents of the modal
  final Widget content;

  const BaseModal({
    super.key,
    required this.size,
    required this.content,
    this.title,
    this.showFooterButtons = false,
    this.yesText = 'Confirm',
    this.yesOnTap,
  });

  @override
  Widget build(BuildContext context) {
    if (showFooterButtons) assert(yesOnTap != null);

    final ThemeData theme = Theme.of(context);

    return Center(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: theme.colorScheme.onPrimary),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 5, // To offset Icons.close padding
          ),
          child: Material(
            // Needed for custom widgets like IconButtonWithoutFeedback to work
            child: Column(
              children: [
                Row(
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: theme.textTheme.titleMedium,
                      ),
                    const Spacer(),
                    IconButtonWithoutFeedback(
                      icon: Icons.close,
                      size: 26,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
                content,
                if (showFooterButtons) ...[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: IconTextHoverButton(
                          onTap: () => yesOnTap!(),
                          text: yesText,
                          bordered: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: IconTextHoverButton(
                          onTap: () => Navigator.pop(context),
                          text: 'Cancel',
                          bordered: true,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

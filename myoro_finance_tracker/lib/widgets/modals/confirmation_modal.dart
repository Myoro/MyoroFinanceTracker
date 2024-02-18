import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/modals/base_modal.dart';

/// A simple yes/no condition modal
class ConfirmationModal {
  static void show(
    BuildContext context, {
    required Size size,
    required String title,
    required String message,
    required Function yesOnTap,
  }) =>
      showDialog(
        context: context,
        builder: (context) => BaseModal(
          size: size,
          title: title,
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          showFooterButtons: true,
          yesOnTap: () => yesOnTap(),
        ),
      );
}

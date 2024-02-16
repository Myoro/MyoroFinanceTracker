import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/app_bars/home_screen_app_bar.dart';
import 'package:myoro_finance_tracker/widgets/modals/base_modal.dart';

/// Modal in which the user may add or edit a finance
///
/// Used in [HomeScreenAppBar]
class FinanceFormModal extends StatefulWidget {
  const FinanceFormModal({super.key});

  static void show(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const FinanceFormModal(),
      );

  @override
  State<FinanceFormModal> createState() => _FinanceFormModalState();
}

class _FinanceFormModalState extends State<FinanceFormModal> {
  @override
  Widget build(BuildContext context) => BaseModal(
        size: const Size(300, 300),
        showFooterButtons: true,
        yesOnTap: () {}, // TODO
        title: 'Add Finance',
        content: const Text('Start'),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/blocs/finances_cubit.dart';
import 'package:myoro_finance_tracker/formatters/date_formatter.dart';
import 'package:myoro_finance_tracker/formatters/price_formatter.dart';
import 'package:myoro_finance_tracker/models/finance_model.dart';
import 'package:myoro_finance_tracker/widgets/app_bars/home_screen_app_bar.dart';
import 'package:myoro_finance_tracker/widgets/inputs/base_text_field_form.dart';
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
  final double _titleWidth = 100;
  final double _textFieldWidth = 150;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _spentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  void _createFinance() {
    // TODO: Do date validation if it isn't completely filled in

    if(_spentController.text.isEmpty) return;

    BlocProvider.of<FinancesCubit>(context).add(
      FinanceModel(
        name: _nameController.text,
        spent: double.parse(double.parse(_spentController.text).toStringAsFixed(2)),
        date: _dateController.text.isEmpty ? DateTime.now() : DateFormat('dd/MM/yyyy').parse(_dateController.text),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _spentController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BaseModal(
        size: const Size(300, 250),
        showFooterButtons: true,
        yesOnTap: () => _createFinance(),
        title: 'Add Finance',
        content: Column(
          children: [
            BaseTextFieldForm(
              controller: _nameController,
              focusNode: _nameFocusNode,
              title: 'Name',
              titleWidth: _titleWidth,
              textFieldWidth: _textFieldWidth,
            ),
            BaseTextFieldForm(
              controller: _spentController,
              title: '\$ Spent',
              titleWidth: _titleWidth,
              textFieldWidth: _textFieldWidth,
              formatters: [PriceFormatter()],
            ),
            BaseTextFieldForm(
              controller: _dateController,
              title: 'Date',
              titleWidth: _titleWidth,
              textFieldWidth: _textFieldWidth,
              formatters: [DateFormatter()],
            ),
          ],
        ),
      );
}

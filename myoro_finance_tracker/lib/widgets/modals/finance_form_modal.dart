import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/blocs/finances_cubit.dart';
import 'package:myoro_finance_tracker/formatters/date_formatter.dart';
import 'package:myoro_finance_tracker/formatters/price_formatter.dart';
import 'package:myoro_finance_tracker/helpers/price_helper.dart';
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
  final ValueNotifier<bool> _showMessage = ValueNotifier<bool>(false);

  void _createFinance() {
    if (_spentController.text.isEmpty) {
      _showMessage.value = true;
      Future.delayed(const Duration(milliseconds: 1500), () => _showMessage.value = false);
      return;
    }

    BlocProvider.of<FinancesCubit>(context).add(FinanceModel(
      name: _nameController.text,
      spent: PriceHelper.formatPrice(_spentController.text),
      date: _dateController.text.length < 10 ? DateTime.now() : DateFormat('dd/MM/yyyy').parse(_dateController.text),
    ));

    Navigator.pop(context);
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
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _showMessage,
        builder: (context, showMessage, child) => BaseModal(
          size: Size(300, !showMessage ? 250 : 296),
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
                obligatory: true,
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
              if (showMessage) ...[
                const SizedBox(height: 20),
                Text(
                  'Form incomplete',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ],
          ),
        ),
      );
}

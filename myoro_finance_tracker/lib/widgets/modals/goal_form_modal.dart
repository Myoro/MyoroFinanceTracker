import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/blocs/goals_cubit.dart';
import 'package:myoro_finance_tracker/formatters/date_formatter.dart';
import 'package:myoro_finance_tracker/formatters/price_formatter.dart';
import 'package:myoro_finance_tracker/helpers/price_helper.dart';
import 'package:myoro_finance_tracker/models/goal_model.dart';
import 'package:myoro_finance_tracker/widgets/inputs/base_text_field_form.dart';
import 'package:myoro_finance_tracker/widgets/modals/base_modal.dart';

/// Modal to add goals (i.e. saving up for a car)
class GoalFormModal extends StatefulWidget {
  const GoalFormModal({super.key});

  static void show(BuildContext context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const GoalFormModal(),
      );

  @override
  State<GoalFormModal> createState() => _GoalFormModalState();
}

class _GoalFormModalState extends State<GoalFormModal> {
  final double _titleWidth = 175;
  final double _textFieldWidth = 125;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _goalAmountController = TextEditingController();
  final TextEditingController _finishDateController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final ValueNotifier<String?> _errorMessage = ValueNotifier<String?>(null);

  void _createGoal() {
    if (_nameController.text.isEmpty) {
      _errorMessage.value = 'Name cannot be empty';
      Future.delayed(const Duration(milliseconds: 1500), () => _errorMessage.value = null);
    } else if (_goalAmountController.text.isEmpty) {
      _errorMessage.value = 'Amount cannot be empty';
      Future.delayed(const Duration(milliseconds: 1500), () => _errorMessage.value = null);
    } else if (_finishDateController.text.length == 10 && DateFormat('dd/MM/yyyy').parse(_finishDateController.text).isBefore(DateTime.now())) {
      _errorMessage.value = 'Date must be empty or valid';
      Future.delayed(const Duration(milliseconds: 1500), () => _errorMessage.value = null);
    } else {
      BlocProvider.of<GoalsCubit>(context).add(
        GoalModel(
          name: _nameController.text,
          goalAmount: PriceHelper.formatPriceToDouble(_goalAmountController.text),
          finishDate: _finishDateController.text.length == 10 ? DateFormat('dd/MM/yyyy').parse(_finishDateController.text) : null,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _goalAmountController.dispose();
    _finishDateController.dispose();
    _nameFocusNode.dispose();
    _errorMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _errorMessage,
        builder: (context, errorMessage, child) => BaseModal(
          title: 'Add a Goal',
          showFooterButtons: true,
          yesText: 'Create',
          yesOnTap: () => _createGoal(),
          size: Size(350, errorMessage == null ? 280 : 326),
          content: Column(
            children: [
              BaseTextFieldForm(
                controller: _nameController,
                focusNode: _nameFocusNode,
                title: 'Goal Name',
                obligatory: true,
                titleWidth: _titleWidth,
                textFieldWidth: _textFieldWidth,
              ),
              const SizedBox(height: 10),
              BaseTextFieldForm(
                controller: _goalAmountController,
                formatters: [PriceFormatter()],
                title: 'Amount to Save',
                obligatory: true,
                titleWidth: _titleWidth,
                textFieldWidth: _textFieldWidth,
              ),
              const SizedBox(height: 10),
              BaseTextFieldForm(
                controller: _finishDateController,
                formatters: [DateFormatter()],
                title: 'Finish Date',
                titleWidth: _titleWidth,
                textFieldWidth: _textFieldWidth,
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 15),
                Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ],
          ),
        ),
      );
}

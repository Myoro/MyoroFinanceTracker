import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/blocs/total_income_cubit.dart';
import 'package:myoro_finance_tracker/formatters/price_formatter.dart';
import 'package:myoro_finance_tracker/helpers/price_helper.dart';
import 'package:myoro_finance_tracker/widgets/inputs/base_text_field.dart';
import 'package:myoro_finance_tracker/widgets/modals/base_modal.dart';

class TotalIncomeFormModal extends StatefulWidget {
  const TotalIncomeFormModal({super.key});

  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => const TotalIncomeFormModal(),
      );

  @override
  State<TotalIncomeFormModal> createState() => _TotalIncomeFormModalState();
}

class _TotalIncomeFormModalState extends State<TotalIncomeFormModal> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _errorMessage = ValueNotifier<bool>(false);

  void _updateTotalIncome() {
    if (_controller.text.isEmpty) {
      _errorMessage.value = true;
      Future.delayed(const Duration(milliseconds: 1500), () => _errorMessage.value = false);
    }
    BlocProvider.of<TotalIncomeCubit>(context).add(PriceHelper.formatPriceToDouble(_controller.text));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _errorMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _errorMessage,
        builder: (context, errorMessage, child) => BaseModal(
          size: Size(300, !errorMessage ? 168 : 175),
          title: 'Update Total Income',
          showFooterButtons: true,
          yesOnTap: () => _updateTotalIncome(),
          content: Column(
            children: [
              BaseTextField(
                width: 250,
                controller: _controller,
                focusNode: _focusNode,
                formatters: [PriceFormatter()],
              ),
              if (errorMessage)
                Text(
                  'Name cannot be empty',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
            ],
          ),
        ),
      );
}

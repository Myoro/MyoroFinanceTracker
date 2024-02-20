import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/blocs/timely_payments_cubit.dart';
import 'package:myoro_finance_tracker/enums/paying_or_receiving_enum.dart';
import 'package:myoro_finance_tracker/enums/payment_frequency_enum.dart';
import 'package:myoro_finance_tracker/formatters/date_formatter.dart';
import 'package:myoro_finance_tracker/formatters/price_formatter.dart';
import 'package:myoro_finance_tracker/helpers/price_helper.dart';
import 'package:myoro_finance_tracker/models/timely_payment_model.dart';
import 'package:myoro_finance_tracker/widgets/inputs/base_dropdown_form.dart';
import 'package:myoro_finance_tracker/widgets/inputs/base_text_field_form.dart';
import 'package:myoro_finance_tracker/widgets/modals/base_modal.dart';
import 'package:myoro_finance_tracker/widgets/cards/timely_payments_card.dart';

/// Modal where the user may place payments like receiving a payment or paying a music subscription
///
/// Called in [TimelyPaymentsCard]
class TimelyPaymentFormModal extends StatefulWidget {
  const TimelyPaymentFormModal({super.key});

  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => const TimelyPaymentFormModal(),
      );

  @override
  State<TimelyPaymentFormModal> createState() => _TimelyPaymentFormModalState();
}

class _TimelyPaymentFormModalState extends State<TimelyPaymentFormModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountSpentController = TextEditingController();
  final TextEditingController _dateToPayController = TextEditingController();
  String? _paymentFrequency;
  String? _payingOrReceiving;
  final ValueNotifier<bool> _showMessage = ValueNotifier<bool>(false);

  void _addTimelyPayment() {
    // Validation
    if (_amountSpentController.text.isEmpty ||
        _dateToPayController.text.isEmpty ||
        _dateToPayController.text.length < 10 ||
        (_dateToPayController.text.length == 10 && DateFormat('dd/MM/yyyy').parse(_dateToPayController.text).isBefore(DateTime.now())) ||
        _paymentFrequency == null ||
        _payingOrReceiving == null) {
      _showMessage.value = true;
      Future.delayed(const Duration(milliseconds: 1500), () => _showMessage.value = false);
      return;
    }

    BlocProvider.of<TimelyPaymentsCubit>(context).add(
      TimelyPaymentModel(
        name: _nameController.text,
        spent: PriceHelper.formatPriceToDouble(_amountSpentController.text),
        datePaid: DateFormat('dd/MM/yyyy').parse(_dateToPayController.text),
        paymentFrequency: PaymentFrequencyEnum.values.firstWhere(
          (value) => value.title == _paymentFrequency,
        ),
        payingOrReceiving: PayingOrReceivingEnum.values.firstWhere(
          (value) => value.title == _payingOrReceiving,
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountSpentController.dispose();
    _dateToPayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle bodySmall = Theme.of(context).textTheme.bodySmall!;

    const double titleWidth = 170;
    const double inputWidth = 120;

    return ValueListenableBuilder(
      valueListenable: _showMessage,
      builder: (context, showMessage, child) => BaseModal(
        title: 'Add Timely Payment',
        showFooterButtons: true,
        yesOnTap: () => _addTimelyPayment(),
        size: Size(350, !showMessage ? 376 : 417),
        content: Column(
          children: [
            BaseDropdownForm(
              title: 'Paying or Receiving?',
              titleWidth: titleWidth,
              titleTextStyle: bodySmall,
              dropdownWidth: inputWidth,
              obligatory: true,
              items: PayingOrReceivingEnum.values.map((value) => value.title).toList(),
              onChanged: (value) => _payingOrReceiving = value,
            ),
            BaseTextFieldForm(
              title: 'Name',
              titleWidth: titleWidth,
              titleTextStyle: bodySmall,
              textFieldWidth: inputWidth,
              controller: _nameController,
            ),
            const SizedBox(height: 10),
            BaseTextFieldForm(
              title: 'Amount (\$)',
              titleWidth: titleWidth,
              titleTextStyle: bodySmall,
              textFieldWidth: inputWidth,
              obligatory: true,
              controller: _amountSpentController,
              formatters: [PriceFormatter()],
            ),
            const SizedBox(height: 10),
            BaseDropdownForm(
              title: 'Payment Frequency',
              titleWidth: titleWidth,
              titleTextStyle: bodySmall,
              dropdownWidth: inputWidth,
              obligatory: true,
              items: PaymentFrequencyEnum.values.map((value) => value.title).toList(),
              onChanged: (value) => _paymentFrequency = value,
            ),
            BaseTextFieldForm(
              title: 'Date',
              titleWidth: titleWidth,
              titleTextStyle: bodySmall,
              textFieldWidth: inputWidth,
              controller: _dateToPayController,
              formatters: [DateFormatter()],
              obligatory: true,
            ),
            if (showMessage) ...[
              const SizedBox(height: 15),
              Text(
                'Form Incomplete',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

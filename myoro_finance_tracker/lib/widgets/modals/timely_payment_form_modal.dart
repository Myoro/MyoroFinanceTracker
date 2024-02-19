import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/enums/paying_or_receiving_enum.dart';
import 'package:myoro_finance_tracker/enums/payment_frequency_enum.dart';
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

  void _addTimelyPayment() {
    // Validation
    if (_amountSpentController.text.isEmpty || _dateToPayController.text.isEmpty || _paymentFrequency == null || _payingOrReceiving == null) return;
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

    return BaseModal(
      title: 'Add Timely Payment',
      showFooterButtons: true,
      yesOnTap: () => _addTimelyPayment(),
      size: const Size(350, 376),
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
          ),
          const SizedBox(height: 10),
          BaseDropdownForm(
            title: 'Payment Frequency',
            titleWidth: titleWidth,
            titleTextStyle: bodySmall,
            dropdownWidth: inputWidth,
            obligatory: true,
            items: PaymentFrequencyEnum.values.map((value) => value.title).toList(),
            onChanged: (value) => _payingOrReceiving = value,
          ),
          BaseTextFieldForm(
            title: 'Date',
            titleWidth: titleWidth,
            titleTextStyle: bodySmall,
            textFieldWidth: inputWidth,
            controller: _dateToPayController,
          ),
        ],
      ),
    );
  }
}

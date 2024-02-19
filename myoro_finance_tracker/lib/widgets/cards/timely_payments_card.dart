import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/bodies/income_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_text_hover_button.dart';
import 'package:myoro_finance_tracker/widgets/cards/base_card.dart';
import 'package:myoro_finance_tracker/widgets/modals/timely_payment_form_modal.dart';

/// Card in which the user may view or edit their timely/fixed payments (i.e. paycheck or subscription payment)
///
/// Used in [IncomeScreenBody]
class TimelyPaymentsCard extends StatelessWidget {
  const TimelyPaymentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle titleMedium = Theme.of(context).textTheme.titleMedium!;

    return BaseCard(
      width: 275,
      content: Column(
        children: [
          Text('Your Inbound Payments', style: titleMedium),
          const SizedBox(height: 10),
          Text('Your Outbound Payments', style: titleMedium),
          const SizedBox(height: 10),
          IconTextHoverButton(
            text: 'Add Payment',
            bordered: true,
            onTap: () => TimelyPaymentFormModal.show(context),
          ),
        ],
      ),
    );
  }
}

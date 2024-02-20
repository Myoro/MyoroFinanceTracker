import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/blocs/timely_payments_cubit.dart';
import 'package:myoro_finance_tracker/enums/paying_or_receiving_enum.dart';
import 'package:myoro_finance_tracker/models/timely_payment_model.dart';
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

    return BlocBuilder<TimelyPaymentsCubit, List<TimelyPaymentModel>>(builder: (context, timelyPayments) {
      final List<TimelyPaymentModel> receiving = [];
      final List<TimelyPaymentModel> paying = [];

      for (final TimelyPaymentModel timelyPayment in timelyPayments) {
        if (timelyPayment.payingOrReceiving == PayingOrReceivingEnum.paying) {
          paying.add(timelyPayment);
        } else {
          receiving.add(timelyPayment);
        }
      }

      return BaseCard(
        width: 350,
        content: Column(
          children: [
            if (receiving.isNotEmpty) ...[
              Text('Your Inbound Payments', style: titleMedium),
              const SizedBox(height: 5),
              for (final TimelyPaymentModel timelyPayment in receiving) _TimelyPayment(timelyPayment),
              const SizedBox(height: 10),
            ],
            if (paying.isNotEmpty) ...[
              Text('Your Outbound Payments', style: titleMedium),
              const SizedBox(height: 5),
              for (final TimelyPaymentModel timelyPayment in paying) _TimelyPayment(timelyPayment),
              const SizedBox(height: 10),
            ],
            IconTextHoverButton(
              text: 'Add Payment',
              bordered: true,
              onTap: () => TimelyPaymentFormModal.show(context),
            ),
          ],
        ),
      );
    });
  }
}

class _TimelyPayment extends StatelessWidget {
  final TimelyPaymentModel timelyPayment;

  const _TimelyPayment(this.timelyPayment);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(timelyPayment.name ?? 'No Name', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 5),
              _Output('Amount Spent', timelyPayment.spent.toStringAsFixed(2)),
              const SizedBox(height: 5),
              _Output('Date Triggered', DateFormat('dd/MM/yyyy').format(timelyPayment.datePaid)),
              const SizedBox(height: 5),
              _Output('Frequency', timelyPayment.paymentFrequency.title),
            ],
          ),
        ),
      );
}

class _Output extends StatelessWidget {
  final String title;
  final String output;

  const _Output(this.title, this.output);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            '$title:',
            style: textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            output,
            style: textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

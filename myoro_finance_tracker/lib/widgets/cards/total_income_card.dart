import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/blocs/total_income_cubit.dart';
import 'package:myoro_finance_tracker/widgets/bodies/income_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_text_hover_button.dart';
import 'package:myoro_finance_tracker/widgets/cards/base_card.dart';
import 'package:myoro_finance_tracker/widgets/modals/total_income_form_modal.dart';

/// Card to display and edit the total income of the user
///
/// Used in [IncomeScreenBody]
class TotalIncomeCard extends StatefulWidget {
  const TotalIncomeCard({super.key});

  @override
  State<TotalIncomeCard> createState() => _TotalIncomeCardState();
}

class _TotalIncomeCardState extends State<TotalIncomeCard> {
  final ValueNotifier<bool> _hidden = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _hidden.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TotalIncomeCubit, double>(
        builder: (context, totalIncome) => BaseCard(
          width: 350,
          content: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: _hidden,
                builder: (context, hidden, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hidden ? '\$${'*' * (totalIncome.toStringAsFixed(2).length + 1)}' : '\$${totalIncome.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 5),
                    IconButtonWithoutFeedback(
                      icon: hidden ? Icons.visibility : Icons.visibility_off,
                      size: 30,
                      onTap: () => _hidden.value = !_hidden.value,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              IconTextHoverButton(
                filled: true,
                onTap: () => TotalIncomeFormModal.show(context),
                text: 'Update Total Income',
              )
            ],
          ),
        ),
      );
}

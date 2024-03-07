import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myoro_finance_tracker/blocs/goals_cubit.dart';
import 'package:myoro_finance_tracker/helpers/price_helper.dart';
import 'package:myoro_finance_tracker/models/goal_model.dart';
import 'package:myoro_finance_tracker/widgets/bodies/income_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_text_hover_button.dart';
import 'package:myoro_finance_tracker/widgets/cards/base_card.dart';
import 'package:myoro_finance_tracker/widgets/modals/confirmation_modal.dart';
import 'package:myoro_finance_tracker/widgets/modals/goal_form_modal.dart';
import 'package:myoro_finance_tracker/widgets/outputs/form_output.dart';

/// Where the user may set goals (i.e. user has $10000, but needs $20000 for a car)
///
/// Used in [IncomeScreenBody]
class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key});

  void _deleteGoal(BuildContext context, GoalModel goal) {
    BlocProvider.of<GoalsCubit>(context).remove(goal);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<GoalsCubit, List<GoalModel>>(
        builder: (context, goals) => BaseCard(
          width: 350,
          content: Column(
            children: [
              if (goals.isNotEmpty) ...[
                Text('Goals', style: Theme.of(context).textTheme.titleMedium),
                for (final GoalModel goal in goals) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                goal.name ?? 'No Name',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const Spacer(),
                              IconTextHoverButton(
                                onTap: () => ConfirmationModal.show(
                                  context,
                                  size: const Size(300, 180),
                                  title: 'Delete Goal',
                                  message: 'Are you sure you want to delete ${goal.name ?? 'this payment'}?',
                                  yesOnTap: () => _deleteGoal(context, goal),
                                ),
                                icon: Icons.delete,
                                iconSize: 25,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          FormOutput(
                            title: 'Amount to Save',
                            output:
                                '\$${PriceHelper.formatPriceToBrazilianFormat(goal.goalAmount.toStringAsFixed(2).split('.')[0])},${goal.goalAmount.toStringAsFixed(2).split('.')[1]}',
                          ),
                          const SizedBox(height: 5),
                          if (goal.finishDate != null)
                            FormOutput(
                              title: 'Date to Reach Goal',
                              output: DateFormat('dd/MM/yyyy').format(goal.finishDate!),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                const SizedBox(height: 10),
              ],
              IconTextHoverButton(
                onTap: () => GoalFormModal.show(context),
                text: 'Add Goal',
              ),
            ],
          ),
        ),
      );
}

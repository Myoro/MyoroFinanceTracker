import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/bodies/income_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/cards/base_card.dart';

/// Where the user may set goals (i.e. user has $10000, but needs $20000 for a car)
///
/// Used in [IncomeScreenBody]
class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key});

  @override
  Widget build(BuildContext context) => const BaseCard(
        content: Text('Set an income goal!'),
      );
}

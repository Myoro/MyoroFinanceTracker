import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/bodies/base_body.dart';
import 'package:myoro_finance_tracker/widgets/cards/goals_card.dart';
import 'package:myoro_finance_tracker/widgets/cards/timely_payments_card.dart';
import 'package:myoro_finance_tracker/widgets/cards/total_income_card.dart';
import 'package:myoro_finance_tracker/widgets/screens/income_screen.dart';

/// Scaffold body for [IncomeScreen]
class IncomeScreenBody extends StatelessWidget {
  const IncomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) => const BaseBody(
        child: Column(
          children: [
            TotalIncomeCard(),
            SizedBox(height: 10),
            TimelyPaymentsCard(),
            SizedBox(height: 10),
            GoalsCard(),
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/app_bars/home_screen_app_bar.dart';
import 'package:myoro_finance_tracker/widgets/app_bars/income_screen_app_bar.dart';
import 'package:myoro_finance_tracker/widgets/bodies/income_screen_body.dart';

/// Screen where the user may configure:
/// 1. Their inicial/total income
/// 2. Timely payments (i.e. receiving a paycheck, or paying a subscription bill)
///
/// Called in [HomeScreenAppBar]
class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: IncomeScreenAppBar(),
        body: IncomeScreenBody(),
      );
}

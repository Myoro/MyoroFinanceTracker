import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/bodies/base_body.dart';
import 'package:myoro_finance_tracker/widgets/screens/home_screen.dart';
import 'package:myoro_finance_tracker/widgets/tables/finance_table.dart';

/// [Scaffold] body of [HomeScreen]
class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) => const BaseBody(child: FinanceTable());
}

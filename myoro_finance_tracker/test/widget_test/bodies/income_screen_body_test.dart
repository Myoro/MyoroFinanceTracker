import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/blocs/goals_cubit.dart';
import 'package:myoro_finance_tracker/blocs/timely_payments_cubit.dart';
import 'package:myoro_finance_tracker/blocs/total_income_cubit.dart';
import 'package:myoro_finance_tracker/widgets/bodies/income_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/cards/goals_card.dart';
import 'package:myoro_finance_tracker/widgets/cards/timely_payments_card.dart';
import 'package:myoro_finance_tracker/widgets/cards/total_income_card.dart';

import '../../base_test_widget.dart';

void main() {
  const String title = 'IncomeScreenBody Widget Test';

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      BaseTestWidget(
        title: title,
        testType: TestTypeEnum.widget,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TotalIncomeCubit(Random().nextDouble() * 9000000)),
            BlocProvider(create: (context) => GoalsCubit([])),
            BlocProvider(create: (context) => TimelyPaymentsCubit([])),
          ],
          child: const IncomeScreenBody(),
        ),
      ),
    );

    expect(find.byType(IncomeScreenBody), findsOneWidget);
    expect(find.byType(TotalIncomeCard), findsOneWidget);
    expect(find.byType(TimelyPaymentsCard), findsOneWidget);
    expect(find.byType(GoalsCard), findsOneWidget);
  });
}

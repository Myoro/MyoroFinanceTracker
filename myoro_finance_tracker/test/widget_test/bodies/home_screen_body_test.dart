import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/blocs/finances_cubit.dart';
import 'package:myoro_finance_tracker/widgets/bodies/base_body.dart';
import 'package:myoro_finance_tracker/widgets/bodies/home_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/tables/finance_table.dart';

import '../../base_test_widget.dart';
import '../../constants/finance_model_constants.dart';

void main() {
  const String title = 'HomeScreenBody Widget Test';

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      BaseTestWidget(
        title: title,
        testType: TestTypeEnum.widget,
        child: BlocProvider(
          create: (context) => FinancesCubit(
            List.generate(
              50,
              (_) => FinanceModelConstants.finance,
            ),
          ),
          child: const HomeScreenBody(),
        ),
      ),
    );

    expect(find.byType(HomeScreenBody), findsOneWidget);
    expect(find.byType(BaseBody), findsOneWidget);
    expect(find.byType(FinanceTable), findsOneWidget);
  });
}

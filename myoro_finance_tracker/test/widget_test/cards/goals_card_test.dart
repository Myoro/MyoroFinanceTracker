import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/blocs/goals_cubit.dart';
import 'package:myoro_finance_tracker/blocs/total_income_cubit.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_text_hover_button.dart';
import 'package:myoro_finance_tracker/widgets/cards/base_card.dart';
import 'package:myoro_finance_tracker/widgets/cards/goals_card.dart';
import 'package:myoro_finance_tracker/widgets/other/loading_bar.dart';
import 'package:myoro_finance_tracker/widgets/outputs/form_output.dart';

import '../../base_test_widget.dart';
import '../../constants/goal_model_constants.dart';

void main() {
  const String title = 'GoalsCard Widget Test';

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      BaseTestWidget(
        title: title,
        testType: TestTypeEnum.widget,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TotalIncomeCubit(9000000)),
            BlocProvider(
                create: (context) => GoalsCubit(
                      List.generate(
                        2,
                        (_) => GoalModelConstants.goal,
                      ),
                    )),
          ],
          child: const GoalsCard(),
        ),
      ),
    );

    expect(find.byType(GoalsCard), findsOneWidget);
    expect(find.byType(BaseCard), findsOneWidget);
    expect(find.byType(FormOutput), findsNWidgets(4));
    expect(find.byType(LoadingBar), findsNWidgets(2));
    expect(find.byType(IconTextHoverButton), findsNWidgets(3));
  });
}

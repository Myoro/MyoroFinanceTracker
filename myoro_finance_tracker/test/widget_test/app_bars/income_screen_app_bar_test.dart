import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/widgets/app_bars/income_screen_app_bar.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';

import '../../base_test_widget.dart';

void main() {
  const String title = 'IncomeScreenAppBar Widget Test';

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      const BaseTestWidget(
        title: title,
        testType: TestTypeEnum.appBar,
        child: IncomeScreenAppBar(),
      ),
    );

    expect(find.byType(IncomeScreenAppBar), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => (
          widget is IconButtonWithoutFeedback
          &&
          widget.icon == Icons.home
        ),
      ),
      findsOneWidget,
    );
  });
}
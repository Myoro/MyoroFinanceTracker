import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/widgets/app_bars/home_screen_app_bar.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';

import '../../base_test_widget.dart';

void main() {
  const String title = 'HomeScreenAppBar Widget Test';

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      const BaseTestWidget(
        title: title,
        testType: TestTypeEnum.appBar,
        child: HomeScreenAppBar(),
      )
    );

    expect(find.byType(HomeScreenAppBar), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => (
          widget is Text
          &&
          widget.data == 'MyoroFinanceTracker'
        ),
      ),
      findsOneWidget,
    );
    expect(find.byType(IconButtonWithoutFeedback), findsNWidgets(3));
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.paid_outlined), findsOneWidget);
    expect(find.byIcon(Icons.sunny), findsOneWidget);
  });
}
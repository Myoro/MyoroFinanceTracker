import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';

import '../../base_test_widget.dart';

void main() {
  const String title = 'IconButtonWithoutFeedback Widget Test';
  bool onTapWorking = false;

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      BaseTestWidget(
        title: title,
        testType: TestTypeEnum.widget,
        child: IconButtonWithoutFeedback(
          icon: Icons.abc,
          size: 100,
          onTap: () => onTapWorking = true,
        ),
      ),
    );

    expect(find.byType(IconButtonWithoutFeedback), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byIcon(Icons.abc), findsOneWidget);
    await tester.tap(find.byType(IconButtonWithoutFeedback));
    expect(onTapWorking, isTrue);
  });
}

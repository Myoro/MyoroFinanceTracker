import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/widgets/buttons/button_without_feedback.dart';

import '../../base_test_widget.dart';

void main() {
  const String title = 'ButtonWithoutFeedback Widget Test';
  bool onTapWorking = false;

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      BaseTestWidget(
        title: title,
        testType: TestTypeEnum.widget,
        child: ButtonWithoutFeedback(
          onTap: () => onTapWorking = true,
          child: const Text('Working'),
        ),
      ),
    );

    expect(find.byType(ButtonWithoutFeedback), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => (widget is Text && widget.data == 'Working'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.byType(ButtonWithoutFeedback));
    expect(onTapWorking, isTrue);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/widgets/cards/base_card.dart';

import '../../base_test_widget.dart';

void main() {
  const String title = 'BaseCard Widget Test';

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      const BaseTestWidget(
        title: title,
        testType: TestTypeEnum.widget,
        child: BaseCard(
          content: Text('Working'),
          width: 500,
          height: 1000,
        ),
      ),
    );

    expect(find.byType(BaseCard), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => (widget is Text && widget.data == 'Working'),
      ),
      findsOneWidget,
    );
  });
}

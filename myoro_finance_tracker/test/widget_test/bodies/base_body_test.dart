import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/widgets/bodies/base_body.dart';

import '../../base_test_widget.dart';

void main() {
  const String title = 'BaseBody Widget Test';

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      const BaseTestWidget(
        title: title,
        testType: TestTypeEnum.widget,
        child: BaseBody(
          child: Text('Working'),
        ),
      ),
    );

    expect(find.byType(BaseBody), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => (widget is Padding && widget.padding == const EdgeInsets.all(5)),
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => (widget is Text && widget.data == 'Working'),
      ),
      findsOneWidget,
    );
  });
}

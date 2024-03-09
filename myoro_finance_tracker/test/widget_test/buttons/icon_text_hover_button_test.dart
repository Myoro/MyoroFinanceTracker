import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_text_hover_button.dart';

import '../../base_test_widget.dart';

void main() {
  const String title = 'IconTextHoverButton Widget Test';
  bool onTapWorking = false;

  testWidgets(title, (tester) async {
    await tester.pumpWidget(
      BaseTestWidget(
        title: title,
        testType: TestTypeEnum.widget,
        child: Column(
          children: [
            IconTextHoverButton(
              onTap: () => onTapWorking = true,
              text: 'IconTextHoverButton Text',
              padding: const EdgeInsets.all(100),
              bordered: true,
              filled: true,
            ),
            IconTextHoverButton(
              onTap: () => onTapWorking = true,
              icon: Icons.abc,
              iconSize: 50,
            ),
            IconTextHoverButton(
              onTap: () => onTapWorking = true,
              text: 'IconTextHoverButton Text (with Icon)',
              icon: Icons.accessibility_new,
              iconSize: 100,
            ),
          ],
        ),
      ),
    );

    expect(find.byType(IconTextHoverButton), findsNWidgets(3));
    expect(find.text('IconTextHoverButton Text'), findsOneWidget);
    expect(find.text('IconTextHoverButton Text (with Icon)'), findsOneWidget);
    expect(find.byIcon(Icons.abc), findsOneWidget);
    expect(find.byIcon(Icons.accessibility_new), findsOneWidget);
    expect(
        // Testing icon + text placement
        find.byWidgetPredicate(
          (widget) => (widget is Row &&
              widget.children.length == 3 // Icon, SizedBox, & Text
              &&
              widget.children[0] is Icon &&
              widget.children[1] is SizedBox &&
              widget.children[2] is Text),
        ),
        findsOneWidget);
    await tester.tap(find.byType(IconTextHoverButton).first);
    expect(onTapWorking, isTrue);
  });
}

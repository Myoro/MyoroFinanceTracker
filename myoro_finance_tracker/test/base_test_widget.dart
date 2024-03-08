import 'package:flutter/material.dart';

enum TestTypeEnum { appBar, screen, widget }

class BaseTestWidget extends StatelessWidget {
  final String title;
  final TestTypeEnum testType;
  final Widget child;

  const BaseTestWidget({
    super.key,
    required this.title,
    required this.testType,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    late final Widget widget;

    switch(testType) {
      case TestTypeEnum.appBar:
        widget = MaterialApp(
          title: title,
          home: Scaffold(
            appBar: child as PreferredSizeWidget,
          ),
        );
        break;
      case TestTypeEnum.screen:
        widget = MaterialApp(
          title: title,
          home: child,
        );
        break;
      case TestTypeEnum.widget:
        widget = MaterialApp(
          title: title,
          home: Scaffold(
            body: child,
          ),
        );
        break;
    }

    return widget;
  }
}
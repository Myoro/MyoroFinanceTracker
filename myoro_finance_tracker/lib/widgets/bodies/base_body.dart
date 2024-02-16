import 'package:flutter/material.dart';

/// What all [Scaffold] body classes (every file in this directory) will derive from
class BaseBody extends StatelessWidget {
  /// Contents of the [Scaffold] body
  final Widget child;

  const BaseBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [child],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/app_bars/home_screen_app_bar.dart';
import 'package:myoro_finance_tracker/widgets/bodies/home_screen_body.dart';

/// Home/main screen of the application
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        appBar: HomeScreenAppBar(),
        body: HomeScreenBody(),
      );
}

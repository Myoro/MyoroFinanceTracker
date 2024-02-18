import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';
import 'package:myoro_finance_tracker/widgets/screens/income_screen.dart';

/// Scaffold [AppBar] for [IncomeScreen]
class IncomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const IncomeScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButtonWithoutFeedback(
              icon: Icons.home,
              size: 40,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myoro_finance_tracker/blocs/dark_mode_cubit.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';
import 'package:myoro_finance_tracker/widgets/modals/finance_form_modal.dart';
import 'package:myoro_finance_tracker/widgets/screens/home_screen.dart';
import 'package:myoro_finance_tracker/widgets/screens/income_screen.dart';

/// [AppBar] of [HomeScreen]
class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        title: Row(
          children: [
            Text(
              'MyoroFinanceTracker',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            IconButtonWithoutFeedback(
              icon: Icons.add,
              size: 40,
              onTap: () => FinanceFormModal.show(context),
            ),
            IconButtonWithoutFeedback(
              icon: Icons.paid_outlined,
              size: 40,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IncomeScreen(),
                ),
              ),
            ),
            IconButtonWithoutFeedback(
              icon: Icons.sunny,
              size: 40,
              onTap: () => BlocProvider.of<DarkModeCubit>(context).toggle(),
            ),
          ],
        ),
      );
}

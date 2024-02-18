import 'package:flutter/material.dart';
import 'package:myoro_finance_tracker/widgets/bodies/income_screen_body.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_button_without_feedback.dart';
import 'package:myoro_finance_tracker/widgets/buttons/icon_text_hover_button.dart';
import 'package:myoro_finance_tracker/widgets/cards/base_card.dart';

/// Card to display and edit the total income of the user
///
/// Used in [IncomeScreenBody]
class TotalIncomeCard extends StatelessWidget {
  const TotalIncomeCard({super.key});

  @override
  Widget build(BuildContext context) => BaseCard(
        width: 212,
        content: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$****', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: 5),
                IconButtonWithoutFeedback(
                  icon: Icons.visibility,
                  size: 30,
                  onTap: () {}, // TODO
                )
              ],
            ),
            const SizedBox(height: 10),
            IconTextHoverButton(
              onTap: () {}, // TODO
              text: 'Update Total Income',
              bordered: true,
            )
          ],
        ),
      );
}

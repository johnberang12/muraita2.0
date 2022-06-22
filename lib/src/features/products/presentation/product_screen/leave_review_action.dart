import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/localization/string_hardcoded.dart';

import '../../../../common_widgets/custom_text_button.dart';
import '../../../../common_widgets/responsive_two_column_layout.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../routing/app_router.dart';
import '../../../../utils/date_formatter.dart';

/// Simple widget to show the product purchase date along with a button to
/// leave a review.
class LeaveReviewAction extends StatelessWidget {
  const LeaveReviewAction({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source

    // TODO: Inject date formatter

    return Column(
      children: [
        const Divider(),
        gapH8,
        ResponsiveTwoColumnLayout(
          spacing: Sizes.p16,
          breakpoint: 300,
          startFlex: 3,
          endFlex: 2,
          rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          columnCrossAxisAlignment: CrossAxisAlignment.center,
          startContent: Text('Purchased on 05/20/2022'.hardcoded),
          endContent: CustomTextButton(
            text: 'Leave a review'.hardcoded,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.green[700]),
            onPressed: () => context.goNamed(
              AppRoute.leaveReview.name,
              params: {'id': productId},
            ),
          ),
        ),
        gapH8,
      ],
    );
  }
}

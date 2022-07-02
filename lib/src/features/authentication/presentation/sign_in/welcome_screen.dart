import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import '../../../../common_widgets/app_icon.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../common_widgets/custom_text_box.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../common_widgets/box_column.dart';
import '../../../../constants/strings.dart';
import '../../../../routing/app_router.dart';
import '../../../../routing/goRouter/route_utils.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: CustomBody(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoxColumn(
            children: [
              AppIcon(
                  avatarSize: height * iconAvatarSize,
                  fontSize: height * iconFontSize),
              CustomText(kLogoName, fontSize: height * logoNameSize),
              CustomText(
                kLogoHook,
                fontSize: height * logoHookSize,
              ),
            ],
          ),
          SizedBox(height: height * .07),
          CustomTextBox(
            kIntroductoryTitle,
            fontSize: height * welcomePageBodyTextSize,
          ),
          SizedBox(height: height * .17),
          PrimaryButton(
            text: kGetStartedButtonText,
            onPressed: () => context.pushNamed(AppRoute.phonesignin.name
                // PAGES.registration.name
                ),
          ),
        ],
      ),
    ));
  }
}

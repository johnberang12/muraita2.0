import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_button.dart';
import '../../../../common_widgets/app_icon.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../common_widgets/custom_text_box.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../common_widgets/box_column.dart';
import '../../../../constants/strings.dart';
import '../../../../routing/app_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      color: AppColors.primaryHue,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxColumn(
              children: [
                AppIcon(
                    avatarSize: height * iconAvatarSize,
                    fontSize: height * iconFontSize),
                CustomText(
                  kLogoName,
                  fontSize: height * logoNameSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(height: height * .17),
            ),
            SignInButton(
              height: height * .070,
              width: double.infinity,
              label: kGetStartedButtonText,
              onPressed: () => context.pushNamed(AppRoute.signin.name),
            ),
          ],
        ),
      ),
    ));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/action_text_button.dart';

import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/edit_profile_screen_controller.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/name_text_filed.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/account/presentation/edit_profile/presentation/profile_pic_widget.dart';
import '../../../../../../../common_widgets/custom_body.dart';
import 'image_profile_camera_controller.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  ///has set

  ///has set

  ///has set

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(editProfileControllerProvider);
    final pickedImage = ref.watch(pickedProfileImageProvider.state).state;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => controller.onCloseScreen(context),
          ),
          title: const Text('Edit profile'),
          actions: [
            ActionTextButton(
              text: 'Save',
              onPressed: () => controller.onSaveData(context),
            )
          ],
        ),
        body: CustomBody(
          child: Column(
            children: const [
              Divider(
                height: 0.5,
              ),
              Expanded(
                flex: 30,
                child: ProfilePicWidget(),
              ),
              Expanded(flex: 70, child: NameTextField()),
            ],
          ),
        ));
  }
}

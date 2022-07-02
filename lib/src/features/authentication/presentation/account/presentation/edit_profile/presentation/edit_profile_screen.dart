import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/action_text_button.dart';
import 'package:muraita_2_0/src/common_widgets/alert_dialogs.dart';
import 'package:muraita_2_0/src/common_widgets/outlined_text_field.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../../../../common_widgets/custom_body.dart';
import '../../../../../../../common_widgets/custom_image.dart';
import '../../../../../../../routing/app_router.dart';
import '../../../../../data/users_repository.dart';
import '../../../../sign_in/sign_in_state.dart';
import '../data/photo_gallery_repository.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _node = FocusScopeNode();

  String _name = '';

  bool _submitted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final auth = ref.watch(authRepositoryProvider);
    final userName = auth.currentUser?.displayName;
    _name = userName ?? '';
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  Future<void> _nameEditingComplete() async {
    setState(() => _submitted = true);

    final state = SignInState();
    final auth = FirebaseAuth.instance;
    final userName = auth.currentUser?.displayName;
    if (state.canSubmitName(_name)) {
      await auth.currentUser?.updateDisplayName(_name);
      final userRepository = ref.watch(userRepositoryProvider);
      await userRepository.updateDisplayName(auth.currentUser!.uid, _name);
      if (userName != null || userName != '') {}
    }
  }

  Future<void> _onSaveData(context) async {
    ref.read(loadingProvider.state).state = true;
    final saveData = await showAlertDialog(
      context: context,
      title: 'Are you sure you want to save changes?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Ok',
    );
    if (saveData == true) {
      final capturedImage =
          ref.watch(capturedImageControllerProvider.state).state;
      final pickedImage = ref.watch(pickedImageControllerProvider.state).state;
      if ((capturedImage == null || pickedImage == null) && _name == '') {
        Navigator.of(context).pop();
      } else if ((capturedImage == null || pickedImage == null)) {}

      final success = await _updateUserData(context);

      if (success) {
        ref.read(loadingProvider.state).state = false;
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile data successfully updated')));
      }
    }
  }

  Future<bool> _updateUserData(BuildContext context) async {
    try {
      final auth = ref.watch(authRepositoryProvider);
      final user = ref.watch(userRepositoryProvider);
      final userId = auth.currentUser?.uid;
      final updated = await _updateUserAuthData(context);
      if (updated) {
        await user.updateDisplayName(userId!, _name);
        return true;
      }
      return false;
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
          context: context, title: kOperationFailed, exception: e);
      return false;
    }
  }

  Future<bool> _updateUserAuthData(context) async {
    try {
      final auth = ref.watch(authRepositoryProvider);
      await auth.currentUser?.updateDisplayName(_name);
      // await auth.currentUser?.updatePhotoURL(photoURL);
      return true;
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
          context: context, title: kOperationFailed, exception: e);
      ref.read(loadingProvider.state).state = false;
      return false;
    }
  }

  Future<void> _onCloseScreen(context) async {
    final auth = ref.watch(authRepositoryProvider);
    final userName = auth.currentUser?.displayName;
    final photo = auth.currentUser?.photoURL;
    print('_name is $_name');
    print('userName is $userName');
    if (_name == userName) {
      setState(() {
        ref.read(pickedImageControllerProvider.state).state = null;
        ref.read(cameraControllerProvider).selectedEntity = null;

        ref.read(capturedImageControllerProvider.state).state = null;
      });

      Navigator.of(context).pop();
    } else if (_name != userName) {
      final close = await showAlertDialog(
        context: context,
        title: 'Your changes haven\'t saved.',
        content: 'Are you sure you want to exit?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Exit',
      );
      if (close == true) {
        setState(() {
          ref.read(pickedImageControllerProvider.state).state = null;
          ref.read(cameraControllerProvider).selectedEntity = null;

          ref.read(capturedImageControllerProvider.state).state = null;
        });

        Navigator.of(context).pop();
      }
    } else {}
  }

  void _onEditing(value) {
    setState(() {
      _submitted = false;
      _name = value;
      print(_name);
    });
  }

  void _onEditingComplete(context) {
    setState(() {
      _submitted = true;
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final state = SignInState();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => _onCloseScreen(context),
          ),
          title: const Text('Edit profile'),
          actions: [
            ActionTextButton(
              text: 'Done',
              onPressed: () => _onSaveData(context),
            )
          ],
        ),
        body: CustomBody(
          child: Column(
            children: [
              const Divider(
                height: 0.5,
              ),
              Expanded(flex: 5, child: Container()),
              const Expanded(flex: 15, child: ProfilePicButton()),
              Expanded(
                  flex: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gapH64,
                          const Text(
                            'Name',
                          ),
                          gapH12,
                          FocusScope(
                            node: _node,
                            child: OutlinedTextField(
                              height: height * outlineInputHeight,
                              initialValue: _name,
                              // autofocus: true,
                              labelText: kNameInputLabel,
                              hintText: kNameInputHint,

                              validator: (name) => !_submitted
                                  ? null
                                  : state.nameErrorTExt(name!),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              onChange: (value) => _onEditing(value),
                              onEditingComplete: () => _nameEditingComplete(),
                            ),
                          ),
                        ]),
                  )),
            ],
          ),
        ));
  }
}

class ProfilePicButton extends ConsumerWidget {
  const ProfilePicButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cameraControllerProvider);
    final selectedImage = ref.watch(pickedImageControllerProvider.state).state;
    final capturedImage =
        ref.watch(capturedImageControllerProvider.state).state;
    print('capturedImage =======> $capturedImage');
    return InkWell(
      onTap: () => context.pushNamed(AppRoute.imagegallery.name),
      highlightColor: kPrimaryHue,
      borderRadius: BorderRadius.circular(100),
      child: Stack(
        children: [
          ClipOval(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                  color: kGreyTransparent20,
                  child: selectedImage == null && capturedImage == null
                      ? const Icon(
                          Icons.person,
                          size: 80,
                          color: kGreyTransparent80,
                        )
                      : FittedBox(
                          fit: BoxFit.fill,
                          child: selectedImage == null
                              ? Image.file(capturedImage!)
                              : AssetEntityImage(selectedImage))),
            ),
          ),
          const Positioned(
              bottom: 7,
              right: 10,
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: kBlack40,
                      child: Icon(
                        Icons.camera_alt_sharp,
                        size: 20,
                      )))),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/common_widgets/responsive_scrollable_card.dart';
import 'package:muraita_2_0/src/constants/app_sizes.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/authentication/data/users_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';
import 'package:muraita_2_0/src/utils/async_value_ui.dart';
import '../../../../common_widgets/custom_text.dart';
import '../../../../common_widgets/outlined_text_field.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../routing/app_router.dart';

class NameRegistrationScreen extends ConsumerStatefulWidget {
  const NameRegistrationScreen({Key? key, this.onSignedIn}) : super(key: key);
  final VoidCallback? onSignedIn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<NameRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _nameController = TextEditingController();

  String get name => _nameController.text;

  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _node.dispose();
    super.dispose();
  }

  void _onEditing() {
    setState(() {
      _submitted = false;
    });
  }

  Future<void> _nameEditingComplete() async {
    setState(() => _submitted = true);

    final state = SignInState();
    final auth = FirebaseAuth.instance;
    final userName = auth.currentUser?.displayName;
    if (state.canSubmitName(name)) {
      await auth.currentUser?.updateDisplayName(name);
      final userRepository = ref.watch(userRepositoryProvider);
      await userRepository.updateDisplayName(auth.currentUser!.uid, name);
      if (userName != null || userName != '') {
        widget.onSignedIn?.call();
        context.goNamed(AppRoute.nameregisrtation.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = SignInState();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              'Please login with your phone number',
              fontSize: height * .025,
            ),
            SizedBox(
              height: height * .20,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ResponsiveScrollableCard(
                  child: FocusScope(
                node: _node,
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: height * .025),
                          child: OutlinedTextField(
                            height: height * outlineInputHeight,
                            controller: _nameController,
                            // autofocus: true,
                            labelText: kNameInputLabel,
                            hintText: kNameInputHint,

                            validator: (name) =>
                                !_submitted ? null : state.nameErrorTExt(name!),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            onChange: (value) => _onEditing(),
                            onEditingComplete: () => _nameEditingComplete(),
                          ),
                        ),
                        SizedBox(height: height * 0.025),
                        PrimaryButton(
                          text: kSubmit,
                          onPressed:
                              _submitted ? null : () => _nameEditingComplete(),
                        )
                      ],
                    )),
              )),
            )
          ],
        ),
      ),
    );
  }
}

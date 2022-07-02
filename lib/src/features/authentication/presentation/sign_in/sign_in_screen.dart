// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/authentication/data/auth_repository.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';
import 'package:muraita_2_0/src/routing/app_router.dart';
import 'package:muraita_2_0/src/utils/async_value_ui.dart';
import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/outlined_text_field.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../common_widgets/responsive_scrollable_card.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/strings.dart';
import '../../../../common_widgets/custom_text_box.dart';

import '../../../products/presentation/add_product/add_product_screen.dart';
import '../../data/users_repository.dart';
import '../../domain/app_user.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key? key,
    required this.formType,
  }) : super(key: key);
  final SignInFormType formType;

  ///keys for unit testing...find.byKey()
  static const nameKey = Key('name');
  static const phoneNumberKey = Key('phoneNumber');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomBody(
        child: Center(
          child: SingInContents(
            formType: formType,
          ),
        ),
      ),
    );
  }
}

class SingInContents extends ConsumerStatefulWidget {
  SingInContents({
    Key? key,
    this.onSignedIn,
    required this.formType,
  }) : super(key: key);

  final VoidCallback? onSignedIn;
  SignInFormType formType;

  @override
  ConsumerState<SingInContents> createState() => _SignInContentsState();
}

/// A widget for name and phone number authentication, supporting the following:
/// - register (create an account)
/// - otpVerification
class _SignInContentsState extends ConsumerState<SingInContents> {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  final _numberController = TextEditingController();
  final _otpController = TextEditingController();

  String get phoneNumber => _countryCode + _numberController.text;
  String get otpCode => _otpController.text;

  final String _countryCode = '+1';

  var _submitted = false;
  late Timer _timer;

  @override
  void dispose() {
    _node.dispose();

    _numberController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    ref.read(counterControllerProvider.state).state = 120;
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      int value = ref.read(counterControllerProvider.state).state--;
      if (value <= 0) {
        _timer.cancel();
      }
    });
  }

  void _codeSent() {
    _submitted = false;
    final state = ref.watch(signInControllerProvider(widget.formType));
    _updateFormType(state.secondaryActionFormType);
    _startTimer();
  }

  Future<void> _submitPhoneNumber(SignInState state) async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(signInControllerProvider(widget.formType).notifier);
      await controller.submitPhoneNumber(context, phoneNumber, _codeSent);
    }
  }

  Future<void> _submitOTP(SignInState state) async {
    setState(() => _submitted = true);
    final controller =
        ref.read(signInControllerProvider(widget.formType).notifier);
    final success =
        await controller.submitOtpCode(context, otpCode, _onSignedIn);
    if (success) {
      _updateUserData();
      _onSignedIn();
    }
  }

  void _onSignedIn() {
    final authRepository = ref.watch(authRepositoryProvider);
    final user = authRepository.currentUser;
    final verified = authRepository.currentUser != null;
    final hasName =
        user?.displayName != null && user?.displayName != kEmptyString;
    if (verified && hasName) {
      context.goNamed(AppRoute.home.name);
    } else if (verified && !hasName) {
      context.pushNamed(AppRoute.nameregisrtation.name);
    }
    // widget.onSignedIn?.call();
  }

  Future<void> _updateUserData() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final repository = UsersRepository();
    final id = authRepository.currentUser?.uid ?? documentIdFromCurrentDate();
    final uid = authRepository.currentUser?.uid;
    final phone = authRepository.currentUser?.phoneNumber;
    final user = AppUser(id: id, uid: uid!, phoneNumber: phone!);
    repository.setUser(user);
  }

  void _phoneNumberEditingComplete(SignInState state) {
    setState(() => _submitted = true);
    FocusScope.of(context).unfocus();
    _submitPhoneNumber(state);
  }

  void _onEditing() {
    setState(() {
      _submitted = false;
    });
  }

  void _updateFormType(SignInFormType formType) {
    ref
        .read(signInControllerProvider(widget.formType).notifier)
        .updateFormType(formType);
    _numberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
        signInControllerProvider(widget.formType)
            .select((state) => state.value),
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(signInControllerProvider(widget.formType));

    const registerType = SignInFormType.register;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextBox(
            state.registrationGuideText,
            fontSize: width * registrationGuideSize,
          ),
          SizedBox(height: height * 0.04),
          state.formType == registerType
              ? CustomTextBox(kPhoneNumberDisclosure,
                  fontSize: width * phoneNumberDisclosureSize)
              : const SizedBox(),
          SizedBox(height: height * 0.10),
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
                      ///phoneNumber text field
                      OutlinedTextField(
                        key: SignInScreen.phoneNumberKey,
                        height: height * outlineInputHeight,
                        controller: state.formType == registerType
                            ? _numberController
                            : _otpController,
                        // autofocus: true,
                        labelText: state.phoneNumberLabelText,
                        hintText: state.inputHintText,
                        enabled: !state.isLoading,
                        validator: (number) => !_submitted
                            ? null
                            : state.formType == registerType
                                ? state.numberErrorText(number!)
                                : state.otpErrorText(number!),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onChange: (value) => _onEditing(),
                        onEditingComplete: () =>
                            _phoneNumberEditingComplete(state),
                        // inputFormatters: widget.formType == registerType
                        //     ? [
                        //         ValidatorInputFormatter(
                        //           editingValidator:
                        //               NumberEditingRegexValidator(),
                        //         ),
                        //       ]
                        //     : null,
                        maxLength: state.numberMaxLength,
                      ),

                      SizedBox(height: height * 0.025),

                      ///this button only appears when form state is otpVerification form state
                      state.formType != registerType
                          ? _ResendButton(
                              onSubmit: () => _updateFormType(
                                  state.secondaryActionFormType),
                              height: height,
                            )
                          : const SizedBox(),
                      PrimaryButton(
                        text: state.primaryButtonText,
                        isLoading: state.isLoading,
                        onPressed: state.isLoading || _submitted
                            ? null
                            : state.formType == registerType
                                ? () => _submitPhoneNumber(state)
                                : () => _submitOTP(state),
                      ),
                    ],
                  )),
            )),
          ),
        ],
      ),
    );
  }
}

class _ResendButton extends ConsumerWidget {
  const _ResendButton({Key? key, required this.onSubmit, required this.height})
      : super(key: key);
  final VoidCallback onSubmit;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int seconds = ref.watch(counterControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryButton(
          text:
              seconds < 1 ? 'Resend code' : 'Resend code after $seconds secs.',
          onPressed: seconds < 1 ? onSubmit : null,
        ),
        SizedBox(height: height * 0.025),
      ],
    );
  }
}

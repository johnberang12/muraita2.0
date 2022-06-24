// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/phone_number_sign_in_controller.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/phone_number_sign_in_state.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:muraita_2_0/src/utils/async_value_ui.dart';

import '../../../../common_widgets/custom_body.dart';
import '../../../../common_widgets/outlined_text_field.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../common_widgets/responsive_scrollable_card.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/strings.dart';
import '../../../../common_widgets/custom_text_box.dart';
import '../../../../routing/app_router.dart';

class PhoneNumberSignInScreen extends StatelessWidget {
  const PhoneNumberSignInScreen({
    Key? key,
    required this.formType,
  }) : super(key: key);
  final PhoneNumberSignInFormType formType;

  ///keys for unit testing...find.byKey()
  static const nameKey = Key('name');
  static const phoneNumberKey = Key('phoneNumber');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(kRegistrationTitle),
      // ),
      body: CustomBody(
        child: PhoneNumberSingInContents(
          formType: formType,
        ),
      ),
    );
  }
}

class PhoneNumberSingInContents extends ConsumerStatefulWidget {
  PhoneNumberSingInContents({
    Key? key,
    this.onSignedIn,
    required this.formType,
  }) : super(key: key);

  final VoidCallback? onSignedIn;
  PhoneNumberSignInFormType formType;

  @override
  ConsumerState<PhoneNumberSingInContents> createState() =>
      _PhoneNumberSignInContentsState();
}

/// A widget for name and phone number authentication, supporting the following:
/// - register (create an account)
/// - otpVerification
class _PhoneNumberSignInContentsState
    extends ConsumerState<PhoneNumberSingInContents> {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _otpController = TextEditingController();

  String get name => _nameController.text;
  String get phoneNumber => countryCode + _numberController.text;
  String get otpCode => _otpController.text;

  String countryCode = '+1';

  var _submitted = false;
  late Timer _timer;

  bool _numberFailed = false;

  @override
  void dispose() {
    _node.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    ref.read(counterControllerProvider.state).state = 60;
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      int value = ref.read(counterControllerProvider.state).state--;
      if (value <= 0) {
        _timer.cancel();
      }
    });
  }

  void _codeSent() {
    print('codesent triggered');

    print(widget.formType);
    _submitted = false;
    setState(() => widget.formType = PhoneNumberSignInFormType.otpVerification);
    _startTimer();
  }

  Future<void> _submitPhoneNumber(PhoneNumberSignInState state) async {
    setState(() => _submitted = true);

    if (_formKey.currentState!.validate()) {
      final controller = ref
          .read(phoneNumberSignInControllerProvider(widget.formType).notifier);
      await controller.submitPhoneNumber(context, phoneNumber, _codeSent);
    }

    print('cant sumbit phoneNumber');
    // setState(() => _numberFailed = true);
  }

  Future<void> _submitOTP(PhoneNumberSignInState state) async {
    setState(() => _submitted = true);
    final controller =
        ref.read(phoneNumberSignInControllerProvider(widget.formType).notifier);
    final success =
        await controller.submitOtpCode(context, name, otpCode, _onSignedIn);
    if (success) {
      _onSignedIn();
    }
  }

  void _onSignedIn() {
    widget.onSignedIn?.call();
  }

  void _nameEditingComplete(PhoneNumberSignInState state) {
    setState(() => _submitted = true);
    if (state.canSubmitName(name)) {
      setState(() => _submitted = false);
      _node.nextFocus();
    }
  }

  void _phoneNumberEditingComplete(PhoneNumberSignInState state) {
    setState(() => _submitted = true);
    FocusScope.of(context).unfocus();
    _submitPhoneNumber(state);
  }

  void _onEditing() {
    setState(() {
      _numberFailed = false;
      _submitted = false;
    });
  }

  // void _updateFormType(PhoneNumberSignInFormType formType) {
  //   ref
  //       .read(phoneNumberSignInControllerProvider(widget.formType).notifier)
  //       .updateFormType(formType);
  //   _numberController.clear();
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.formType);
    print('whole widget rebuid');
    ref.listen<AsyncValue>(
        phoneNumberSignInControllerProvider(widget.formType)
            .select((state) => state.value),
        (_, state) => state.showAlertDialogOnError(context));
    final state =
        ref.watch(phoneNumberSignInControllerProvider(widget.formType));

    const registerType = PhoneNumberSignInFormType.register;
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
                      state.formType == registerType
                          ? Padding(
                              padding: EdgeInsets.only(bottom: height * .025),
                              child: OutlinedTextField(
                                key: PhoneNumberSignInScreen.nameKey,
                                height: height * outlineInputHeight,
                                controller: _nameController,
                                // autofocus: true,
                                labelText: kNameInputLabel,
                                hintText: kNameInputHint,
                                enabled: !state.isLoading,
                                validator: (name) => !_submitted
                                    ? null
                                    : state.nameErrorTExt(name!),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                onChange: (value) => _onEditing(),
                                onEditingComplete: () =>
                                    _nameEditingComplete(state),
                              ),
                            )
                          : const SizedBox(),

                      ///phoneNumber text field
                      OutlinedTextField(
                        key: PhoneNumberSignInScreen.phoneNumberKey,
                        height: height * outlineInputHeight,
                        controller: widget.formType == registerType
                            ? _numberController
                            : _otpController,
                        // autofocus: true,
                        labelText: state.phoneNumberLabelText,
                        hintText: state.inputHintText,
                        enabled: !state.isLoading,
                        validator: (number) => !_submitted
                            ? null
                            : widget.formType == registerType
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
                      widget.formType != registerType
                          ? _ResendButton(
                              onSubmit: () => _submitPhoneNumber(state),
                              height: height,
                            )
                          : const SizedBox(),
                      PrimaryButton(
                        text: state.primaryButtonText,
                        isLoading: state.isLoading,
                        onPressed: state.isLoading || _numberFailed
                            ? null
                            : widget.formType == registerType
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
          onPressed: seconds < 1 ? () => onSubmit : null,
        ),
        SizedBox(height: height * 0.025),
      ],
    );
  }
}

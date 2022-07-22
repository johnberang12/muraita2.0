// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_button.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/sign_in_state.dart';
import 'package:muraita_2_0/src/routing/app_router.dart';
import 'package:muraita_2_0/src/utils/async_value_ui.dart';
import 'package:pinput/pinput.dart';
import '../../../../common_widgets/outlined_text_field.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/strings.dart';
import '../../../../common_widgets/custom_text_box.dart';
import '../../../../constants/styles.dart';

class SignInScreen extends ConsumerStatefulWidget {
  SignInScreen({
    Key? key,
    this.onSignedIn,
    required this.formType,
  }) : super(key: key);

  final VoidCallback? onSignedIn;
  SignInFormType formType;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

/// A widget for name and phone number authentication, supporting the following:
/// - register (create an account)
/// - otpVerification
class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  final _numberController = TextEditingController();

  String get phoneNumber => _countryCode + _numberController.text;
  // String _otpCode = '';

  String _countryCode = '+1';

  var _submitted = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // dependOnInheritedWidgetOfExactType();
  }

  @override
  void dispose() {
    final controller =
        ref.read(signInControllerProvider(widget.formType).notifier);

    _node.dispose();

    _numberController.dispose();
    controller.timer.cancel();
    super.dispose();
  }

  Future<void> _submitPhoneNumber(SignInState state) async {
    setState(() => _submitted = true);
    print(phoneNumber);
    print(phoneNumber);
    print(phoneNumber);

    final controller =
        ref.read(signInControllerProvider(widget.formType).notifier);
    await controller.submitPhoneNumber(context, phoneNumber);
    setState(() => _submitted = false);
  }

  void _signIn() {
    widget.onSignedIn?.call();

    print('mounted mounter mounted');
    context.goNamed(AppRoute.landing.name);

    // Navigator.of(context).pop();
  }

  // Future<void> _submitOtp(String otpCode) async {
  //   final controller =
  //       ref.read(signInControllerProvider(widget.formType).notifier);
  //   await controller.submitOtpCode(context, otpCode, widget.onSignedIn!);
  //   if (!mounted) return;
  //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //     context.goNamed(AppRoute.landing.name);
  //   });
  // }

  // void _phoneNumberEditingComplete(SignInState state) {
  //   setState(() => _submitted = true);
  //   FocusScope.of(context).unfocus();
  // }

  void _onEditing() {
    setState(() {
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
        signInControllerProvider(widget.formType)
            .select((state) => state.value),
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(signInControllerProvider(widget.formType));
    final controller =
        ref.read(signInControllerProvider(widget.formType).notifier);

    const registerType = SignInFormType.register;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: AppColors.primaryHue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
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
                child: FocusScope(
                  node: _node,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ///phoneNumber text field

                      state.formType == registerType
                          ? OutlinedTextField(
                              height: height * outlineInputHeight,
                              prefix: state.formType == registerType
                                  ? _countryCodePicker()
                                  : const SizedBox(),
                              controller: _numberController,
                              autofocus: true,
                              labelText: state.phoneNumberLabelText,
                              hintText: kPhoneNumberInputHint,
                              enabled: !state.isLoading,
                              validator: (number) => !_submitted
                                  ? null
                                  : state.numberErrorText(number!),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              onChange: (value) => _onEditing(),
                              onEditingComplete: () =>
                                  _submitPhoneNumber(state),
                              // inputFormatters: widget.formType == registerType
                              //     ? [
                              //         ValidatorInputFormatter(
                              //           editingValidator:
                              //               NumberEditingRegexValidator(),
                              //         ),
                              //       ]
                              //     : null,
                              maxLength: state.numberMaxLength,
                            )
                          : _pinPut(),

                      SizedBox(height: height * 0.025),

                      ///this button only appears when form state is otpVerification form state
                      state.formType != registerType
                          ? _ResendButton(
                              onSubmit: () => controller.updateFormType(
                                  state.secondaryActionFormType),
                              height: height * .070,
                            )
                          : const SizedBox(),
                      state.formType == registerType
                          ? SignInButton(
                              label: state.primaryButtonText,
                              height: height * .070,
                              width: double.infinity,
                              onPressed:
                                  // state.isLoading || _submitted
                                  //     ? null
                                  //     :
                                  () => _submitPhoneNumber(state),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
    decoration: BoxDecoration(
      color: AppColors.primaryShade60,
      // border: Border.all(color: AppColors.primaryShade60),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  Widget _pinPut() {
    final controller =
        ref.read(signInControllerProvider(widget.formType).notifier);
    return Pinput(
        length: 6,
        controller: ref.read(otpTextEditingController.state).state,
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) => controller.submitOtpCode(context, pin, _signIn),
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi);
  }

  Widget _countryCodePicker() {
    return CountryCodePicker(
      onChanged: (country) => _countryCode = country.dialCode!,
      initialSelection: '+1',
      showCountryOnly: true,
      showDropDownButton: true,
      showOnlyCountryWhenClosed: false,
      flagWidth: 20,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      textStyle: Styles.k16.copyWith(color: Colors.white),
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
        SignInButton(
          height: height,
          width: double.infinity,
          label:
              seconds < 1 ? 'Resend code' : 'Resend code after $seconds secs.',
          onPressed: seconds < 1 ? onSubmit : null,
        ),
        SizedBox(height: height * 0.025),
      ],
    );
  }
}

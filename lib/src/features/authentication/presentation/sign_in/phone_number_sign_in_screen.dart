// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  String get name => _nameController.text;
  String get phoneNumber => _numberController.text;

  var _submitted = false;

  @override
  void dispose() {
    _node.dispose();
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _submitPhoneNumber(PhoneNumberSignInState state) async {
    setState(() => _submitted = true);

    /// temporary commented to fix UI

    // if (_formKey.currentState!.validate()) {
    //   final controller = ref
    //       .read(phoneNumberSignInControllerProvider(widget.formType).notifier);
    //   final success = await controller.submitPhoneNumber(name, phoneNumber);
    //   if (success) {
    //     // widget.onSignedIn?.call();
    //     widget.formType = PhoneNumberSignInFormType.otpVerification;
    //   }
    // }
    widget.formType = PhoneNumberSignInFormType.otpVerification;
  }

  Future<void> _submitOTP(PhoneNumberSignInState state) async {
    setState(() => _submitted = true);
    context.pushNamed(AppRoute.home.name);
  }

  void _nameEditingComplete(PhoneNumberSignInState state) {
    if (state.canSubmitName(name)) {
      _node.nextFocus();
    }
  }

  void _phoneNumberEditingComplete(PhoneNumberSignInState state) {
    if (!state.canSubmitNumber(phoneNumber)) {
      // _node.previousFocus();
      return;
    }
    FocusScope.of(context).unfocus();
    _submitPhoneNumber(state);
  }

  void _updateFormType(PhoneNumberSignInFormType formType) {
    ref
        .read(phoneNumberSignInControllerProvider(widget.formType).notifier)
        .updateFormType(formType);
    _numberController.clear();
  }

  @override
  Widget build(BuildContext context) {
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
                                    : state.nameErrorTExt(name ?? kEmptyString),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                onEditingComplete: () =>
                                    _nameEditingComplete(state),
                                inputFormatters: <TextInputFormatter>[
                                  ValidatorInputFormatter(
                                      editingValidator: NameValidator())
                                ],
                              ),
                            )
                          : const SizedBox(),

                      ///phoneNumber text field
                      OutlinedTextField(
                        key: PhoneNumberSignInScreen.phoneNumberKey,
                        height: height * outlineInputHeight,
                        controller: _numberController,
                        // autofocus: true,
                        labelText: state.phoneNumberLabelText,
                        hintText: state.inputHintText,
                        enabled: !state.isLoading,
                        validator: (number) => !_submitted
                            ? null
                            : state.numberErrorText(number ?? kEmptyString),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onEditingComplete: () =>
                            _phoneNumberEditingComplete(state),
                      ),

                      SizedBox(height: height * 0.025),
                      PrimaryButton(
                        text: state.primaryButtonText,
                        isLoading: state.isLoading,
                        onPressed: state.isLoading
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/string_validators.dart';
import '../../../../common_widgets/custom_text_box.dart';

///copied
enum SignInFormType { register, otpVerification }

mixin NameAndPhoneNumberValidators {
  final StringValidator nameSubmitValidator = MinLengthStringValidator(4);
  final StringValidator phoneNumberSubmitValidator =
      MinLengthStringValidator(10);
  final StringValidator otpSubmitValidator = MinLengthStringValidator(6);
}

class SignInState with NameAndPhoneNumberValidators {
  SignInState({
    this.formType = SignInFormType.register,
    this.value = const AsyncValue.data(null),
  });

  late SignInFormType formType;
  final AsyncValue<void> value;

  bool get isLoading => value.isLoading;

  SignInState copyWith({
    SignInFormType? formType,
    AsyncValue<void>? value,
  }) {
    return SignInState(
      formType: formType ?? this.formType,
      value: value ?? this.value,
    );
  }

  @override
  String toString() =>
      'PhoneNumberSignInState(formType: $formType, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignInState &&
        other.formType == formType &&
        other.value == value;
  }

  @override
  int get hashCode => formType.hashCode ^ value.hashCode;
}

extension SignInStateX on SignInState {
  String get phoneNumberLabelText {
    if (formType == SignInFormType.register) {
      return kPhoneNumberInputLabel;
    } else {
      return kOtpInputLabel;
    }
  }

  String get inputHintText {
    if (formType == SignInFormType.register) {
      return kPhoneNumberInputHint;
    } else {
      return kOtpInputHint;
    }
  }

  ///Getters
  String get primaryButtonText {
    if (formType == SignInFormType.register) {
      return kRegisterButtonText;
    } else {
      return kOtpButtonText;
    }
  }

  int get numberMaxLength {
    if (formType == SignInFormType.register) {
      return kNumberMaxLength;
    } else {
      return 6;
    }
  }

  SignInFormType get secondaryActionFormType {
    if (formType == SignInFormType.register) {
      return SignInFormType.otpVerification;
    } else {
      return SignInFormType.register;
    }
  }

  // String get errorAlerTitle {
  //   if (formType == PhoneNumberSignInFormType.register) {
  //     return kPhoneNumberErrorTitle;
  //   } else {
  //     return kOtpErrorTitle;
  //   }
  // }

  String get title {
    if (formType == SignInFormType.register) {
      return kRegistrationTitle;
    } else {
      return kOtpVerificationTitle;
    }
  }

  String get registrationGuideText {
    if (formType == SignInFormType.register) {
      return kRegistrationGuide;
    } else {
      return kOtpMessageGuide;
    }
  }

  bool canSubmitName(String name) {
    return nameSubmitValidator.isValid(name);
  }

  bool canSubmitNumber(String number) {
    return phoneNumberSubmitValidator.isValid(number);
  }

  bool canSubmitOtp(String otp) {
    return otpSubmitValidator.isValid(otp);
  }

  String? nameErrorTExt(String name) {
    final bool showErrorText = !canSubmitName(name);
    final String errorText =
        name.length <= 3 ? kNameCantBeEmpty : kNameIsTooShort;
    return showErrorText ? errorText : null;
  }

  String? numberErrorText(String number) {
    final bool showErrorText = !canSubmitNumber(number);
    const String errorText = kInvalidNumberFormat;
    return showErrorText ? errorText : null;
  }

  String? otpErrorText(String otp) {
    final bool showErrorText = !canSubmitOtp(otp);
    final String errorText = otp.length <= 5 || otp.length > 6
        ? kInvalidOtpFormat
        : kInvalidOtpFormat;
    return showErrorText ? errorText : null;
  }
}

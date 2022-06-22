import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/string_validators.dart';
import '../../../../common_widgets/custom_text_box.dart';

///copied
enum PhoneNumberSignInFormType { register, otpVerification }

mixin NameAndPhoneNumberValidators {
  final StringValidator nameSubmitValidator = MinLengthStringValidator(4);
  final StringValidator phoneNumberSubmitValidator = StringLenthValidator(10);
  final StringValidator otpSubmitValidator = MinLengthStringValidator(6);
}

class PhoneNumberSignInState with NameAndPhoneNumberValidators {
  PhoneNumberSignInState({
    this.formType = PhoneNumberSignInFormType.register,
    this.value = const AsyncValue.data(null),
  });

  final PhoneNumberSignInFormType formType;
  final AsyncValue<void> value;

  bool get isLoading => value.isLoading;

  PhoneNumberSignInState copyWith({
    PhoneNumberSignInFormType? formType,
    AsyncValue<void>? value,
  }) {
    return PhoneNumberSignInState(
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

    return other is PhoneNumberSignInState &&
        other.formType == formType &&
        other.value == value;
  }

  @override
  int get hashCode => formType.hashCode ^ value.hashCode;
}

extension EmailPasswordSignInStateX on PhoneNumberSignInState {
  String get phoneNumberLabelText {
    if (formType == PhoneNumberSignInFormType.register) {
      return kPhoneNumberInputLabel;
    } else {
      return kOtpInputLabel;
    }
  }

  String get inputHintText {
    if (formType == PhoneNumberSignInFormType.register) {
      return kPhoneNumberInputHint;
    } else {
      return kOtpInputHint;
    }
  }

  ///Getters
  String get primaryButtonText {
    if (formType == PhoneNumberSignInFormType.register) {
      return kRegisterButtonText;
    } else {
      return kOtpButtonText;
    }
  }

  PhoneNumberSignInFormType get secondaryActionFormType {
    if (formType == PhoneNumberSignInFormType.register) {
      return PhoneNumberSignInFormType.otpVerification;
    } else {
      return PhoneNumberSignInFormType.register;
    }
  }

  String get errorAlerTitle {
    if (formType == PhoneNumberSignInFormType.register) {
      return kPhoneNumberErrorTitle;
    } else {
      return kOtpErrorTitle;
    }
  }

  String get title {
    if (formType == PhoneNumberSignInFormType.register) {
      return kRegistrationTitle;
    } else {
      return kOtpVerificationTitle;
    }
  }

  String get registrationGuideText {
    if (formType == PhoneNumberSignInFormType.register) {
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

  String? nameErrorTExt(String name) {
    final bool showErrorText = !canSubmitName(name);
    final String errorText =
        name.length <= 3 ? kNameCantBeEmpty : kNameIsTooShort;
    return showErrorText ? errorText : null;
  }

  String? numberErrorText(String number) {
    final bool showErrorText = !canSubmitNumber(number);
    final String errorText =
        number.length <= 3 ? kInvalidNumberFormat : kInvalidNumberFormat;
    return showErrorText ? errorText : null;
  }
}

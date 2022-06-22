import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:muraita_2_0/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

class SignUpWithPhone extends StatelessWidget {
  const SignUpWithPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('entered signUp with phone');

    ///temporay return email sign up page
    return const EmailPasswordSignInScreen(
        formType: EmailPasswordSignInFormType.register);
  }
}

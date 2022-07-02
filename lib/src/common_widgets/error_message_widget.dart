import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {super.key});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        errorMessage,
        style:
            Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
      ),
    );
  }
}

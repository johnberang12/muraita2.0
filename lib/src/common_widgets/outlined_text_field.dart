import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField(
      {Key? key,
      this.height = 64,
      this.width = double.infinity,
      required this.controller,
      this.autofocus = false,
      this.labelText,
      this.hintText,
      this.enabled = true,
      this.validator,
      this.textInputAction,
      this.keyboardType,
      this.onEditingComplete,
      this.inputFormatters})
      : super(key: key);

  final double height;
  final double width;
  final TextEditingController? controller;
  final bool autofocus;
  final String? labelText;
  final String? hintText;
  final bool? enabled;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        key: key,
        controller: controller,
        autofocus: autofocus,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText,
            enabled: enabled!),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        autocorrect: false,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        keyboardAppearance: Brightness.light,
        onEditingComplete: onEditingComplete,
        inputFormatters: inputFormatters,
      ),
    );
  }
}

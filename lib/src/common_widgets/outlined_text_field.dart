import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField({
    Key? key,
    this.initialValue,
    this.controller,
    this.height = 64,
    this.width = double.infinity,
    this.autofocus = false,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.onEditingComplete,
    this.inputFormatters,
    this.onChange,
    this.maxLength,
  }) : super(key: key);

  final double height;
  final double width;
  final String? initialValue;
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
  final void Function(String)? onChange;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        key: key,
        initialValue: initialValue,
        controller: controller,
        autofocus: autofocus,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText,
            enabled: enabled!,
            counterText: ''),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        autocorrect: false,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        keyboardAppearance: Brightness.light,
        onEditingComplete: onEditingComplete,
        inputFormatters: inputFormatters,
        onChanged: onChange,
        maxLength: maxLength,
      ),
    );
  }
}

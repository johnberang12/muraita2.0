import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    Key? key,
    required this.defaultHint,
    required this.listItems,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    required this.onChanged,
  }) : super(key: key);

  // final double? height, width;
  final List<String> listItems;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Function(String?)? onChanged;
  final String defaultHint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DropdownButton<String>(
        underline: const SizedBox(),
        isDense: true,
        isExpanded: true,
        hint: Text(defaultHint),
        // value: defaultValue,
        items: listItems
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (value) => onChanged!(value),
      ),
    );
  }
}

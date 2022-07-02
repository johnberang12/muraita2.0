import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatInputField extends ConsumerWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Row(children: [
        SizedBox(
          height: double.infinity,
          width: width * .15,
        ),
        SizedBox(
          height: double.infinity,
          width: width * .60,
        ),
        SizedBox(
          height: double.infinity,
          width: width * .25,
        ),
      ]),
    );
  }
}

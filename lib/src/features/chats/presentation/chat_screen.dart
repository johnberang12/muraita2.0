import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/common_widgets/responsive_center.dart';
import 'package:muraita_2_0/src/features/chats/presentation/chat_input_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('seller name'),
      ),
      body: Column(children: [
        Expanded(
          flex: 90,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // ResponsiveSliverCenter(
              //   child: ChatListView()
              //   ),
            ],
          ),
        ),
        const Divider(height: 0.5),
        // Expanded(
        //   flex: 10,
        //   child: ChatInputField(product: product)
        // ),
      ]),
    );
  }
}

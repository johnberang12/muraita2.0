import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/common_widgets/responsive_center.dart';

import '../../../constants/app_sizes.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: CustomScrollView(slivers: [
        ResponsiveSliverCenter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.p4),
          child: Column(children: []),
        )),
      ]),
    );
  }
}

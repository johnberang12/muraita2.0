import 'package:flutter/material.dart';

import '../common_widgets/empty_placeholder_widget.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404 - Page not found!'),
      ),
      body: EmptyPlaceholderWidget(
        message: errorMessage,
      ),
    );
  }
}

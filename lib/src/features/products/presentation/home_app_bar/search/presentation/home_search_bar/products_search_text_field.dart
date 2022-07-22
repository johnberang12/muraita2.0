import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/sql_search_repository.dart';
import 'search_controller_provider.dart';

class ProductsSearchTextField extends ConsumerWidget {
  const ProductsSearchTextField({super.key, this.onPopScreen}) : super();
  final VoidCallback? onPopScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    final search = ref.watch(searchValueProvider.state).state;
    final controller = ref.watch(searchConrollerProvider);

    return Container(
      decoration: BoxDecoration(
          color: const Color(0xfffff4d3),
          borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
            controller: ref.watch(searchEditingControllerProvider.state).state,
            autofocus: true,
            // initialValue: search,
            style: Theme.of(context).textTheme.titleMedium,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search products',
              icon: IconButton(
                icon: const Icon(Icons.search),

                ///add Searched item button
                onPressed: search.isNotEmpty
                    ? () => controller.onSubmitValue(onPopScreen!)
                    : null,
              ),
              suffixIcon: search.isNotEmpty
                  ? IconButton(
                      onPressed: () =>
                          ref.read(searchEditingControllerProvider).clear(),
                      icon: const Icon(Icons.close),
                    )
                  : null,
            ),
            // TODO: Implement onChanged
            onChanged: (value) => controller.onEditing(value)),
      ),
    );
  }
}

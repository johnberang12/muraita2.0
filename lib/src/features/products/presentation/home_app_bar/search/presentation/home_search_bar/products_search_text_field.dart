import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muraita_2_0/src/constants/strings.dart';
import '../../data/search_product_repository.dart';
import 'search_controller_provider.dart';

class ProductsSearchTextField extends ConsumerWidget {
  const ProductsSearchTextField({super.key, this.onPopScreen}) : super();
  final VoidCallback? onPopScreen;

  Future<void> _onSubmitValue(BuildContext context, WidgetRef ref) async {
    final controller = ref.watch(searchRepositoryProvider);
    final search = ref.watch(searchValueProvider.state).state;

    await controller.addSearch(context, search);
    ref.read(searchValueProvider.state).state = '';
    ref.refresh(searchListFutureProvider);

    ///TODO: filter the search list

    onPopScreen!();
  }

  void _onEditing(String value, WidgetRef ref) {
    ref.read(searchValueProvider.state).state = value;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    final search = ref.watch(searchValueProvider.state).state;

    return Container(
      decoration: BoxDecoration(
          color: const Color(0xfffff4d3),
          borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
            controller: ref.watch(searchControllerProvider.state).state,
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
                    ? () => _onSubmitValue(context, ref)
                    : null,
              ),
              suffixIcon: search.isNotEmpty
                  ? IconButton(
                      onPressed: () =>
                          ref.read(searchControllerProvider).clear(),
                      icon: const Icon(Icons.close),
                    )
                  : null,
            ),
            // TODO: Implement onChanged
            onChanged: (value) => _onEditing(value, ref)),
      ),
    );
  }
}

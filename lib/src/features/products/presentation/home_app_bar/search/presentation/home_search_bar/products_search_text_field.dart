import 'package:flutter/material.dart';
import '../../data/search_product_repository.dart';

class ProductsSearchTextField extends StatefulWidget {
  const ProductsSearchTextField({super.key, this.onPopScreen}) : super();
  final VoidCallback? onPopScreen;

  @override
  State<ProductsSearchTextField> createState() =>
      _ProductsSearchTextFieldState();
}

class _ProductsSearchTextFieldState extends State<ProductsSearchTextField> {
  final _repository = SearchRepository.instance;
  final TextEditingController _searchInputController = TextEditingController();
  String get _searchItem => _searchInputController.text;

  bool isEditing = true;
  bool isSubmitted = false;

  Future<void> _saveSearchKeyword() async {
    await _repository.addSearch(context, _searchItem);
    _searchInputController.clear();

    widget.onPopScreen!();
  }

  Future<void> _onPressSearch() async {
    isEditing = false;
    isSubmitted = true;
    await _saveSearchKeyword();

    ///TODO: filter the search list
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _searchInputController,
      builder: (context, value, _) {
        return Container(
          decoration: BoxDecoration(
              color: const Color(0xfffff4d3),
              borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
                controller: _searchInputController,
                autofocus: true,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration(
                  errorText: _searchItem == '' && isEditing == false
                      ? 'Field cannot be empty'
                      : null,
                  border: InputBorder.none,
                  hintText: 'Search products',
                  icon: IconButton(
                    icon: const Icon(Icons.search),

                    ///add Searched item button
                    onPressed:
                        value.text.isNotEmpty ? () => _onPressSearch() : null,
                  ),
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          onPressed: () => _searchInputController.clear(),
                          icon: const Icon(Icons.close),
                        )
                      : null,
                ),
                // TODO: Implement onChanged
                onChanged: (value) {
                  isEditing = true;
                }),
          ),
        );
      },
    );
  }
}

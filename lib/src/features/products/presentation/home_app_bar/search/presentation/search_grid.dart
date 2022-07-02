import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/constants/styles.dart';
import '../../../../../../common_widgets/grid_layout.dart';
import '../../../../../../constants/app_sizes.dart';
import '../data/search_product_repository.dart';

/// A widget that displays the list of products that match the search query.
class SearchGrid extends StatefulWidget {
  const SearchGrid({super.key});

  @override
  State<SearchGrid> createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  final _repository = SearchRepository.instance;

  Future<void> _onDeleteItem(String id) async {
    await _repository.deleteItem(context, id);
    setState(() {});
  }

  @override
  void initState() {
    _repository.getSearches();
    print(_repository.getSearches());
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder<List>(
        future: _repository.getSearches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridLayout(
              rowsCount: 2,
              itemCount: snapshot.data?.length,
              itemBuilder: (_, index) {
                final search = snapshot.data![index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: InkWell(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: Sizes.p8),
                          child: Text(
                            search.title,
                            style: kProductTitleSyle,
                          ),
                        ),
                        onTap: () => _repository.searchItem(search.title),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: const Icon(
                          Icons.close,
                          size: Sizes.p12,
                        ),
                        onTap: () => _onDeleteItem(search.id),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

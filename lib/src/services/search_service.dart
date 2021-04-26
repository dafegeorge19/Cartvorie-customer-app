import 'package:cartvorie/src/models/product_search_result.dart';
import 'package:cartvorie/src/services/search_api_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class SearchProductService {
  final ProductSearchApiWrapper productSearchApiWrapper;
  final _searchTerms = BehaviorSubject<String>();

  SearchProductService({@required this.productSearchApiWrapper}) {
    _results = _searchTerms
        .debounce((event) => TimerStream(true, Duration(milliseconds: 300)))
        .switchMap((query) async* {
      print(query);
      yield await productSearchApiWrapper.searchProduct(query);
    });
  }

  void searchProduct(String query) => _searchTerms.add(query);

//
  Stream<ProductSearchResult> _results;

  Stream<ProductSearchResult> get results => _results;

  void dispose() {
    _searchTerms.close();
  }
}

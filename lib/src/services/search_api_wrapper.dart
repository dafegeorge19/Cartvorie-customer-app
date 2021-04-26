import 'dart:convert';

import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/models/product_search_result.dart';
import 'package:http/http.dart' as http;

class ProductSearchApiWrapper {
  Uri searchProductUri(String productName) => Uri(
        scheme: 'https',
        host: "cat-api.codtrix.com",
        path: 'api/v1/search/product/stores',
        queryParameters: {'product_name': productName},
      );

  Future<ProductSearchResult> searchProduct(String productName) async {
    final url = searchProductUri(productName);
    final response = await http.get(url);
    // print(url);

    // print("===== This is the beginning =====");
    // print(response.body);
    // print("===== This is the ending =====");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data?.isNotEmpty ?? false) {
        final products = StoreModel.fromJson(data);
        return ProductSearchResult(products);
      }
      return ProductSearchResult.error(CartvorieApiError.parseError);
    }
    print(
        'Request $url failed \nResponse ${response.statusCode} ${response.reasonPhrase}');
    return ProductSearchResult.error(CartvorieApiError.unknownError);
  }
}

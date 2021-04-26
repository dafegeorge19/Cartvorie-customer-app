import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_search_result.freezed.dart';

enum CartvorieApiError { parseError, unknownError }

@freezed
abstract class ProductSearchResult with _$ProductSearchResult {
  const factory ProductSearchResult(StoreModel storeModel) = Data;
  const factory ProductSearchResult.error(CartvorieApiError error) = Error;
}

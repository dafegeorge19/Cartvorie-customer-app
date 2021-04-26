import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/category_model.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/purchase_history_model.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/services/location_calculator.dart';
import 'package:cartvorie/src/services/profile_service.dart';
import 'package:cartvorie/src/services/shop_service.dart';
import 'package:hooks_riverpod/all.dart';

//get all Stores
final getAllStoresProvider = FutureProvider.autoDispose<StoreModel>((ref) {
  ref.maintainState = true;
  final storeService = ref.watch(shopServiceProvider);
  final stores = storeService.getAllStores();
  return stores;
});
//end

//get all Categories
final getAllCategoriesProvider =
    FutureProvider.autoDispose<CategoryModel>((ref) {
  ref.maintainState = true;
  final categoriesService = ref.watch(shopServiceProvider);
  final categories = categoriesService.getAllCategories();
  return categories;
});
//end

//get all Products
final getAllProductsProvider = FutureProvider.autoDispose<ProductModel>((ref) {
  ref.maintainState = true;
  final productService = ref.watch(shopServiceProvider);
  final products = productService.getAllProducts();
  return products;
});
//end

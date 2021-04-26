import 'package:cartvorie/config/app_api_exceptions.dart';
import 'package:cartvorie/config/base_api.dart';
import 'package:cartvorie/src/models/FeaturedProductsModel.dart';
import 'package:cartvorie/src/models/category_model.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/favorite_model.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/models/settings_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopServiceProvider = Provider<ShopService>((ref) {
  return ShopService(Dio());
});

class ShopService {
  final Dio _dio;

  ShopService(this._dio);

  //get all stores
  Future<StoreModel> getAllStores() async {
    try {
      final response = await _dio.get(BaseApi.stores);
      final Map<String, dynamic> responseData = response.data;
      final result = StoreModel.fromJson(responseData);
      print('gotten  data ${response.data}');
      return result;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }
  //end

  //get all stores
  Future<SettingsModel> getSettingsDetails() async {
    try {
      final response = await _dio.get(BaseApi.settings);
      final Map<String, dynamic> responseData = response.data;
      final result = SettingsModel.fromJson(responseData);
      print('gotten  data ${response.data}');
      return result;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }
  //end

  //get all categories
  Future<CategoryModel> getAllCategories() async {
    try {
      final response = await _dio.get(BaseApi.categories);
      final Map<String, dynamic> responseData = response.data;
      final result = CategoryModel.fromJson(responseData);
      return result;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }

  //end

  //get all products
  Future<ProductModel> getAllProducts() async {
    try {
      final response = await _dio.get(BaseApi.products);
      final Map<String, dynamic> responseData = response.data;
      final result = ProductModel.fromJson(responseData);
      return result;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }

// end
  //get all products in store
  Future<ProductModel> getAllProductsInStoreService(int id) async {
    try {
      final response = await _dio.get("${BaseApi.stores}/$id/products");
      // print('gotten  data ${response.data}');
      final Map<String, dynamic> responseData = response.data;
      final result = ProductModel.fromJson(responseData);
      return result;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }
// end

  //get featured products in a store
  Future<List<ProductData>> getFeaturedProductInStore(int storeId) async {
    List<ProductData> products = [];
    try {
      final response = await _dio.get('${BaseApi.featuredProducts}/$storeId');
      response.data.forEach((element) {
        products.add(ProductData.fromJson(element));
      });
      return products;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }

  //end

  //get related product to a product
  Future<ProductModel> getRelatedProductOfProduct(int productId) async {
    try {
      final response = await _dio.get('${BaseApi.relatedProducts}/$productId');
      final Map<String, dynamic> responseData = response.data;
      final result = ProductModel.fromJson(responseData);
      return result;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }

  //end
  //get all products in a Category
  Future<ProductModel> getAllProductsInCategory(int categoryId) async {
    try {
      final response =
          await _dio.get("${BaseApi.categories}/$categoryId/products");
      final Map<String, dynamic> responseData = response.data;
      final result = ProductModel.fromJson(responseData);
      return result;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }


  
  }

// import 'dart:convert';

// import 'package:cartvorie/config/app_api_exceptions.dart';
// import 'package:cartvorie/config/base_api.dart';
// import 'package:cartvorie/src/models/favorite_model.dart';
// import 'package:cartvorie/src/models/product_model.dart';
// import 'package:cartvorie/src/provider/user_provider.dart';
// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:cartvorie/src/models/purchase_history_model.dart';

// class FavouriteService {
//   static const String url = "${BaseApi.favourites}";
//   final Dio _dio;

//   FavouriteService(this._dio);

//   static Future<List<ProductModel>> getFavouriteHistory(
//       String userToken) async {
//     try {
//       final response = await http.get(url, headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': userToken
//       });

//       // print(response.body["data"]);
//       // var jsonData = json.decode(response.body);
//       // return jsonData["data"];
//       // return favoriteList["data"];
//       if (200 == response.statusCode) {
//         // final List<FavoriteModel> favorite = favoriteModelFromJson(response.body);
//         // final List<ProductModel> favorite = productModelFromJson(response.body);
//         // return favorite;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
// }

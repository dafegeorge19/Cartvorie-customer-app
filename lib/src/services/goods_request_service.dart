import 'dart:convert';

import 'package:cartvorie/config/app_api_exceptions.dart';
import 'package:cartvorie/config/base_api.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:cartvorie/src/models/goods_request_model.dart';

final shopServiceProvider = Provider<GoodsRequestService>((ref) {
  return GoodsRequestService(Dio());
});

class GoodsRequestService {
  static const String url = "${BaseApi.orders}";
  final Dio _dio;

  GoodsRequestService(this._dio);

  static Future<List<GoodsRequestModel>> getGoodsDeliveryService(
      String userToken) async {
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': userToken
      });
      if (200 == response.statusCode) {
        final List<GoodsRequestModel> goodsRequestModel =
            goodsRequestModelFromJson(response.body);
        return goodsRequestModel;
      } else {
        return List<GoodsRequestModel>();
      }
    } catch (e) {
      return List<GoodsRequestModel>();
    }
  }

  static Future<dynamic> getSWData(userToken) async {
    final String urli = "https://cat-api.codtrix.com/api/v1/users/type/all";
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$userToken'
    };
    var res = await http.get(Uri.encodeFull(urli), headers: headers);
    var resBody = json.decode(res.body);
    print(resBody);
    return resBody;
  }
}

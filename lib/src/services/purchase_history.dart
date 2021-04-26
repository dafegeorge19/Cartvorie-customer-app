import 'package:cartvorie/config/app_api_exceptions.dart';
import 'package:cartvorie/config/base_api.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:cartvorie/src/models/purchase_history_model.dart';

final shopServiceProvider = Provider<PurchaseHistoryService>((ref) {
  return PurchaseHistoryService(Dio());
});

class PurchaseHistoryService {
  static const String url = "${BaseApi.orders}";
  final Dio _dio;

  PurchaseHistoryService(this._dio);

  static Future<List<PurchaseHistoryModel>> getPurchaseHistory(
      String userToken) async {
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': userToken
      });
      if (200 == response.statusCode) {
        final List<PurchaseHistoryModel> purchaseHistoryModel =
            purchaseHistoryModelFromJson(response.body);
        return purchaseHistoryModel;
      } else {
        return List<PurchaseHistoryModel>();
      }
    } catch (e) {
      return List<PurchaseHistoryModel>();
    }
  }
}

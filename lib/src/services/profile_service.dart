import 'package:cartvorie/config/app_api_exceptions.dart';
import 'package:cartvorie/config/base_api.dart';
import 'package:cartvorie/src/models/purchase_history_model.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:http/http.dart' as http;

final profileServiceProvider = Provider((ref) => ProfileService());

class ProfileService {
  Dio _dio = Dio();

  Future updateUserProfile(String userToken, UserModel user) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$userToken'
    };
    Map<String, dynamic> body = {
      'firstname': user.user.firstname,
      'lastname': user.user.lastname,
      'phone_number': user.user.phoneNumber,
      'email': user.user.email
    };
    try {
      final response = await _dio.post('${BaseApi.profile}/update',
          options: Options(headers: headers), data: body);
      return response;
    } on DioError catch (dioError) {
      return AppApiExceptions.fromDioError(dioError);
    }
  }
}

import 'dart:convert';
import 'package:cartvorie/config/app_api_exceptions.dart';
import 'package:cartvorie/config/base_api.dart';
import 'package:cartvorie/src/models/AddressModel.dart';
import 'package:cartvorie/src/models/CartModel.dart';
import 'package:cartvorie/src/models/ccr_model.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:http/http.dart' as http;

final userAddressProvider =
    Provider<UserAddressService>((ref) => UserAddressService());

class UserAddressService {
  Dio dio = new Dio(); // with default Options

  Future addAddress(String address, String userToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$userToken'
    };
    try {
      Map<String, dynamic> body = {
        'state_id': 1,
        'area_id': 1,
        'street_address': address
      };
      var response = await dio.post('${BaseApi.address}/store',
          data: body, options: Options(headers: headers));
      print(response.data);
      return response.data;
    } on DioError catch (dioError) {
      String errorMessage = AppApiExceptions.fromDioError(dioError).message;
      return errorMessage;
    }
  }

  Future<List<AddressModel>> getUserAddresses(String userToken) async {
    print('$userToken');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$userToken'
    };
    try {
      final response = await dio.get('${BaseApi.address}',
          options: Options(headers: headers));
      final responseData = response.data;
      List<AddressModel> addresses = [];
      responseData.forEach((e) => addresses.add(AddressModel.fromJson(e)));
      return addresses;
    } on DioError catch (dioError) {
      AppApiExceptions.fromDioError(dioError).toString();
      return null;
    }
  }

  Future deleteUserAddress(int id, userToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$userToken'
    };
    try {
      var response = await dio.delete('${BaseApi.address}/$id',
          options: Options(headers: headers));
      if (response.data == "success") {
        return "Address successfully removed!";
      } else {
        return "Sorry, an error was encounter!";
      }
    } on DioError catch (dioError) {
      AppApiExceptions.fromDioError(dioError);
    }
  }

  Future addFavorite(int id, String userToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$userToken'
    };
    try {
      // Map<String, dynamic> body = {'product_id': id};
      var response = await dio.post('${BaseApi.favourite}',
          data: {'product_id': id}, options: Options(headers: headers));
      print(response.data);
      if (response.data['status'] == 'success') {
        return "Product added to favourite";
      } else {
        return "Error adding product to favourite!";
      }
    } catch (e) {
      String response = "You have to login to your account!";
      return response;
    }
    // } on DioError catch (dioError) {
    //   String errorMessage = AppApiExceptions.fromDioError(dioError).message;
    //   return errorMessage;
    // }
  }

  Future addReview(dynamic formData, String userToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$userToken'
    };
    try {
      // Map<String, dynamic> body = formData;
      var response = await dio.post('${BaseApi.review}',
          data: formData, options: Options(headers: headers));
      print(response);
      return response.data;
    } on DioError catch (dioError) {
      String errorMessage = AppApiExceptions.fromDioError(dioError).message;
      return errorMessage;
    }
  }

  Future<ProductModel> getFavourites(userToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$userToken'
    };
    try {
      final response =
          await dio.get(BaseApi.favourites, options: Options(headers: headers));
      final Map<String, dynamic> responseData = response.data;
      final result = ProductModel.fromJson(responseData);
      return result;
    } on DioError catch (dioError) {
      throw AppApiExceptions.fromDioError(dioError);
    }
  }

  Future addNewOrder(dynamic formData, double cartSubTotal,
      List<CartItem> cartList, String accessToken) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$accessToken'
    };

    // final body = {
    //   "paystack_payment_ref": "5aaO1gJwNbtsJ2mIa6sR2N4eu",
    //   "payment_type": "card",
    //   "amount": 1000,
    //   "tax": 12,
    //   "pay_total": 1000,
    //   "order_type": "thisa",
    //   "total_products_amount": 222.00,
    //   "delivery_fee": 2.00,
    //   "total_products_weight": 244.00,
    //   "delivery_shipping_info": {
    //     "create_account": false,
    //     "account_password": "password",
    //     "billing_firstname": "example11",
    //     "billing_lastname": "example",
    //     "billing_state": "example",
    //     "billing_area": "example",
    //     "billing_street_address": "example",
    //     "billing_phone_number": "example",
    //     "billing_email": "example111",
    //     "deliver_to_different_address": true,
    //     "delivery_firstname": "example",
    //     "delivery_lastname": "example",
    //     "delivery_state": "example",
    //     "delivery_area": "example",
    //     "delivery_street_address": "example",
    //     "delivery_phone_number": "example",
    //     "delivery_email": "example"
    //   },
    //   "with_point": "no",
    //   "cart": '{"4": "7"},  {"4": "1"}'
    // };
    formData["paystack_payment_ref"] = "alsdf3k23k";
    formData["payment_type"] = "Pay on Arrival";
    formData["amount"] = cartSubTotal;
    formData["tax"] = 0.13;
    formData["pay_total"] =
        cartSubTotal + (cartSubTotal * 0.13) + (cartSubTotal * 0.08);
    formData["order_type"] = "Nigeria";
    formData["total_products_amount"] = 122.01;
    formData["delivery_fee"] = 2;
    formData["total_products_weight"] = 0;
    String bodilone = jsonEncode({
      formData["create_account"]: true,
      formData["account_password"]: "password",
      formData["billing_firstname"]: "example11",
      formData["billing_lastname"]: "example",
      formData["billing_state"]: "example",
      formData["billing_area"]: "example",
      formData["billing_street_address"]: "example",
      formData["billing_phone_number"]: "example",
      formData["billing_email"]: "example111",
      formData["deliver_to_different_address"]: true,
      formData["delivery_firstname"]: "example",
      formData["delivery_lastname"]: "example",
      formData["delivery_state"]: "example",
      formData["delivery_area"]: "example",
      formData["delivery_street_address"]: "example",
      formData["delivery_phone_number"]: "example",
      formData["delivery_email"]: 'email'
    });
    formData["delivery_shipping_info"] = bodilone;
    formData["with_point"] = "no";
    formData["cart"] = '{"4": "7"},  {"4": "1"}';
    // try {
    // final response = await http.post('${BaseApi.newOrder}',
    //     headers: headers, body: jsonEncode(body));
    var response = await dio.post('${BaseApi.newOrder}',
        data: formData, options: Options(headers: headers));

    print(response.data);
    // return response;
    // } on DioError catch (dioError) {
    //   return AppApiExceptions.fromDioError(dioError);
    // }
    // Map<String, dynamic> body = formData;
    // var response = await dio.post('${BaseApi.newOrder}',
    //     data: body, options: Options(headers: headers));
    // return response.data;
    // try {
    //   // Map<String, dynamic> body = formData;
    //   var response = await dio.post('${BaseApi.newOrder}',
    //       data: formData, options: Options(headers: headers));
    //   // print(response);
    //   return response.data;
    // } on DioError catch (dioError) {
    //   String errorMessage = AppApiExceptions.fromDioError(dioError).message;
    //   return errorMessage;
    // }
  }
}

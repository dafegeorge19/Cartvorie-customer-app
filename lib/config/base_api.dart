import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseApi {
  static const String liveBaseURL = "https://cat-api.codtrix.com/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/login";
  static const String register = baseURL + "/register";
  static const String verify = baseURL + "/verify";
  static const String stores = baseURL + "/stores";
  static const String featuredProducts = baseURL + "/featured_products";
  static const String relatedProducts = baseURL + "/related_products";
  static const String categories = baseURL + "/categories";
  static const String products = baseURL + "/products";
  static const String address = baseURL + "/addresses";
  static const String profile = baseURL + "/profile";
  static const String user = baseURL + "/user";
  static const String orders = baseURL + "/buyer/orders";
  static const String track = baseURL + "/track";
  static const String favourites = baseURL + "/favourites";
  static const String favourite = baseURL + "/favourite";
  static const String review = baseURL + "/review";
  static const String ccr = baseURL + "/users/type/all";
  static const String newOrder = baseURL + "/order";
  static const String settings = baseURL + "/settings";
  static const String pickup = baseURL + "/pickup/create";
}

final baseApiProvider = Provider<BaseApi>((ref) => BaseApi());

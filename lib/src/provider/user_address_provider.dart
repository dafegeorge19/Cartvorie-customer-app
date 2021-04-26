import 'package:cartvorie/src/models/AddressModel.dart';
import 'package:cartvorie/src/models/ccr_model.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/settings_model.dart';
import 'package:cartvorie/src/services/location_calculator.dart';
import 'package:cartvorie/src/services/profile_service.dart';
import 'package:cartvorie/src/services/shop_service.dart';
import 'package:cartvorie/src/services/user_address_service.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final $family = FutureProvider.autoDispose.family;

final getUserAddresses =
    $family<List<AddressModel>, String>((ref, userToken) async {
  final repo = ref.read(userAddressProvider);
  final result = await repo.getUserAddresses(userToken);
  ref.maintainState = true;
  return result;
});

final getUserFavourites = $family<ProductModel, String>((ref, userToken) async {
  final repo = ref.read(userAddressProvider);
  final result = await repo.getFavourites(userToken);
  ref.maintainState = true;
  return result;
});

// final getUserDistanceToStore =
//     FutureProvider.autoDispose.family<dynamic, String>((ref, address) async {
//   final repo = ref.read(LocationServiceProvider);
//   final result = await repo.getDistanceBetween(address);
//   ref.maintainState = true;
//   return result;
// });

final getDeliveryDistance =
    FutureProvider.autoDispose.family<double, String>((ref, address) async {
  GeoCode geoCode = GeoCode();

  int addresses = address.indexOf("~");

  String address1 = address.substring(0, addresses);
  String address2 = address.substring(addresses + 1);
  // print(address1 + ' ++++++++++++++++' + address2);

  var coordinates1 = await geoCode.forwardGeocoding(address: address1);
  var coordinates2 = await geoCode.forwardGeocoding(address: address2);

  double bearing = Geolocator.distanceBetween(coordinates1.latitude,
      coordinates1.longitude, coordinates2.longitude, coordinates2.longitude);

  final dbtw = bearing / 1000;
  print(dbtw);
  return dbtw;
});

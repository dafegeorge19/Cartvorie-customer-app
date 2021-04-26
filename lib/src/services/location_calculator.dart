import 'package:dio/dio.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as Math;

final LocationServiceProvider = Provider<LocationService>((ref) {
  return LocationService(Dio());
});

class LocationService {
  LocationService(Dio dio);

  Future getDistanceBetween(String address) async {
    GeoCode geoCode = GeoCode();

    int addresses = address.indexOf("~");

    String address1 = address.substring(0, addresses);
    String address2 = address.substring(addresses + 1);
    // print(address1 + ' ++++++++++++++++' + address2);

    var coordinates1 = await geoCode.forwardGeocoding(address: address1);
    var coordinates2 = await geoCode.forwardGeocoding(address: address2);

    // print(coordinates2);
    // print("++++++++++++++");
    // print(coordinates1);

    double bearing = Geolocator.distanceBetween(coordinates1.latitude,
        coordinates1.longitude, coordinates2.longitude, coordinates2.longitude);

    final dbtw = bearing / 1000;
    // print(dbtw);

    return dbtw.toStringAsFixed(0);
  }
}

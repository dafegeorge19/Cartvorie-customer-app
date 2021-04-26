import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:cartvorie/src/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

class StoreHomeTabWidget extends StatefulWidget {
  final StoreData store;

  StoreHomeTabWidget({this.store});

  @override
  _StoreHomeTabWidgetState createState() => _StoreHomeTabWidgetState();
}

class _StoreHomeTabWidgetState extends State<StoreHomeTabWidget> {
  @override
  void initState() {
    super.initState();
    // _getMain();
  }

  String killometer;

  Future _getMain() async {
    GeoCode geoCode = GeoCode();

    var coordinates = await geoCode.forwardGeocoding(
        address: widget.store.addresses.streetAddress);

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double bearing = Geolocator.distanceBetween(position.latitude,
        position.longitude, coordinates.longitude, coordinates.longitude);

    final dbtw = bearing / 1000;

    setState(() {
      killometer = dbtw.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          //   child: ListTile(
          //     dense: true,
          //     contentPadding: EdgeInsets.symmetric(vertical: 0),
          //     leading: Icon(
          //       UiIcons.flag,
          //       color: Theme.of(context).hintColor,
          //     ),
          //     title: Text(
          //       '${widget.store.name}',
          //       style: Theme.of(context).textTheme.display1,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Container(
          //     child: appNetworkImage(widget.store.images.first.original),
          //   ),
          // ),
          // HomeSliderWidget(),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Icon(
                      UiIcons.favorites,
                      color: Theme.of(context).hintColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 4),
                            blurRadius: 9)
                      ],
                    ),
                    child: Text(
                      widget.store.slug,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.store.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Address',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.store.addresses.streetAddress,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),

          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(
                Icons.directions_car_sharp,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Distance',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
          SizedBox(height: 8),
          killometer == null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Calculating...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    killometer + 'Km',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
          Divider(height: 30),
          Row(
            children: [
              Icon(
                Icons.important_devices,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Featured Products',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
          SizedBox(height: 10),
          FlashSalesCarouselWidget(
            storeId: widget.store.id,
            heroTag: UniqueKey().toString(),
          )
        ],
      ),
    );
  }
}

import 'package:cartvorie/config/app_config.dart';
import 'package:cartvorie/src/models/category_model.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/models/route_argument.dart';
import 'package:cartvorie/src/provider/store_provider.dart';
import 'package:cartvorie/config/app_config.dart' as config;
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';

import 'app_network_image.dart';

class StoreGridWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _stores = useProvider(getAllStoresProvider);
    print(_stores.data);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: _stores.when(
          data: (_stores) {
            final stores = _stores.data;
            return StaggeredGridView.countBuilder(
              primary: false,
              shrinkWrap: true,
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 4,
              itemCount: stores.length,
              itemBuilder: (BuildContext context, int index) {
                StoreData store = stores.elementAt(index);
                return _StoreWidget(store: store);
              },
              //staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            );
          },
          loading: () => appLoader,
          error: (e, s) => Text(e.toString())),
    );
  }
}

class StoreSliderWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _stores = useProvider(getAllStoresProvider);

    return _stores.when(
      data: (_stores) {
        final stores = _stores.data;
        return SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stores.length,
            itemBuilder: (BuildContext context, int index) {
              StoreData store = stores.elementAt(index);
              return _StoreWidget(store: store);
            },
          ),
        );
      },
      loading: () => appLoader,
      error: (e, s) => Text(e.toString()),
    );
  }
}

class _StoreWidget extends StatelessWidget {
  const _StoreWidget({
    Key key,
    @required this.store,
  }) : super(key: key);

  final StoreData store;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/Brand', arguments: store);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        width: 140,
        height: 150,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.15),
                  offset: Offset(0, 3),
                  blurRadius: 10)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              // width: MediaQuery.of(context).size.width,
              height: 80.0,
              width: config.App(context).appWidth(50.0),
              // height: config.App(context).appHeight(20.0),
              child: appNetworkImage(store.images.first.original),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 7.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: Theme.of(context).textTheme.body2,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  SizedBox(height: 12.0),
                  StoreLocationHandler(store: store)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoreLocationHandler extends StatefulWidget {
  const StoreLocationHandler({
    Key key,
    @required this.store,
  }) : super(key: key);

  final StoreData store;

  @override
  _StoreLocationHandlerState createState() => _StoreLocationHandlerState();
}

class _StoreLocationHandlerState extends State<StoreLocationHandler> {
  String _killometer;

  @override
  void initState() {
    super.initState();
    _getMain();
  }

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
      _killometer = dbtw.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          children: [
            SvgPicture.asset(
              'img/location.svg',
              height: 15.0,
              width: 15.0,
              color: Color(0xFF7401E0),
            ),
            SizedBox(width: 3),
            Text(
              _killometer == null
                  ? 'Calculating...'
                  : _killometer.toString() + "Km",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        // Positioned(
        //   right: 0,
        //   child: GestureDetector(
        //     onTap: () {
        //       print("You just favouritize this.");
        //     },
        //     child: Icon(
        //       Icons.favorite_sharp,
        //       color: Color(0xFF7401E0),
        //       size: 18,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

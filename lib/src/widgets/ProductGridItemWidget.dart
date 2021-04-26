import 'package:cartvorie/src/models/product.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/route_argument.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/widgets/Favoriting.dart';
import 'package:flutter/material.dart';
import 'package:cartvorie/config/app_config.dart' as config;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'app_network_image.dart';

class ProductGridItemWidgetFavourite extends StatelessWidget {
  const ProductGridItemWidgetFavourite({
    Key key,
    @required this.product,
    @required this.heroTag,
  }) : super(key: key);

  final ProductData product;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                argumentsList: [this.product, this.heroTag],
                id: this.product.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.10),
                offset: Offset(0, 4),
                blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 110,
              width: double.maxFinite,
              child: Hero(
                tag: this.heroTag + product.id.toString() + product.name,
                child: appNetworkImage(product.images.first.original),
              ),
            ),
            SizedBox(height: 10),
            FeatureProductName(product: product),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                product.price,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${product.stock} in Stock',
                      style: Theme.of(context).textTheme.body1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                  Text(
                    product.salesPrice.toString(),
                    style: Theme.of(context).textTheme.body2,
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class ProductGridItemWidget extends StatelessWidget {
  const ProductGridItemWidget({
    Key key,
    @required this.product,
    @required this.heroTag,
  }) : super(key: key);

  final ProductData product;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                argumentsList: [this.product, this.heroTag],
                id: this.product.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.10),
                offset: Offset(0, 4),
                blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 110,
              width: double.maxFinite,
              child: Hero(
                tag: this.heroTag + product.id.toString() + product.name,
                child: appNetworkImage(product.images.first.original),
              ),
            ),
            SizedBox(height: 10),
            FeatureProductName(product: product),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                product.price,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${product.stock} in Stock',
                      style: Theme.of(context).textTheme.body1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                  Text(
                    product.salesPrice.toString(),
                    style: Theme.of(context).textTheme.body2,
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class ProductStoreGridItemWidget extends StatefulWidget {
  const ProductStoreGridItemWidget({
    Key key,
    @required this.product,
    @required this.heroTag,
  }) : super(key: key);

  final ProductData product;
  final String heroTag;

  @override
  _ProductStoreGridItemWidgetState createState() =>
      _ProductStoreGridItemWidgetState();
}

class _ProductStoreGridItemWidgetState
    extends State<ProductStoreGridItemWidget> {
  String _killometer;

  @override
  void initState() {
    super.initState();
    _getMain();
  }

  Future _getMain() async {
    GeoCode geoCode = GeoCode();

    var coordinates = await geoCode.forwardGeocoding(
        address: widget.product.store.streetAddress);

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
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed('/Brand', arguments: widget.product.store);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: 110,
            width: double.maxFinite,
            child: Hero(
              tag: this.widget.heroTag +
                  widget.product.id.toString() +
                  widget.product.name,
              child:
                  appNetworkImage(widget.product.store.images.first.original),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.product.store.name,
              style: Theme.of(context).textTheme.body2,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'img/location.svg',
                  height: 18.0,
                  width: 18.0,
                  color: Color(0xFF7401E0),
                ),
                SizedBox(width: 3),
                Text(
                  _killometer == null
                      ? 'Calculating...'
                      : _killometer.toString() + "Km",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

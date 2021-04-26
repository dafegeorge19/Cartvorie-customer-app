import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/models/product_search_result.dart';
import 'package:cartvorie/src/services/search_service.dart';
import 'package:cartvorie/src/widgets/ProductGridItemWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cartvorie/config/app_config.dart' as config;
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

class ProductSearchDelegate extends SearchDelegate<StoreModel> {
  final SearchProductService searchProductService;

  ProductSearchDelegate(this.searchProductService);

  @override
  List<Widget> buildActions(BuildContext context) {
    return query.isEmpty
        ? []
        : <Widget>[
            IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    searchProductService.searchProduct(query);
    return buildMatchingSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    searchProductService.searchProduct(query);
    return buildMatchingSuggestions(context);
  }

  Widget buildMatchingSuggestions(BuildContext context) {
    final Map<CartvorieApiError, String> errorMessages = {
      CartvorieApiError.parseError: "Error reading data from the API",
      CartvorieApiError.unknownError: 'Unknown error',
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: StreamBuilder<ProductSearchResult>(
          stream: searchProductService.results,
          builder: (context, AsyncSnapshot<ProductSearchResult> snapshot) {
            if (snapshot.hasData) {
              final ProductSearchResult result = snapshot.data;
              return result.when(
                  (storeModel) => GridView.builder(
                        itemCount: storeModel.data.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          final store = storeModel.data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/Brand', arguments: store);
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
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.15),
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
                                    child: appNetworkImage(
                                        store.images.first.original),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 7.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          store.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .body2,
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
                        },
                      ),
                  error: (error) =>
                      SearchPlaceholder(title: errorMessages[error]));
            } else {
              return Center(child: appLoader);
            }
          }),
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

class SearchPlaceholder extends StatelessWidget {
  const SearchPlaceholder({@required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Text(
        title,
        style: theme.textTheme.headline5,
        textAlign: TextAlign.center,
      ),
    );
  }
}

import 'package:cartvorie/config/app_api_key.dart';
import 'package:cartvorie/config/route_guard.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/src/models/favorite_model.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/user.dart';
import 'package:cartvorie/src/provider/user_address_provider.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/favourite_service.dart';
import 'package:cartvorie/src/services/shop_service.dart';
import 'package:cartvorie/src/services/user_address_service.dart';
import 'package:cartvorie/src/widgets/DrawerWidget.dart';
import 'package:cartvorie/src/widgets/FilterWidget.dart';
import 'package:cartvorie/src/widgets/ProductGridItemWidget.dart';
import 'package:cartvorie/src/widgets/ProfileSettingsDialog.dart';
import 'package:cartvorie/src/services/user_address_service.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:cartvorie/src/widgets/FavoriteGridItemWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/app_network_image.dart';
import 'package:cartvorie/src/widgets/error_widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:cartvorie/config/app_config.dart' as config;
import 'package:progress_dialog/progress_dialog.dart';

final $family = FutureProvider.autoDispose.family;

class UserFavorite extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final _user = useProvider(getUserProvider);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final kInitialPosition = LatLng(56.1304, 106.3468);
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 80;
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        endDrawer: FilterWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Favourites",
            style: Theme.of(context).textTheme.display1,
          ),
          actions: <Widget>[
            ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor),
            GuardedWidget(
              guardedWidget: Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(300),
                    onTap: () {
                      Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('img/logo.png'),
                    ),
                  )),
            )
          ],
        ),
        body: _user.when(
            data: (_user) {
              return RefreshIndicator(
                onRefresh: () =>
                    context.refresh(getUserFavourites(_user.accessToken)),
                child: SingleChildScrollView(
                  child: GetFavourites(_user.accessToken),
                ),
              );
            },
            loading: () => appLoader,
            error: (e, s) => Text('${e.toString()}')));
  }
}

class GetFavourites extends HookWidget {
  final String accessToken;
  GetFavourites(this.accessToken);

  @override
  Widget build(BuildContext context) {
    final _userFavourites = useProvider(getUserFavourites(accessToken));
    return Container(
      child: _userFavourites.when(
          data: (_userFavourites) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: new StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: _userFavourites.data.length,
                itemBuilder: (BuildContext context, int index) {
                  ProductData product = _userFavourites.data.elementAt(index);
                  return ProductGridItemWidgetFavourite(
                    product: product,
                    heroTag: 'products_by_category_grid',
                  );
                },
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
            );
          },
          loading: () => appLoader,
          error: (e, s) => AppErrorWidget(
              errorMessage: e.toString(),
              provider: getUserFavourites(accessToken))),
    );
  }
}

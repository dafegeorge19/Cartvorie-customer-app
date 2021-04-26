import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartvorie/config/route_guard.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/src/models/notification.dart' as model;
import 'package:cartvorie/src/models/purchase_history_model.dart';
import 'package:cartvorie/src/provider/user_address_provider.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/profile_service.dart';
import 'package:cartvorie/src/services/purchase_history.dart';
import 'package:cartvorie/src/widgets/DrawerWidget.dart';
import 'package:cartvorie/src/widgets/EmptyNotificationsWidget.dart';
import 'package:cartvorie/src/widgets/NotificationItemWidget.dart';
import 'package:cartvorie/src/widgets/SearchBarWidget.dart';
import 'package:cartvorie/src/widgets/gradientButton.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:cartvorie/src/services/shop_service.dart';

class WalletPoints extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final _user = useProvider(getUserProvider);
    final kInitialPosition = LatLng(56.1304, 106.3468);
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 80;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Wallet / Point Earned",
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
          Container(
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
        ],
      ),
      body: _user.when(
          data: (_user) {
            return RefreshIndicator(
              onRefresh: () =>
                  context.refresh(getUserAddresses(_user.accessToken)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ListView(
                  // padding: EdgeInsets.symmetric(vertical: 20),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.15),
                              offset: Offset(0, 3),
                              blurRadius: 10)
                        ],
                      ),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Purchase 10 products and earn 100points, 100points equals \$10 Discount on all purchase",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                          ///add avatar
                          Positioned(
                            top: -12,
                            right: 0,
                            child: SizedBox(
                              width: 5,
                              height: 5,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(300),
                                onTap: () {},
                                child: Icon(
                                  Icons.cancel,
                                  color: Color(0xFFCC00FF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _cardInfo(categoryHeight, "Total Purchase",
                                _user.user.orders),
                            _cardInfo(categoryHeight, "Total Points",
                                _user.user.points),
                            _cardInfo(categoryHeight, "Point Used",
                                _user.user.points),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    DataTable(
                      dataRowHeight: 30,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Month',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Pending Points',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Purchase',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Apr',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500))),
                            DataCell(Text('23',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500))),
                            DataCell(Text('30',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)))
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('May',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500))),
                            DataCell(Text('25',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500))),
                            DataCell(Text('30',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => appLoader,
          error: (e, s) => Text('${e.toString()}')),
    );
  }
}

class _cardInfo extends StatelessWidget {
  const _cardInfo(this.categoryHeight, this._title, this._value);

  final double categoryHeight;
  final String _title;
  final dynamic _value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 240,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _value == null ? "0" : _value.toString(),
              style: TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              _title,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

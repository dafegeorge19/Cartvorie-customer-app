import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/src/models/notification.dart' as model;
import 'package:cartvorie/src/models/goods_request_model.dart';
import 'package:cartvorie/src/models/purchase_history_model.dart';
import 'package:cartvorie/src/provider/user_address_provider.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/profile_service.dart';
import 'package:cartvorie/src/services/goods_request_service.dart';
import 'package:cartvorie/src/widgets/DrawerWidget.dart';
import 'package:cartvorie/src/widgets/EmptyNotificationsWidget.dart';
import 'package:cartvorie/src/widgets/NotificationItemWidget.dart';
import 'package:cartvorie/src/widgets/SearchBarWidget.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:cartvorie/src/services/shop_service.dart';

class GoodsDeliveryStatus extends StatefulWidget {
  @override
  _GoodsDeliveryStatusState createState() => _GoodsDeliveryStatusState();
}

class _GoodsDeliveryStatusState extends State<GoodsDeliveryStatus> {
  List<GoodsRequestModel> _goodsDeliveryService;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    UserPreferences.getUserToken().then((value) {
      GoodsRequestService.getGoodsDeliveryService(value)
          .then((goodsDeliveryService) {
        setState(() {
          _goodsDeliveryService = goodsDeliveryService;
          print(_goodsDeliveryService);
          _loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
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
          "Goods Requests",
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
      body: _goodsDeliveryService?.isEmpty ?? true
          ? Center(
              child: appLoader,
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                top: 10,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                GoodsRequestModel phm = _goodsDeliveryService[index];
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 2),
                          blurRadius: 3)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: AssetImage("img/delivered.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "\$" + phm.totalProductsAmount,
                                  // "\$" + "18,000",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style:
                                      Theme.of(context).textTheme.body2.merge(
                                            TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                ),
                                Text(
                                  "Status: " + phm.status,
                                  // "10Km",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .body2
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ActionBtn(
                                  child: Text(
                                    'Call',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFCC00FF),
                                      Color(0xFF7401E0)
                                    ],
                                  ),
                                  onPressed: () {
                                    print('button clicked');
                                  },
                                ),
                                ActionBtn(
                                  child: Text(
                                    'Message',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFCC00FF),
                                      Color(0xFF7401E0)
                                    ],
                                  ),
                                  onPressed: () {
                                    print('button clicked');
                                  },
                                ),
                                ActionBtn(
                                  child: Text(
                                    'Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFCC00FF),
                                      Color(0xFF7401E0)
                                    ],
                                  ),
                                  onPressed: () {
                                    print('button clicked');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

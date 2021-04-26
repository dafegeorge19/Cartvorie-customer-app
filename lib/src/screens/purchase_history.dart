import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:cartvorie/src/services/shop_service.dart';

class PurchaseHistory extends StatefulWidget {
  @override
  _PurchaseHistoryState createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  List<PurchaseHistoryModel> _purchaseHistoryList;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    UserPreferences.getUserToken().then((value) {
      PurchaseHistoryService.getPurchaseHistory(value)
          .then((purchaseHistoryList) {
        setState(() {
          _purchaseHistoryList = purchaseHistoryList;
          print(_purchaseHistoryList);
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
          _loading ? "Loading..." : 'Purchase History',
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
      body: _purchaseHistoryList?.isEmpty ?? true
          ? Center(
              child: Text("No record found!"),
            )
          : ListView.builder(
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                // PurchaseHistoryModel phm = _purchaseHistoryList[index];
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "\$" + phm.totalProductsAmount,
                                "\$" + "18,000",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.body2.merge(
                                      TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                // "Status: " + phm.status,
                                "Status: Pending",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.body2.merge(
                                    TextStyle(fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // "Date: " + phm.createdAt.toString(),
                                "Date: 04/23/2020",
                                style:
                                    Theme.of(context).textTheme.caption.merge(
                                          TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          ),
                                        ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 50,
                                  margin: EdgeInsets.only(right: 20),
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.2),
                                          offset: Offset(0, 4),
                                          blurRadius: 9)
                                    ],
                                  ),
                                  child: Center(
                                    // padding: EdgeInsets.all(13),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Details",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

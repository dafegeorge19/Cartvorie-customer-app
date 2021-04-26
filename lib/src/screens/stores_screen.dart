import 'package:cartvorie/config/route_guard.dart';
import 'package:cartvorie/src/widgets/DrawerWidget.dart';
import 'package:cartvorie/src/widgets/SearchBarWidget.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:cartvorie/src/widgets/StoreGridWidget.dart';
import 'package:flutter/material.dart';

class StoresWidget extends StatefulWidget {
  @override
  _StoresWidgetState createState() => _StoresWidgetState();
}

class _StoresWidgetState extends State<StoresWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          'Stores',
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
                  )))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Wrap(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: SearchBarWidget(),
            // ),
            // StoreGridWidget(storesList: _storesList),
            StoreGridWidget(),
          ],
        ),
      ),
    );
  }
}

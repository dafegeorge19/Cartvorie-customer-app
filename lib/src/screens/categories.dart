import 'package:cartvorie/config/route_guard.dart';
import 'package:cartvorie/src/models/route_argument.dart';
import 'package:cartvorie/src/widgets/CategoriesGridWidget.dart';
import 'package:cartvorie/src/widgets/DrawerWidget.dart';
import 'package:cartvorie/src/widgets/SearchBarWidget.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Categories',
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
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: CategoryGridWidget(),
      ),
    );
  }
}

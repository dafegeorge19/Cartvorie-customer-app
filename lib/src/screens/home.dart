import 'dart:async';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/store_model.dart';
import 'package:cartvorie/src/models/category.dart';
import 'package:cartvorie/src/models/product.dart';
import 'package:cartvorie/src/provider/store_provider.dart';
import 'package:cartvorie/src/services/shop_service.dart';
import 'package:cartvorie/src/widgets/AllProductsGridWidget.dart';
import 'package:cartvorie/src/widgets/AvailableProgressBarWidget.dart';
import 'package:cartvorie/src/widgets/CategoriesGridWidget.dart';
import 'package:cartvorie/src/widgets/StoreGridWidget.dart';
import 'package:cartvorie/src/widgets/StoresIconsCarouselWidget.dart';
import 'package:cartvorie/src/widgets/CategoriesIconsCarouselWidget.dart';
import 'package:cartvorie/src/widgets/CategorizedProductsWidget.dart';
import 'package:cartvorie/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:cartvorie/src/widgets/FlashSalesWidget.dart';
import 'package:cartvorie/src/widgets/HomeSliderWidget.dart';
import 'package:cartvorie/src/widgets/SearchBarWidget.dart';
import 'package:cartvorie/src/widgets/all_products.dart';
import 'package:cartvorie/src/widgets/store_getter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:cartvorie/src/widgets/topNavigation.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  Animation animationOpacity;
  AnimationController animationController;

  @override
  void initState() {
    // getUserLocation();
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();

    // _productsOfCategoryList = _categoriesList.list.firstWhere((category) {
    //   return category.selected;
    // }).products;

    // _productsOfStoreList = _brandsList.list.firstWhere((brand) {
    //   return brand.selected;
    // },).products;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.refresh(shopServiceProvider).getAllStores();
      },
      child: ListView(
        children: <Widget>[
          TopNavigationBar(),
          HomeSliderWidget(),
          SizedBox(height: 10),
          StickyHeader(
            header: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      UiIcons.placeholder,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 14),
                    Text(
                      'Stores Near You',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            content: StoreSliderWidget(),
          ),
          StickyHeader(
            header: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      UiIcons.layers,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 14),
                    Text(
                      'Top Categories',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            // content: CategoryGridWidget(),
            content: CategorySliderWidget(),
          ),
          SizedBox(
            height: 15,
          ),
          _shortIntro(),
          SizedBox(height: 10),
          StickyHeader(
            header: Container(
              color: Colors.white,
              // margin: EdgeInsets.symmetric(
              //   vertical: 10,
              // ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      UiIcons.layers,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 14),
                    Text(
                      'Other Stores',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            // content: ProductsGridWidget(),
            content: StoreGridWidget(),
          ),
        ],
      ),
    );
    //],
    //);
  }
}

class _shortIntro extends StatelessWidget {
  const _shortIntro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: BoxDecoration(
        // color: Color(0xFF662D91),
        gradient: LinearGradient(
          colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.dstATop),
          image: AssetImage("img/slider4.jpg"),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Text(
                  "Need Pickup & Delivery Service?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 7),
              Text(
                "We can help",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // GestureDetector(),
            ],
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 3);
            },
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white),
            ),
            child: Text(
              "Pickup Request",
              textAlign: TextAlign.start,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/product.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/provider/store_provider.dart';
import 'package:cartvorie/src/screens/stores_screen.dart';
import 'package:cartvorie/src/services/search_api_wrapper.dart';
import 'package:cartvorie/src/services/search_service.dart';
import 'package:cartvorie/src/widgets/AllProductsGridWidget.dart';
import 'package:cartvorie/src/widgets/EmptyFavoritesWidget.dart';
import 'package:cartvorie/src/widgets/FavoriteListItemWidget.dart';
import 'package:cartvorie/src/widgets/ProductGridItemWidget.dart';
import 'package:cartvorie/src/widgets/ProductSearchDelegate.dart';
import 'package:cartvorie/src/widgets/SearchBarWidget.dart';
import 'package:cartvorie/src/widgets/StoreGridWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchWidget extends StatelessWidget {
  void _showSearch(BuildContext context) async {
    final searchService = SearchProductService(
        productSearchApiWrapper: ProductSearchApiWrapper());
    final product = await showSearch(
        context: context, delegate: ProductSearchDelegate(searchService));
    searchService.dispose();
    print(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //         icon: Icon(
      //           Icons.search,
      //           color: Theme.of(context).accentColor,
      //         ),
      //         onPressed: () => _showSearch(context))
      //   ],
      // ),
      // body: AllProductsGridWidget(),
      body: SingleChildScrollView(
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // child: SearchBarWidget(),
              child: Center(
                child: Text(
                  "Search product according to store: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // StoreGridWidget(storesList: _storesList),
            StoreGridWidget(),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
        ),
        child: FlatButton(
            onPressed: () => _showSearch(context),
            child: Icon(
              Icons.search,
              size: 16,
              color: Colors.white,
            )),
      ),
    );
  }
}

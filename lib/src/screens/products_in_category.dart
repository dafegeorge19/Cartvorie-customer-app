import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/category_model.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/services/shop_service.dart';
import 'package:cartvorie/src/widgets/ProductGridItemWidget.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/all.dart';

final $family = FutureProvider.autoDispose.family;

// get Product Products in Store
final getAllProductsInCategoryProvider =
    $family<ProductModel, int>((ref, id) async {
  final repository = ref.read(shopServiceProvider);
  final result = await repository.getAllProductsInCategory(id);
  ref.maintainState = true;
  print(result.toString());
  return result;
});

// end
class ProductsByCategoryWidget extends StatefulWidget {
  final CategoryData category;
  ProductsByCategoryWidget({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  _ProductsByCategoryWidgetState createState() =>
      _ProductsByCategoryWidgetState();
}

class _ProductsByCategoryWidgetState extends State<ProductsByCategoryWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String layout = 'grid';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category.name} Products',
          style: Theme.of(context).textTheme.display1,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          margin: EdgeInsets.only(bottom: 30),
          child: Wrap(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 10),
              //   // child: ListTile(
              //   //   dense: true,
              //   //   contentPadding: EdgeInsets.symmetric(vertical: 0),
              //   //   leading: Icon(
              //   //     UiIcons.box,
              //   //     color: Theme.of(context).hintColor,
              //   //   ),
              //   //   title: Text(
              //   //     '${widget.category.name} Products',
              //   //     overflow: TextOverflow.fade,
              //   //     softWrap: false,
              //   //     style: Theme.of(context).textTheme.display1,
              //   //   ),
              //   //   // trailing: Row(
              //   //   //   mainAxisSize: MainAxisSize.min,
              //   //   //   children: <Widget>[
              //   //   //     IconButton(
              //   //   //       onPressed: () {
              //   //   //         setState(() {
              //   //   //           this.layout = 'list';
              //   //   //         });
              //   //   //       },
              //   //   //       icon: Icon(
              //   //   //         Icons.format_list_bulleted,
              //   //   //         color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
              //   //   //       ),
              //   //   //     ),
              //   //   //     IconButton(
              //   //   //       onPressed: () {
              //   //   //         setState(() {
              //   //   //           this.layout = 'grid';
              //   //   //         });
              //   //   //       },
              //   //   //       icon: Icon(
              //   //   //         Icons.apps,
              //   //   //         color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
              //   //   //       ),
              //   //   //     )
              //   //   //   ],
              //   //   // ),
              //   // ),
              // ),
              Offstage(
                offstage: this.layout != 'grid',
                child: Consumer(
                  builder: (context, watch, child) {
                    print(widget.category);

                    final _productsProvider = watch(
                        getAllProductsInCategoryProvider(widget.category.id));
                    print(_productsProvider.data.toString());
                    return _productsProvider.when(
                        data: (_productsProvider) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: new StaggeredGridView.countBuilder(
                              primary: false,
                              shrinkWrap: true,
                              crossAxisCount: 4,
                              itemCount: _productsProvider.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                ProductData product =
                                    _productsProvider.data.elementAt(index);
                                return ProductGridItemWidget(
                                  product: product,
                                  heroTag: 'products_by_category_grid',
                                );
                              },
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(2),
                              mainAxisSpacing: 15.0,
                              crossAxisSpacing: 15.0,
                            ),
                          );
                        },
                        loading: () => appLoader,
                        error: (e, s) => Text('${e.toString()}'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

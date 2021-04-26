import 'package:cartvorie/src/models/product.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/provider/store_provider.dart';
import 'package:cartvorie/src/widgets/ProductGridItemWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/all.dart';

class AllProductsGridWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _products = useProvider(getAllProductsProvider);
    return RefreshIndicator(
      onRefresh: () => context.refresh(getAllProductsProvider),
      child: Container(
        child: _products.when(
            data: (_products) {
              final products = _products.data;
              return StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 15),
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 2
                        : 4,
                itemCount: products.length,
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                itemBuilder: (context, index) {
                  ProductData productData = products[index];
                  return ProductGridItemWidget(
                      product: productData,
                      heroTag: productData.id.toString() + productData.name);
                },
              );
            },
            loading: () => appLoader,
            error: (e, s) => AppErrorWidget(
                  errorMessage: e.toString(),
                  provider: getAllProductsProvider,
                )),
      ),
    );
  }
}

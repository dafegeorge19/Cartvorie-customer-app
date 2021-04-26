import 'package:cartvorie/src/models/FeaturedProductsModel.dart';
import 'package:cartvorie/src/models/product.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/provider/store_provider.dart';
import 'package:cartvorie/src/services/shop_service.dart';
import 'package:cartvorie/src/widgets/FlashSalesCarouselItemWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

final $family = FutureProvider.autoDispose.family;

// provide featured products in store
final provideFearedProductsInStore =
    $family<List<ProductData>, int>((ref, id) async {
  final repository = ref.read(shopServiceProvider);
  final result = repository.getFeaturedProductInStore(id);
  ref.maintainState = true;
  print(result);
  return result;
});
//end

class FlashSalesCarouselWidget extends HookWidget {
  final int storeId;
  final String heroTag;

  FlashSalesCarouselWidget({Key key, this.heroTag, this.storeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providedProduct = useProvider(provideFearedProductsInStore(storeId));
    return providedProduct.when(
        data: (providedProduct) {
          final productsList = providedProduct;
          return Container(
              height: 180,
              // margin: EdgeInsets.only(top: 8, bottom: 16),
              child: ListView.builder(
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  double _marginLeft = 0;
                  (index == 0) ? _marginLeft = 3 : _marginLeft = 0;
                  return FlashSalesCarouselItemWidget(
                    heroTag: this.heroTag,
                    marginLeft: _marginLeft,
                    product: productsList.elementAt(index),
                  );
                },
                scrollDirection: Axis.horizontal,
              ));
        },
        loading: () => appLoader,
        error: (e, s) => Text('${e.toString()}'));
  }
}

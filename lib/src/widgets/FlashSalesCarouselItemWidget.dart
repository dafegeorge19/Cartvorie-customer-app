import 'package:cartvorie/src/models/FeaturedProductsModel.dart';
import 'package:cartvorie/src/models/product.dart';
import 'package:cartvorie/src/models/product_model.dart';
import 'package:cartvorie/src/models/route_argument.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/user_address_service.dart';
import 'package:cartvorie/src/widgets/AvailableProgressBarWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/Favoriting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FlashSalesCarouselItemWidget extends StatelessWidget {
  final String heroTag;
  final double marginLeft;
  final ProductData product;

  FlashSalesCarouselItemWidget({
    Key key,
    this.heroTag,
    this.marginLeft,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                id: product.id, argumentsList: [product, heroTag]));
      },
      child: Container(
        margin: EdgeInsets.only(left: this.marginLeft, right: 20),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: 140,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ]),
          child: Wrap(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: heroTag + product.id.toString() + UniqueKey().toString(),
                  child: Stack(
                    // alignment: AlignmentDirectional.topCenter,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(product.images.first.original),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFFCC00FF),
                                Color(0xFF7401E0)
                              ],
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
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(
                            '${product.salesPrice} ',
                            style: Theme.of(context)
                                .textTheme
                                .body2
                                .merge(TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                FeatureProductName(product: product),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    '${product.stock} Stock',
                    style: Theme.of(context).textTheme.body1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AvailableProgressBarWidget(
                    available: double.parse(product.stock),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

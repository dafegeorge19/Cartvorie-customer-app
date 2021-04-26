import 'package:cartvorie/src/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cartvorie/src/models/FeaturedProductsModel.dart';
import 'package:cartvorie/src/models/product.dart';

import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/user_address_service.dart';

import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/error_widget.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FeatureProductName extends HookWidget {
  const FeatureProductName({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    final _user = useProvider(getUserProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              product.name,
              style: Theme.of(context).textTheme.body2,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          _user.when(
              data: (_user) {
                return GestureDetector(
                  onTap: () {
                    _addFavorite(product.id, _user.accessToken,
                        context: context);
                  },
                  child: Icon(
                    Icons.favorite_sharp,
                    color: Color(0xFF7401E0),
                    size: 22,
                  ),
                );
              },
              loading: () => appLoader,
              error: (e, s) => AppErrorWidget(
                  errorMessage: e.toString(), provider: getUserProvider))
        ],
      ),
    );
  }

  void _addFavorite(int id, String accessToken, {BuildContext context}) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();

    final response =
        await context.read(userAddressProvider).addFavorite(id, accessToken);
    await dialog.hide();

    Scaffold.of(context)
        .showSnackBar(SnackBar(
          backgroundColor: Color(0xFF7401E0),
          content: Text(
            response.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          duration: new Duration(milliseconds: 1200),
        ))
        .closed
        .then((_) {
      context.refresh(getUserProvider);
    });
  }
}

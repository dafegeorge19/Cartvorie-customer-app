import 'package:cartvorie/src/models/category_model.dart';
import 'package:cartvorie/src/provider/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_loader.dart';

class CategoryGridWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _categories = useProvider(getAllCategoriesProvider);

    /// Categories grid
    return _categories.when(
      data: (_categories) {
        final categories = _categories.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: StaggeredGridView.countBuilder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 15),
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 4,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              CategoryData category = categories.elementAt(index);
              return InkWell(
                onTap: () {
                  /// navigate to products in Categories
                  Navigator.of(context)
                      .pushNamed('/Category', arguments: category);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: 140,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.15),
                            offset: Offset(0, 3),
                            blurRadius: 10)
                      ]),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        ),
                        Text(
                          '${category.name.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            // mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
          ),
        );
      },
      loading: () => appLoader,
      error: (e, s) => Text(
        e.toString(),
      ),
    );
  }
}

class CategorySliderWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _categories = useProvider(getAllCategoriesProvider);

    return _categories.when(
      data: (_categories) {
        final categories = _categories.data;
        return SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              CategoryData category = categories.elementAt(index);
              return InkWell(
                onTap: () {
                  /// navigate to products in Categories
                  Navigator.of(context)
                      .pushNamed('/Category', arguments: category);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  // width: 100,
                  height: 140,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.15),
                            offset: Offset(0, 3),
                            blurRadius: 10)
                      ]),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        ),
                        Text(
                          '${category.name.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => appLoader,
      error: (e, s) => Text(
        e.toString(),
      ),
    );
  }
}

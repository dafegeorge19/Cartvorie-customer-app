import 'package:cartvorie/config/route_guard.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/src/models/user.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/authentication_service.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class DrawerWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _user = useProvider(getUserProvider);
    // TODO: implement build
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/Tabs', arguments: 1);
              },
              child: RouteGuard(
                guardedWidget: _user.when(
                  data: (_user) => UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      // borderRadius: BorderRadius.only(
                      //     bottomLeft: Radius.circular(35)),
                    ),
                    accountName: Text(
                      "${_user.user.firstname.toString().toUpperCase()} ${_user.user.lastname.toString().toUpperCase()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    accountEmail: Text(
                      _user.user.email ?? "Your email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).hintColor,
                      backgroundImage: AssetImage('img/logo.png'),
                    ),
                  ),
                  loading: () => appLoader,
                  error: (e, s) => Text('error loading user'),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Tabs', arguments: 2);
              },
              leading: Icon(
                UiIcons.home,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Home",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Brands');
              },
              leading: Icon(
                Icons.food_bank_outlined,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Grocery Delivery",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Tabs', arguments: 3);
              },
              leading: Icon(
                Icons.bus_alert,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Pickup & Delivery",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/TrackDelivery');
              },
              leading: Icon(
                Icons.track_changes_outlined,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Track Your Delivery",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Brands');
              },
              leading: Icon(
                Icons.store_mall_directory_outlined,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Stores",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Categories');
              },
              leading: Icon(
                UiIcons.folder,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Categories",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Tabs', arguments: 4);
              },
              leading: Icon(
                UiIcons.shopping_cart,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Products",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            //   },
            //   leading: Icon(
            //     UiIcons.bell,
            //     color: Theme.of(context).focusColor.withOpacity(1),
            //   ),
            //   title: Text(
            //     "Notifications",
            //     style: Theme.of(context).textTheme.subhead,
            //   ),
            // ),
            GuardedWidget(
              guardedWidget: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/PurchaseHistory');
                    },
                    leading: Icon(
                      Icons.history_outlined,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Purchase History",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/WalletPoint');
                    },
                    leading: Icon(
                      UiIcons.bar_chart,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Wallet / Points",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Favorite');
                    },
                    leading: Icon(
                      UiIcons.heart,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Favourite",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/LiveTracking');
                    },
                    leading: Icon(
                      UiIcons.car,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Live Tracking",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/GoodsDeliveryStatus');
                    },
                    leading: Icon(
                      UiIcons.car,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Goods Delivery Status",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/chat');
                    },
                    leading: Icon(
                      UiIcons.chat,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Message",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/contactadmin');
                    },
                    leading: Icon(
                      UiIcons.user_3,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Contact Admin",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/settings');
                    },
                    leading: Icon(
                      UiIcons.settings,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Settings",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed('/faq');
                  //   },
                  //   leading: Icon(
                  //     UiIcons.books,
                  //     color: Theme.of(context).focusColor.withOpacity(1),
                  //   ),
                  //   title: Text(
                  //     "FAQ",
                  //     style: Theme.of(context).textTheme.subhead,
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      context.read(authenticationProvider).logout();
                      // useState(
                      //     Flushbar(title: "Logged Out",message: 'logged out successfully',)
                      // );
                    },
                    leading: Icon(
                      UiIcons.upload,
                      color: Theme.of(context).focusColor.withOpacity(1),
                    ),
                    title: Text(
                      "Log out",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

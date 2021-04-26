// import 'package:cartvorie/src/screens/checkoutOLD.dart';
import 'package:cartvorie/src/widgets/ChatMessageListItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:cartvorie/config/route_guard.dart';
import 'package:cartvorie/src/screens/pickup_and_delivery.dart';

import 'src/models/route_argument.dart';
import 'src/screens/address.dart';
import 'src/screens/products_in_category.dart';
import 'src/screens/store_screen.dart';
import 'src/screens/stores_screen.dart';
import 'src/screens/cart.dart';
import 'src/screens/categories.dart';
import 'src/screens/checkout.dart';
import 'src/screens/checkout_done.dart';
import 'src/screens/help.dart';
import 'src/screens/on_boarding.dart';
import 'src/screens/orders.dart';
import 'src/screens/product.dart';
import 'src/screens/signin.dart';
import 'src/screens/signup.dart';
import 'src/screens/tabs.dart';
import 'package:cartvorie/src/screens/goods_delivery.dart';
import 'package:cartvorie/src/screens/purchase_history.dart';
import 'package:cartvorie/src/screens/track_delivery.dart';
import 'package:cartvorie/src/screens/live_tracking.dart';
import 'package:cartvorie/src/screens/wallet_point.dart';
import 'package:cartvorie/src/screens/favorite.dart';
import 'package:cartvorie/src/screens/chat.dart';
import 'package:cartvorie/src/screens/settings.dart';
import 'package:cartvorie/src/screens/faq.dart';
import 'package:cartvorie/src/screens/contact_admin.dart';
import 'package:cartvorie/src/screens/user_to_user_chat.dart';
import 'package:cartvorie/src/screens/existing_card.dart';
import 'package:cartvorie/src/screens/checkout-pickup.dart';
import 'package:cartvorie/src/screens/checkout.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnBoardingWidget());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignInWidget());
      case '/Address':
        return MaterialPageRoute(builder: (_) => AddressWidget());
      case '/Categories':
        return MaterialPageRoute(builder: (_) => CategoriesWidget());
      case '/Category':
        return MaterialPageRoute(
            builder: (_) => ProductsByCategoryWidget(
                  category: args,
                ));
      case '/Orders':
        return MaterialPageRoute(builder: (_) => OrdersWidget());
      case '/Brands':
        return MaterialPageRoute(builder: (_) => StoresWidget());
      case '/Tabs':
        return MaterialPageRoute(
            builder: (_) => TabsWidget(
                  currentTab: args,
                ));
      case '/Brand':
        return MaterialPageRoute(builder: (_) => StoreWidget(store: args));
      case '/Product':
        return MaterialPageRoute(
            builder: (_) =>
                ProductWidget(routeArgument: args as RouteArgument));
      case '/GoodsDeliveryStatus':
        return MaterialPageRoute(builder: (_) => GoodsDeliveryStatus());
      case '/WalletPoint':
        return MaterialPageRoute(builder: (_) => WalletPoints());
      case '/Favorite':
        return MaterialPageRoute(builder: (_) => UserFavorite());
      case '/chat':
        return MaterialPageRoute(builder: (_) => UserToUserChat());
      case '/contactadmin':
        return MaterialPageRoute(builder: (_) => ContactAdmin());
      case '/PurchaseHistory':
        return MaterialPageRoute(builder: (_) => PurchaseHistory());
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget());
      case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget());
      // case '/Checkout2':
      //   return MaterialPageRoute(builder: (_) => CheckoutWidget2());
      // case '/Checkout-Pickup':
      //   return MaterialPageRoute(builder: (_) => CheckoutWidgetPickup());
      case '/ExistingCard':
        return MaterialPageRoute(builder: (_) => ExistingCardsPage());
      case '/CheckoutDone':
        return MaterialPageRoute(builder: (_) => CheckoutDoneWidget());
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/TrackDelivery':
        return MaterialPageRoute(builder: (_) => TrackDelivery());
      case '/LiveTracking':
        return MaterialPageRoute(builder: (_) => LiveTracking());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/faq':
        return MaterialPageRoute(builder: (_) => Faq());
      case '/chatdetails':
        return MaterialPageRoute(builder: (_) => ChatWidget());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

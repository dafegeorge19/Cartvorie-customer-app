import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:cartvorie/src/provider/auth_provider.dart';
import 'package:cartvorie/src/screens/account.dart';
import 'package:cartvorie/src/services/authentication_service.dart';
import 'package:cartvorie/src/widgets/NotSignedInWidget.dart';
import 'package:cartvorie/src/widgets/VerificationWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RouteGuard extends HookWidget {
  final Widget guardedWidget;
  const RouteGuard({Key key, @required this.guardedWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void checkVerified() async {
      final userPref = await UserPreferences().getUser();
      if (userPref.accessToken != null && userPref.status) {
        // print(userPref.accessToken);
        context.read(authenticationProvider).setVerified();
      }
    }

    return Consumer(builder: (context, watch, _) {
      final auth = watch(authenticationStateProvider);
      checkVerified();
      print(auth);
      if (auth == AuthStatus.Verified) {
        return guardedWidget;
      } else if (auth == AuthStatus.Verifying) {
        return VerificationWidget();
      } else {
        return NotSignedInWidget();
      }
    });
  }
}

class GuardedWidget extends HookWidget {
  final Widget guardedWidget;

  GuardedWidget({this.guardedWidget});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final auth = watch(authenticationStateProvider);
      print(auth);
      if (auth == AuthStatus.Verified || auth == AuthStatus.LoggedIn) {
        return guardedWidget;
      } else {
        return Container();
      }
    });
  }
}

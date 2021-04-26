import 'package:cartvorie/config/app_api_key.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/src/models/AddressModel.dart';
import 'package:cartvorie/src/models/user.dart';
import 'package:cartvorie/src/provider/user_address_provider.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/user_address_service.dart';
import 'package:cartvorie/src/widgets/ProfileSettingsDialog.dart';
import 'package:cartvorie/src/widgets/SearchBarWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/app_network_image.dart';
import 'package:cartvorie/src/widgets/error_widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:cartvorie/config/app_config.dart' as config;
import 'package:progress_dialog/progress_dialog.dart';

class AccountWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _user = useProvider(getUserProvider);
    final kInitialPosition = LatLng(56.1304, 106.3468);
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 80;
    return Container(
      child: _user.when(
          data: (_user) {
            return RefreshIndicator(
              onRefresh: () => context.refresh(getUserProvider).then((value) =>
                  context.refresh(getUserAddresses(_user.accessToken))),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      // margin: EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.15),
                              offset: Offset(0, 3),
                              blurRadius: 10)
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  _user.user.firstname.toUpperCase() +
                                      ' ' +
                                      _user.user.lastname.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  _user.user.email,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('img/logo.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                        child: Row(
                          children: <Widget>[
                            _cardInfo(categoryHeight, "Total Order(s)",
                                _user.user.orders),
                            _cardInfo(categoryHeight, "Your Point(s)",
                                _user.user.points),
                            _cardInfo(categoryHeight, "Wallet Balance",
                                _user.user.wallets),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).primaryColor,
                  //     borderRadius: BorderRadius.circular(6),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color:
                  //               Theme.of(context).hintColor.withOpacity(0.15),
                  //           offset: Offset(0, 3),
                  //           blurRadius: 10)
                  //     ],
                  //   ),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: FlatButton(
                  //           padding: EdgeInsets.symmetric(
                  //               vertical: 15, horizontal: 10),
                  //           onPressed: () {
                  //             Navigator.of(context)
                  //                 .pushNamed('/Tabs', arguments: 3);
                  //           },
                  //           child: Column(
                  //             children: <Widget>[
                  //               Icon(UiIcons.car_1),
                  //               Text(
                  //                 'pick up and delivery',
                  //                 style: Theme.of(context).textTheme.body1,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.15),
                            offset: Offset(0, 3),
                            blurRadius: 10)
                      ],
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            UiIcons.user_1,
                            size: 22,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(
                            'Profile Settings',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: ButtonTheme(
                            padding: EdgeInsets.all(0),
                            minWidth: 50.0,
                            height: 25.0,
                            child: ProfileSettingsDialog(
                              user: _user,
                              onChanged: () {
                                print('changed');
                                Flushbar(
                                  message: 'success',
                                  duration: Duration(seconds: 3),
                                );
                              },
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          dense: true,
                          title: Text(
                            'Full name',
                            style: Theme.of(context).textTheme.body1,
                          ),
                          trailing: Text(
                            '${_user.user.firstname} ${_user.user.lastname}'
                                .toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          dense: true,
                          title: Text(
                            'Email',
                            style: Theme.of(context).textTheme.body1,
                          ),
                          trailing: Text(
                            _user.user.email,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          dense: true,
                          title: Text(
                            'Phone',
                            style: Theme.of(context).textTheme.body1,
                          ),
                          trailing: Text(
                            _user.user.phoneNumber == null
                                ? 'Add Number'
                                : _user.user.phoneNumber,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          dense: true,
                          title: Text(
                            'Account Type',
                            style: Theme.of(context).textTheme.body1,
                          ),
                          trailing: Text(
                            _user.user.accountType,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.15),
                            offset: Offset(0, 3),
                            blurRadius: 10)
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            UiIcons.placeholder,
                            size: 22,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(
                            'Address Settings',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: ButtonTheme(
                            padding: EdgeInsets.all(0),
                            minWidth: 50.0,
                            height: 25.0,
                            child: FlatButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlacePicker(
                                      onPlacePicked: (result) async {
                                        await context
                                            .read(userAddressProvider)
                                            .addAddress(result.formattedAddress,
                                                _user.accessToken);
                                        ProgressDialog dialog =
                                            new ProgressDialog(context);
                                        dialog.style(message: 'Please wait...');
                                        await dialog.show();
                                        await context.refresh(getUserAddresses(
                                            _user.accessToken));
                                        await dialog.hide();
                                        Navigator.of(context).pop();
                                      },
                                      apiKey: AppApiKeys.googleMapKey,
                                      useCurrentLocation: true,
                                      initialPosition: kInitialPosition),
                                ),
                              ),
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                            child: GetAddress(_user.accessToken)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => appLoader,
          error: (e, s) => Text('${e.toString()}')),
    );
  }
}

class _cardInfo extends StatelessWidget {
  const _cardInfo(this.categoryHeight, this._title, this._value);

  final double categoryHeight;
  final String _title;
  final dynamic _value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 20),
      height: categoryHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.15),
              offset: Offset(0, 3),
              blurRadius: 10)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _value == null ? "0" : _value.toString(),
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class GetAddress extends HookWidget {
  final String userToken;

  GetAddress(this.userToken);

  @override
  Widget build(BuildContext context) {
    final _userAddresses = useProvider(getUserAddresses(userToken));

    void deleteAddress(int id, String userToken) async {
      ProgressDialog dialog = new ProgressDialog(context);
      dialog.style(message: 'Please wait...');
      await dialog.show();
      final response = await context
          .read(userAddressProvider)
          .deleteUserAddress(id, userToken);
      await dialog.hide();

      Scaffold.of(context)
          .showSnackBar(SnackBar(
            content: Text(response),
            duration: new Duration(milliseconds: 1200),
          ))
          .closed
          .then((_) {
        context.refresh(getUserAddresses(userToken));
      });
    }

    return Container(
      child: _userAddresses.when(
          data: (_userAddresses) {
            final addressList = _userAddresses;
            return Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'You have a total of ${addressList.length ?? 0} address',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 200,
                    child: addressList.length == 0
                        ? Center(
                            child: Text('you have added no address Tap to add'),
                          )
                        : ListView.builder(
                            itemCount: addressList.length,
                            itemBuilder: (context, index) => ListTile(
                              title:
                                  Text('${addressList[index].streetAddress}'),
                              trailing: GestureDetector(
                                  onTap: () {
                                    deleteAddress(
                                        addressList[index].id, userToken);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
          loading: () => appLoader,
          error: (e, s) => AppErrorWidget(
              errorMessage: e.toString(),
              provider: getUserAddresses(userToken))),
    );
  }
}

class AddAddress extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller(this._title, this._value, this._linker);
  final String _title;
  final int _value;
  final String _linker;

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 80;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Container(
                width: 120,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _value.toString(),
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _title,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

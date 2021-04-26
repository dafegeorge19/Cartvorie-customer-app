import 'dart:convert';

import 'package:cartvorie/config/app_api_key.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/validators.dart';
import 'package:cartvorie/src/models/AddressModel.dart';
import 'package:cartvorie/src/provider/cart_provider.dart';
import 'package:cartvorie/src/provider/user_address_provider.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/payment_service.dart';
import 'package:cartvorie/src/services/user_address_service.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CheckoutWidget extends HookWidget {
  final _checkoutFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, dynamic> formData = {
    "paystack_payment_ref": null,
    "payment_type": null,
    "amount": null,
    "tax": null,
    "pay_total": null,
    "order_type": null,
    "total_products_amount": null,
    "delivery_fee": null,
    "total_products_weight": null,
    "delivery_shipping_info": null,
    "with_point": null,
    "cart": null
  };

  @override
  Widget build(BuildContext context) {
    final user = useProvider(getUserProvider);
    final setting = useProvider(getSettingsProvider);
    final kInitialPosition = LatLng(56.1304, 106.3468);

    final cartList = useProvider(cartProvider);
    final cartSubTotal = useProvider(cartSubTotalProvider);
    final cartTax = useProvider(taxProvider);
    final cartTotal = useProvider(cartTotalProvider);
    final deliveryServiceFee = useProvider(deliveryServiceFeeProvider);

    //text controllers
    TextEditingController addressController = TextEditingController();
    TextEditingController deliveryController = TextEditingController();
    TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
    //end controllers
    void getAddressFromMap(TextEditingController textEditingController) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacePicker(
              apiKey: AppApiKeys.googleMapKey,
              onPlacePicked: (result) {
                print('gotten address ' + result.formattedAddress);
                textEditingController.text = result.formattedAddress;
                Navigator.of(context).pop();
              },
              initialPosition: kInitialPosition,
              useCurrentLocation: true,
            ),
          ));
    }

    void getExistingAddress(
        userToken, TextEditingController textEditingController) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExistingAddress(
                    onSelectedAddress: (result) {
                      print('gotten address ' + result.streetAddress);
                      textEditingController.text = result.streetAddress;
                      Navigator.of(context).pop();
                    },
                    userToken: userToken,
                  )));
    }

    onItemPress(BuildContext context, int index, String accessToken,
        double cartSubTotal) async {
      switch (index) {
        case 0:
          ProgressDialog dialog = new ProgressDialog(context);
          dialog.style(message: 'Please wait...');
          await dialog.show();
          var response = await StripeService.payWithNewCard(
              amount: '150', currency: 'USD');
          if (response.success == true) {
            dialog.hide();
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(response.message),
                duration: new Duration(milliseconds: 3200),
              ),
            );
          }
          break;
        case 1:
          Navigator.pushNamed(context, '/ExistingCard');
          break;
        case 2:
          ProgressDialog dialog = new ProgressDialog(context);
          dialog.style(message: 'Please wait...');
          await dialog.show();
          // if (_checkoutFormKey.currentState.validate()) {
          _checkoutFormKey.currentState.save();
          // print(formData);
          final result = await context
              .read(userAddressProvider)
              .addNewOrder(formData, cartSubTotal, cartList, accessToken);
          print(result.toString());
          // if (result == null) {
          //   _scaffoldKey.currentState.showSnackBar(
          //     SnackBar(
          //       content: Text(result.toString()),
          //       duration: new Duration(milliseconds: 3200),
          //     ),
          //   );
          // }
          // }
          break;
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon:
              new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Checkout / Payment',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
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
      body: user.when(
          data: (user) {
            return Form(
                key: _checkoutFormKey,
                child: setting.when(
                    data: (setting) {
                      return Theme(
                        data: ThemeData(
                            colorScheme: ColorScheme.light(
                          primary: Theme.of(context).accentColor,
                          secondary: Theme.of(context).accentColor,
                        )),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text('SubTotal'),
                                      trailing: Text(
                                        '\$' + cartSubTotal.toStringAsFixed(3),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Tax'),
                                      subtitle: Text('(13% of the order)'),
                                      trailing: Text(
                                        '\$' +
                                            (cartSubTotal * 0.13)
                                                .toStringAsFixed(3),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Delivery fee'),
                                      trailing: Text(
                                        '\$' + setting.cartvorie.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Service fee'),
                                      subtitle: Text(
                                          '( Service fee helps support the maintainace of the app,web and support staff. ' +
                                              setting.serviceBaseFee +
                                              '% of total order )',
                                          style: TextStyle(fontSize: 12)),
                                      trailing: Text(
                                        '\$' +
                                            setting.serviceBaseFee.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(thickness: 1),
                              Container(
                                child: ListTile(
                                  title: Text(
                                    'Total',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  trailing: Text(
                                    '\$' +
                                        (cartSubTotal +
                                                (cartSubTotal * 0.13) +
                                                (cartSubTotal *
                                                    double.parse(setting
                                                        .serviceBaseFee)))
                                            .toStringAsFixed(3),
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "- DELIVERY DETAILS - ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    TextFormField(
                                      validator: validateRequired,
                                      controller: addressController,
                                      onChanged: (newVal) {},
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor),
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          context, "First name"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: validateRequired,
                                      controller: addressController,
                                      onChanged: (newVal) {},
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor),
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          context, "Last name"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      validator: validateRequired,
                                      controller: addressController,
                                      onChanged: (newVal) {},
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor),
                                      keyboardType: TextInputType.number,
                                      decoration: buildInputDecoration(
                                          context, "Phone number"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () => getExistingAddress(
                                          user.accessToken, addressController),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          // gradient: LinearGradient(
                                          //   colors: <Color>[
                                          //     Color(0xFFCC00FF),
                                          //     Color(0xFF7401E0)
                                          //   ],
                                          // ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(0.2),
                                                offset: Offset(0, 4),
                                                blurRadius: 9)
                                          ],
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            'Pick Existing Address',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text('OR',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    ListTile(
                                      title: TextFormField(
                                        validator: validateRequired,
                                        controller: addressController,
                                        onTap: () => getAddressFromMap(
                                            addressController),
                                        onChanged: (newVal) {
                                          formData['order_note'] = newVal;
                                        },
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                        keyboardType: TextInputType.text,
                                        decoration: buildInputDecoration(
                                            context, "Enter new address"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      validator: validateRequired,
                                      controller: deliveryController,
                                      maxLines: 5,
                                      onChanged: (newVal) {
                                        formData['delivery_shipping_info'] =
                                            newVal;
                                      },
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor),
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          context, "Leave a short note"),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    loading: () => appLoader,
                    error: (e, s) => AppErrorWidget(
                        errorMessage: e, provider: getSettingsProvider)));
          },
          loading: () => appLoader,
          error: (e, s) =>
              AppErrorWidget(errorMessage: e, provider: getUserProvider)),
      bottomNavigationBar: Container(
        // height: 100,
        child: user.when(
            data: (user) {
              return Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        onItemPress(context, 0, user.accessToken, cartSubTotal);
                      },
                      child: Text(
                        "Pay via new card",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 15),
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width / 3,
                  //   color: Colors.red,
                  //   child: InkWell(
                  //     onTap: () {
                  //       onItemPress(context, 1, user.accessToken, cartSubTotal);
                  //     },
                  //     child: Text(
                  //       "Pay via existing card",
                  //       style: TextStyle(color: Colors.white, fontSize: 14),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.black,
                    child: InkWell(
                      onTap: () {
                        onItemPress(context, 2, user.accessToken, cartSubTotal);
                      },
                      child: Text(
                        "Pay on Delivery",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => appLoader,
            error: (e, s) =>
                AppErrorWidget(errorMessage: e, provider: getUserProvider)),
      ),
    );
  }

  InputDecoration buildInputDecoration(BuildContext context, String title) {
    return new InputDecoration(
      hintText: title,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).accentColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor)),
    );
  }
}

class ExistingAddress extends HookWidget {
  final String userToken;
  final ValueChanged<AddressModel> onSelectedAddress;

  ExistingAddress({@required this.userToken, this.onSelectedAddress});

  @override
  Widget build(BuildContext context) {
    final userAddress = useProvider(getUserAddresses(userToken));
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: userAddress.when(
              data: (userAddress) {
                return ListView.builder(
                    itemCount: userAddress.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () => onSelectedAddress(userAddress[index]),
                          child: ListTile(
                            title: Text(userAddress[index].streetAddress),
                          ),
                        ));
              },
              loading: () => appLoader,
              error: (e, s) => AppErrorWidget(
                  errorMessage: e, provider: getUserAddresses(userToken))),
        ),
      ),
    );
  }
}

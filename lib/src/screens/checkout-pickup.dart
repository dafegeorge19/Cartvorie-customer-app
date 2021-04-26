import 'dart:io';

import 'package:cartvorie/config/base_api.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/models/AddressModel.dart';
import 'package:cartvorie/src/models/route_argument.dart';
import 'package:cartvorie/src/models/settings_model.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:cartvorie/src/provider/user_address_provider.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/payment_service.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class CheckoutWidgetPickup extends HookWidget {
  // final _checkoutFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CheckoutWidgetPickup(
      this.pickUpAddressController,
      this.itemNameController,
      this.itemDetailController,
      this.itemSizeController,
      this.senderNumberController,
      this.receiverNumberController,
      this.receiverNameController,
      this.receiverAddressController,
      this.deliveryInstructionsController,
      this.setTypeValue,
      this.imgValue);

  final TextEditingController pickUpAddressController;
  final TextEditingController itemNameController;
  final TextEditingController itemDetailController;
  final TextEditingController itemSizeController;
  final TextEditingController senderNumberController;
  final TextEditingController receiverNumberController;
  final TextEditingController receiverNameController;
  final TextEditingController receiverAddressController;
  final TextEditingController deliveryInstructionsController;
  final String setTypeValue;
  final File imgValue;

//   Map<String, dynamic> formData;
// // final List<Todo> todos;

//   CheckoutWidgetPickup({Key key, @required this.formData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(getUserProvider);
    final setting = useProvider(getSettingsProvider);
    // final _killometer = useFuture(
    // getMain(formData['p_address'], formData['d_address'], formData));

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
            ),
          ),
        ],
      ),
      body: user.when(
          data: (user) {
            return Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.light(
                primary: Theme.of(context).accentColor,
                secondary: Theme.of(context).accentColor,
              )),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: setting.when(
                    data: (setting) {
                      return InnerWidget(setting, user, pickUpAddressController,
                          receiverAddressController);
                    },
                    loading: () => appLoader,
                    error: (e, s) => AppErrorWidget(
                        errorMessage: e, provider: getSettingsProvider)),
              ),
            );
          },
          loading: () => appLoader,
          error: (e, s) =>
              AppErrorWidget(errorMessage: e, provider: getUserProvider)),
      bottomNavigationBar: Container(
        // height: 100,
        child: user.when(
            data: (user) {
              return setting.when(
                  data: (setting) {
                    return ActionButton(
                        setting,
                        user,
                        pickUpAddressController,
                        itemNameController,
                        itemDetailController,
                        itemSizeController,
                        senderNumberController,
                        receiverNumberController,
                        receiverNameController,
                        receiverAddressController,
                        deliveryInstructionsController,
                        setTypeValue,
                        imgValue);
                  },
                  loading: () => appLoader,
                  error: (e, s) => AppErrorWidget(
                      errorMessage: e, provider: getUserProvider));
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

class ActionButton extends StatefulWidget {
  const ActionButton(
      this.setting,
      this.user,
      this.pickUpAddressController,
      this.itemNameController,
      this.itemDetailController,
      this.itemSizeController,
      this.senderNumberController,
      this.receiverNumberController,
      this.receiverNameController,
      this.receiverAddressController,
      this.deliveryInstructionsController,
      this.setTypeValue,
      this.imgValue);

  final SettingsModel setting;
  final UserModel user;
  final TextEditingController pickUpAddressController;
  final TextEditingController itemNameController;
  final TextEditingController itemDetailController;
  final TextEditingController itemSizeController;
  final TextEditingController senderNumberController;
  final TextEditingController receiverNumberController;
  final TextEditingController receiverNameController;
  final TextEditingController receiverAddressController;
  final TextEditingController deliveryInstructionsController;
  final String setTypeValue;
  final File imgValue;

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  int total;
  String distance;

  Future<dynamic> getMain(address1, address2) async {
    GeoCode geoCode = GeoCode();

    var coordinates1 = await geoCode.forwardGeocoding(address: address1);
    var coordinates2 = await geoCode.forwardGeocoding(address: address2);

    double bearing = Geolocator.distanceBetween(coordinates1.latitude,
        coordinates1.longitude, coordinates2.longitude, coordinates2.longitude);

    final dbtw = bearing / 1000;
    double myInt = double.parse(widget.setting.pickupDelivery);
    double myTime = double.parse(widget.setting.time);
    double myServiceBaseFee = double.parse(widget.setting.serviceBaseFee);
    double myKilometer = double.parse(widget.setting.kilometer);
    int tax = (dbtw * 0.13).toInt();

    setState(() {
      total = (dbtw).toInt() + tax + myServiceBaseFee.toInt();
      distance = dbtw.toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();
    print(distance.toString());
    getMain(widget.pickUpAddressController.text,
        widget.receiverAddressController.text);
  }

  onItemPress(BuildContext context, int index, String accessToken) async {
    switch (index) {
      case 0:
        ProgressDialog dialog = new ProgressDialog(context);
        dialog.style(message: 'Please wait...');
        await dialog.show();
        var response = await StripeService.payWithNewCard(
            amount: total.toString(), currency: 'USD');
        if (response.success == true) {
          Map<String, String> headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '$accessToken'
          };

          var request =
              http.MultipartRequest("POST", Uri.parse(BaseApi.pickup));

          request.fields["pickup_id"] = widget.itemNameController.text;
          request.fields["p_address"] = widget.pickUpAddressController.text;
          request.fields["p_city"] = "empty";
          request.fields["p_province"] = "empty";
          request.fields["p_postal_code"] = "empty";
          request.fields["p_country"] = "empty";
          request.fields["item_type"] = "empty";
          request.fields["item_size"] = widget.itemSizeController.text;
          request.fields["size_type"] = "kg";
          request.fields["p_desc"] = widget.itemDetailController.text;
          request.fields["pay_request"] = "no";
          request.fields["receiver_name"] = widget.receiverNameController.text;
          request.fields["receiver_phone"] =
              widget.receiverNumberController.text;
          request.fields["sender_name"] =
              widget.user.user.lastname + ' ' + widget.user.user.firstname;
          request.fields["sender_phone"] = widget.senderNumberController.text;
          request.fields["d_address"] = widget.receiverAddressController.text;
          request.fields["d_city"] = "empty";
          request.fields["d_province"] = "empty";
          request.fields["d_postal_code"] = "empty";
          request.fields["d_country"] = "empty";
          request.fields["d_instruction"] =
              widget.deliveryInstructionsController.text;
          request.fields["amount"] = total.toString();
          request.fields["amount_confirm"] = total.toString();

          var pic =
              await http.MultipartFile.fromPath("image", widget.imgValue.path);
          request.files.add(pic);
          request.headers.addAll(headers);
          var response = await request.send();
          print(response.statusCode);
          if (response.statusCode == 201) {
            dialog.hide();
            Fluttertoast.showToast(
              msg: "Your package has been submitted and ready for pickup.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              // timeInSecForIos: 1
              backgroundColor: Colors.black,
              webPosition: "bottom",
            );
            Navigator.pushNamed(context, '/Tabs', arguments: 2);
          } else {
            dialog.hide();
            Fluttertoast.showToast(
              msg: "Error: ${response.reasonPhrase}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              // timeInSecForIos: 1
              backgroundColor: Colors.black,
              webPosition: "bottom",
            );
          }
        }
        break;
      case 1:
        Navigator.pushNamed(context, '/ExistingCard');
        break;
      case 2:
        ProgressDialog dialog = new ProgressDialog(context);
        dialog.style(message: 'Please wait...');
        await dialog.show();

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$accessToken'
        };

        var request = http.MultipartRequest("POST", Uri.parse(BaseApi.pickup));

        request.fields["pickup_id"] = widget.itemNameController.text;
        request.fields["p_address"] = widget.pickUpAddressController.text;
        request.fields["p_city"] = "empty";
        request.fields["p_province"] = "empty";
        request.fields["p_postal_code"] = "empty";
        request.fields["p_country"] = "empty";
        request.fields["item_type"] = "empty";
        request.fields["item_size"] = widget.itemSizeController.text;
        request.fields["size_type"] = "kg";
        request.fields["p_desc"] = widget.itemDetailController.text;
        request.fields["pay_request"] = "no";
        // request.fields["image"] = "['image1','image2']";
        request.fields["receiver_name"] = widget.receiverNameController.text;
        request.fields["receiver_phone"] = widget.receiverNumberController.text;
        request.fields["sender_name"] =
            widget.user.user.lastname + ' ' + widget.user.user.firstname;
        request.fields["sender_phone"] = widget.senderNumberController.text;
        request.fields["d_address"] = widget.receiverAddressController.text;
        request.fields["d_city"] = "empty";
        request.fields["d_province"] = "empty";
        request.fields["d_postal_code"] = "empty";
        request.fields["d_country"] = "empty";
        request.fields["d_instruction"] =
            widget.deliveryInstructionsController.text;
        request.fields["amount"] = total.toString();
        request.fields["amount_confirm"] = total.toString();

        var pic =
            await http.MultipartFile.fromPath("image", widget.imgValue.path);
        request.files.add(pic);
        request.headers.addAll(headers);
        var response = await request.send();
        print(response.statusCode);
        if (response.statusCode == 201) {
          dialog.hide();
          Fluttertoast.showToast(
            msg: "Your package has been submitted and ready for pickup.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            // timeInSecForIos: 1
            backgroundColor: Colors.black,
            webPosition: "bottom",
          );
          Navigator.pushNamed(context, '/Tabs', arguments: 2);
        } else {
          dialog.hide();
          Fluttertoast.showToast(
            msg: "Error: ${response.reasonPhrase}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            // timeInSecForIos: 1
            backgroundColor: Colors.black,
            webPosition: "bottom",
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onItemPress(context, 0, widget.user.accessToken);
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
        //       onItemPress(context, 1, widget.user.accessToken);
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
              onItemPress(context, 2, widget.user.accessToken);
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
  }
}

class InnerWidget extends StatefulWidget {
  InnerWidget(this.setting, this.user, this.pickUpAddressController,
      this.receiverAddressController);

  final SettingsModel setting;
  final UserModel user;
  final TextEditingController pickUpAddressController;
  final TextEditingController receiverAddressController;

  @override
  _InnerWidgetState createState() => _InnerWidgetState();
}

class _InnerWidgetState extends State<InnerWidget> {
  String distance;
  int total;

  Future<dynamic> getMain(address1, address2) async {
    GeoCode geoCode = GeoCode();

    var coordinates1 = await geoCode.forwardGeocoding(address: address1);
    var coordinates2 = await geoCode.forwardGeocoding(address: address2);

    double bearing = Geolocator.distanceBetween(coordinates1.latitude,
        coordinates1.longitude, coordinates2.longitude, coordinates2.longitude);

    final dbtw = bearing / 1000;
    // print(dbtw);

    // formData['total_amount'] = dbtw.toStringAsFixed(2);

    // return dbtw.toString();
    double myInt = double.parse(widget.setting.pickupDelivery);
    double myTime = double.parse(widget.setting.time);
    double myServiceBaseFee = double.parse(widget.setting.serviceBaseFee);
    double myKilometer = double.parse(widget.setting.kilometer);
    // assert(myInt is int);
    int tax = (dbtw * 0.13).toInt();
    // int fee = dbtw  myInt;
    // print(tax);
    // print(fee);
    // print(total);

    setState(() {
      // total = dbtw.toString();
      total = (dbtw).toInt() + tax + myServiceBaseFee.toInt();
      distance = dbtw.toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();
    print(distance.toString());
    getMain(widget.pickUpAddressController.text,
        widget.receiverAddressController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              // Text(_killometer.data.toString()),
              ListTile(
                title: Text("Distance"),
                // trailing: Text(distance.toString()),
                trailing: distance == null
                    ? CircularProgressIndicator()
                    : Text(
                        distance.toString() + "Km",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
              ),
              ListTile(
                title: Text('Tax'),
                subtitle: Text('(13% of the order)'),
                trailing: Text('0.13',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
              ListTile(
                title: Text('Delivery fee'),
                trailing: Text("\$" + widget.setting.pickupDelivery.toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
              ListTile(
                title: Text('Service fee'),
                subtitle: Text(
                    '( Service fee helps support the maintainace of the app,web and support staff. \$${widget.setting.serviceBaseFee} of total order )',
                    style: TextStyle(fontSize: 12)),
                trailing: Text('\$' + widget.setting.serviceBaseFee.toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        Divider(thickness: 1),
        Container(
          child: ListTile(
            title: Text(
              'Total',
              style: Theme.of(context).textTheme.headline4,
            ),
            trailing: total == null
                ? CircularProgressIndicator()
                : Text(total.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headline4),
            // trailing: Text(
            //   total,
            //   // formData['total_amount'].toString(),
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ],
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

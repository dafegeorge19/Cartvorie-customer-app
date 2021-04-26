import 'package:cartvorie/config/app_api_key.dart';
import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/config/validators.dart';
import 'package:cartvorie/src/models/AddressModel.dart';
import 'package:cartvorie/src/models/card_model.dart';
import 'package:cartvorie/src/provider/cart_provider.dart';
import 'package:cartvorie/src/provider/user_address_provider.dart';
import 'package:cartvorie/src/provider/user_provider.dart';
import 'package:cartvorie/src/services/payment_service.dart';
import 'package:cartvorie/src/widgets/CreditCardsWidget.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:cartvorie/src/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CheckoutWidget extends HookWidget {
  final _checkoutFormKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = useProvider(getUserProvider);
    final kInitialPosition = LatLng(56.1304, 106.3468);

    final cartList = useProvider(cartProvider);
    final cartSubTotal = useProvider(cartSubTotalProvider);
    final cartTax = useProvider(taxProvider);
    final cartTotal = useProvider(cartTotalProvider);
    final deliveryServiceFee = useProvider(deliveryServiceFeeProvider);

    //text controllers
    TextEditingController addressController = TextEditingController();
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

    List<Step> steps = [];

    final activeStep = useState(0);

    final cardNumber = useState('');
    final expiryDate = useState('');
    final cardHolderName = useState('');
    final cvvCode = useState('');
    final isCvvFocused = useState(false);

    void onCreditCardModelChange(CreditCardModel creditCardModel) {
      // print(creditCardModel.expiryDate);
      cardNumber.value = creditCardModel.cardNumber;
      expiryDate.value = creditCardModel.expiryDate;
      cardHolderName.value = creditCardModel.cardHolderName;
      cvvCode.value = creditCardModel.cvvCode;
      isCvvFocused.value = creditCardModel.isCvvFocused;
    }

    StepState setStepState(int index) {
      return activeStep.value == index
          ? StepState.editing
          : activeStep.value > index
              ? StepState.complete
              : StepState.indexed;
    }

    void nextStep() {
      if (activeStep.value < steps.length - 1) {
        activeStep.value++;
        print(activeStep.value);
        print(steps.length);
      } else {
        _checkoutFormKey.currentState.save();

        // Navigator.pushNamed(context, '/Checkout');
      }
    }

    void cancelStep() {
      if (activeStep.value > 0) {
        activeStep.value--;
      }
    }

    void goToStep(int step) {
      activeStep.value = step;
    }

    //
    payViaExistingCard(BuildContext context, CardModel card) async {
      ProgressDialog dialog = new ProgressDialog(context);
      dialog.style(message: 'Please wait...');
      await dialog.show();

      var expiryArr = card.expiryDate.split('/');
      CreditCard stripeCard = CreditCard(
        number: card.cardNumber,
        expMonth: int.parse(expiryArr[0]),
        expYear: int.parse(expiryArr[1]),
      );
      var response = await StripeService.payViaExistingCard(
          amount: card.amount, currency: 'USD', card: stripeCard);
      await dialog.hide();
      print(response.toString());
      _scaffoldKey.currentState
          .showSnackBar(
            SnackBar(
              content: Text(response.message),
              duration: new Duration(milliseconds: 100000),
            ),
          )
          .closed
          .then((value) {
        // Navigator.pop(context);
      });
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
          'Checkout',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: user.when(
          data: (user) {
            return Form(
              key: _checkoutFormKey,
              child: Theme(
                data: ThemeData(
                    colorScheme: ColorScheme.light(
                  primary: Theme.of(context).accentColor,
                  secondary: Theme.of(context).accentColor,
                )),
                child: Stepper(
                  type: StepperType.vertical,
                  currentStep: activeStep.value,
                  onStepContinue: nextStep,
                  onStepCancel: cancelStep,
                  onStepTapped: goToStep,
                  steps: steps = [
                    Step(
                        state: setStepState(0),
                        title: Text('Your Order'),
                        content: Column(
                          children: [
                            Container(
                              child: ListTile(
                                title: Text(
                                  'Product',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              height: cartList.length == 1
                                  ? 50.0
                                  : cartList.length * 50.0,
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text('${cartList[index].name}'),
                                      subtitle:
                                          Text('${cartList[index].quantity}'),
                                      trailing:
                                          Text('${cartList[index].price}'),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: cartList.length),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text('SubTotal'),
                                    trailing: Text(
                                      '\$' + cartSubTotal.toStringAsFixed(3),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Tax'),
                                    subtitle: Text('(13% of the order)'),
                                    trailing: Text(
                                      '\$' +
                                          (cartSubTotal * 0.13)
                                              .toStringAsFixed(3),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Delivery fee'),
                                    trailing: Text(
                                      '2',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Service fee'),
                                    subtitle: Text(
                                        '( Service fee helps support the maintainace of the app,web and support staff. 8% of total order )'),
                                    trailing: Text(
                                      '\$' +
                                          deliveryServiceFee.toStringAsFixed(3),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Container(
                              child: ListTile(
                                title: Text(
                                  'Total',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                trailing: Text(
                                  '\$' +
                                      (cartSubTotal +
                                              (cartSubTotal * 0.13) +
                                              (cartSubTotal * 0.08))
                                          .toStringAsFixed(3),
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            )
                          ],
                        )),
                    Step(
                        state: setStepState(1),
                        title: Text('Address'),
                        content: Column(
                          children: [
                            GestureDetector(
                              onTap: () => getExistingAddress(
                                  user.accessToken, addressController),
                              child: ListTile(
                                title: Text('Pick Existing Address'),
                              ),
                            ),
                            Text('OR'),
                            ListTile(
                              title: TextFormField(
                                validator: validateRequired,
                                controller: addressController,
                                onTap: () =>
                                    getAddressFromMap(addressController),
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  hintText: 'Enter a new  Address',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .merge(
                                        TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.2))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).accentColor)),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Step(
                      state: setStepState(0),
                      title: Text('Payment method'),
                      content: Column(
                        children: [
                          CreditCardWidget(
                            cardNumber: cardNumber.value,
                            expiryDate: expiryDate.value,
                            cardHolderName: cardHolderName.value,
                            cvvCode: cvvCode.value,
                            showBackView: isCvvFocused.value,
                            cardBgColor: Theme.of(context).accentColor,
                            animationDuration: Duration(milliseconds: 1000),
                          ),
                          CreditCardForm(
                              onCreditCardModelChange: onCreditCardModelChange),
                          RaisedButton(
                              child: Text('make payment'),
                              onPressed: () => payViaExistingCard(
                                  context,
                                  CardModel(
                                      amount: (cartSubTotal +
                                              cartSubTotal * .08 +
                                              cartSubTotal * cartSubTotal * 13)
                                          .toString(),
                                      currency: 'USD',
                                      cardNumber: cardNumber.value,
                                      expiryDate: expiryDate.value))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => appLoader,
          error: (e, s) =>
              AppErrorWidget(errorMessage: e, provider: getUserProvider)),
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

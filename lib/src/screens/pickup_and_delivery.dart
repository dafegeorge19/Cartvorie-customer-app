import 'dart:io';
import 'package:cartvorie/config/app_api_key.dart';
import 'package:cartvorie/config/validators.dart';
import 'package:cartvorie/src/screens/checkout-pickup.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cartvorie/src/provider/auth_provider.dart';

import 'package:cartvorie/src/services/authentication_service.dart';
import 'package:cartvorie/src/widgets/NotSignedInWidget.dart';

class PickupAndDeliveryWidget extends HookWidget {
  final _pickUpForm = GlobalKey<FormState>();

  // final Map<String, dynamic> _formData = {
  //   "pickup_id": null,
  //   "p_address": null,
  //   "p_city": null,
  //   "p_province": null,
  //   "p_postal_code": "+23401",
  //   "p_country": null,
  //   "item_type": null,
  //   "item_size": null,
  //   "size_type": "Kg",
  //   "p_desc": null,
  //   "pay_request": null,
  //   "image": null,
  //   "receiver_name": null,
  //   "receiver_phone": null,
  //   "sender_name": null,
  //   "sender_phone": null,
  //   "d_address": null,
  //   "d_city": null,
  //   "d_province": null,
  //   "d_postal_code": null,
  //   "d_country": null,
  //   "d_instruction": null,
  //   "amount": null,
  //   "amount_confirm": null
  // };

  final List<String> sizeTypeList = ['A', 'B', 'C', 'D'];
  @override
  Widget build(BuildContext context) {
    final kInitialPosition = LatLng(56.1304, 106.3468);
    final intro1 = "Do you have a parcel or item you want to send to someone?";
    final intro2 = "Signin/Register to request for pickup & delivery";
    final _vericationProcess = useProvider(authenticationStateProvider);

    final activeStep = useState(0);
    // var sizeType = useState(List<String>());
    //text controllers
    final pickUpAddressController = useTextEditingController();
    final itemNameController = useTextEditingController();
    final itemDetailController = useTextEditingController();
    final itemSizeController = useTextEditingController();
    final senderNumberController = useTextEditingController();
    final receiverNumberController = useTextEditingController();
    final receiverNameController = useTextEditingController();
    final receiverAddressController = useTextEditingController();
    final deliveryInstructionsController = useTextEditingController();
    String setTypeValue = "Kg";
    // end

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

    final _image = useState(File(''));
    final picker = ImagePicker();
    String radioItem = '';

    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      if (pickedFile.path.isNotEmpty || pickedFile.path == '') {
        _image.value = File(pickedFile.path);
        // _formData['image'] = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    }

    StepState setStepState(int index) {
      return activeStep.value == index
          ? StepState.editing
          : activeStep.value > index
              ? StepState.complete
              : StepState.indexed;
    }

    List<Step> steps = [
      Step(
          title: Text('Pickup Information'),
          state: setStepState(0),
          isActive: true,
          content: Column(
            children: [
              //item name
              TextFormField(
                controller: itemNameController,
                onSaved: (String newValue) {
                  // _formData['pickup_id'] = newValue;
                },
                enableSuggestions: true,
                validator: validateRequired,
                style: TextStyle(color: Theme.of(context).accentColor),
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Item Name / Item ID',
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                        TextStyle(color: Theme.of(context).accentColor),
                      ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                ),
              ),
              // item details
              TextFormField(
                controller: itemDetailController,
                onSaved: (newValue) {
                  // _formData['p_desc'] = newValue;
                },
                enableSuggestions: true,
                validator: validateRequired,
                style: TextStyle(color: Theme.of(context).accentColor),
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 10,
                decoration: new InputDecoration(
                  hintText: 'please provide Item Details',
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                        TextStyle(color: Theme.of(context).accentColor),
                      ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                ),
              ),
              // item size
              TextFormField(
                controller: itemSizeController,
                onSaved: (newValue) {
                  // _formData['item_size'] = newValue;
                },
                validator: validateRequired,
                style: TextStyle(color: Theme.of(context).accentColor),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: new InputDecoration(
                  hintText: 'Size',
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                        TextStyle(color: Theme.of(context).accentColor),
                      ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                ),
              ),
              // SizeType(formData: _formData),
              // DropdownButton<String>(
              //   hint: Text(
              //     'Please choose size type',
              //     style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              //   ),
              //   isExpanded: true,
              //   // value: "Choose size type",
              //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
              //     return new DropdownMenuItem<String>(
              //       value: value,
              //       child: new Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (newVal) {
              //     setTypeValue = newVal;
              //     _formData['size_type'] = newVal;
              //   },
              // ),
              //address
              TextFormField(
                validator: validateRequired,
                controller: pickUpAddressController,
                onTap: () => getAddressFromMap(pickUpAddressController),
                style: TextStyle(color: Theme.of(context).accentColor),
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Pick Up Address',
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                        TextStyle(color: Theme.of(context).accentColor),
                      ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                ),
                onChanged: (newVal) {
                  // _formData['p_address'] = newVal;
                },
                onSaved: (newVal) {
                  // _formData['p_address'] = newVal;
                },
              ),
              //phone number
              TextFormField(
                controller: senderNumberController,
                style: TextStyle(color: Theme.of(context).accentColor),
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$")),
                ],
                decoration: new InputDecoration(
                  hintText: 'add your Phone Number',
                  hintStyle: Theme.of(context).textTheme.body1.merge(
                        TextStyle(color: Theme.of(context).accentColor),
                      ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                ),
              ),
            ],
          )),
      Step(
        state: setStepState(1),
        title: Text('Item Image'),
        isActive: false,
        content: Column(
          children: [
            _image.value.path == ''
                ? Text('No image selected.')
                : Image.file(_image.value),
            FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
          ],
        ),
      ),
      Step(
        title: Text('Receiver Information'),
        state: setStepState(2),
        isActive: false,
        content: Column(
          children: [
            //receiver name
            TextFormField(
              controller: receiverNameController,
              style: TextStyle(color: Theme.of(context).accentColor),
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: 'Name of Item Receiver',
                hintStyle: Theme.of(context).textTheme.body1.merge(
                      TextStyle(color: Theme.of(context).accentColor),
                    ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
              ),
              onChanged: (newVal) {
                // _formData['receiver_name'] = newVal;
              },
              onSaved: (newVal) {
                // _formData['receiver_name'] = newVal;
              },
            ),
            //receiver number
            TextFormField(
              controller: receiverNumberController,
              style: TextStyle(color: Theme.of(context).accentColor),
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$")),
              ],
              decoration: new InputDecoration(
                hintText: 'Phone Number',
                hintStyle: Theme.of(context).textTheme.body1.merge(
                      TextStyle(color: Theme.of(context).accentColor),
                    ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
              ),
              onChanged: (newVal) {
                // _formData['receiver_phone'] = newVal;
              },
              onSaved: (newVal) {
                // _formData['receiver_phone'] = newVal;
              },
            ),
            //receiver address
            TextFormField(
              controller: receiverAddressController,
              onTap: () => getAddressFromMap(receiverAddressController),
              style: TextStyle(color: Theme.of(context).accentColor),
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: 'Address',
                hintStyle: Theme.of(context).textTheme.body1.merge(
                      TextStyle(color: Theme.of(context).accentColor),
                    ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
              ),
              onSaved: (newVal) {
                // _formData['d_address'] = newVal;
              },
              onChanged: (newVal) {
                // _formData['d_address'] = newVal;
              },
            ),
            //delivery instructions
            TextFormField(
              controller: deliveryInstructionsController,
              style: TextStyle(color: Theme.of(context).accentColor),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 10,
              decoration: new InputDecoration(
                hintText: 'Delivery Instructions',
                hintStyle: Theme.of(context).textTheme.body1.merge(
                      TextStyle(color: Theme.of(context).accentColor),
                    ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
              ),
              onSaved: (newVal) {
                // _formData['d_instruction'] = newVal;
              },
              onChanged: (newVal) {
                // _formData['d_instruction'] = newVal;
              },
            ),
          ],
        ),
      ),
    ];
    void nextStep() {
      if (activeStep.value < steps.length - 1) {
        activeStep.value++;
        print(activeStep.value);
        print(steps.length);
      } else {
        // _pickUpForm.currentState.save();
        // print(_formData.toString());
        Navigator.push(  
          context,
          MaterialPageRoute(
            builder: (context) => CheckoutWidgetPickup(pickUpAddressController, itemNameController, itemDetailController, itemSizeController, senderNumberController, receiverNumberController, receiverNameController, receiverAddressController, deliveryInstructionsController, setTypeValue, _image.value),
          ),
        );
        // Navigator.pushNamed(context, '/Checkout-Pickup', arguments: _formData);
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

    return _vericationProcess == AuthStatus.Verified
        ? Form(
            key: _pickUpForm,
            child: Stepper(
              type: StepperType.vertical,
              currentStep: activeStep.value,
              onStepContinue: nextStep,
              onStepCancel: cancelStep,
              onStepTapped: goToStep,
              steps: steps,
            ))
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      intro1,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      intro2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    NotSignedInWidget2()
                  ],
                ),
              ),
            ),
          );
  }
}

class SizeType extends StatefulWidget {
  const SizeType({
    Key key,
    @required Map<String, dynamic> formData,
  })  : _formData = formData,
        super(key: key);

  final Map<String, dynamic> _formData;

  @override
  _SizeTypeState createState() => _SizeTypeState();
}

class _SizeTypeState extends State<SizeType> {
  List<String> _locations = ['A', 'B', 'C', 'D'];
  String selectedLocation;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text(
        'Please choose size type',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
      ), // Not necessary for Option 1
      value: selectedLocation,
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          selectedLocation = newValue;
          widget._formData['size_type'] = newValue;
        });
      },
      items: _locations.map((location) {
        return DropdownMenuItem(
          child: new Text(location),
          value: location,
        );
      }).toList(),
    );
  }
}

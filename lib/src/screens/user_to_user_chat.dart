import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/src/widgets/gradientButton.dart';
import 'package:cartvorie/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:cartvorie/src/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class UserToUserChat extends StatefulWidget {
  @override
  _UserToUserChatState createState() => _UserToUserChatState();
}

class _UserToUserChatState extends State<UserToUserChat> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'review': null, 'rating': null};

  var _supportType = [
    "Customer Service",
    "Technical Support",
    "Billing",
  ];

  String _currentSelectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios_rounded,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Contact Admin",
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
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
      body: ListView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          children: <Widget>[
            Column(
                children: List.generate(5, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/chatdetails');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(children: <Widget>[
                    Container(
                      width: 55,
                      height: 55,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500],
                                    offset: Offset(0.0, 1.5),
                                    blurRadius: 1.5,
                                  ),
                                ],
                                color: Color(0xFF7401E0),
                                image: DecorationImage(
                                    image: AssetImage('img/logo.png'),
                                    fit: BoxFit.cover)),
                            // child: Padding(
                            //   padding: const EdgeInsets.all(3.0),
                            //   child: Container(
                            //     width: 75,
                            //     height: 75,
                            //     decoration: BoxDecoration(
                            //       color: Colors.black,
                            //         shape: BoxShape.circle,
                            //         image: DecorationImage(
                            //             image: AssetImage('img/logo.png'),
                            //             fit: BoxFit.cover)),
                            //   ),
                            // ),
                          ),
                          Positioned(
                            top: 38,
                            left: 39,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 3)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Technical Support',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '12.14pm',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF7401E0)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Admin',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF7401E0)),
                              ),
                              Text(
                                '12.14pm',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF7401E0)),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFCC00FF),
                                      Color(0xFF7401E0)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[500],
                                      offset: Offset(0.0, 1.5),
                                      blurRadius: 1.5,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text("2",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    )),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width - 135,
                          //   child: Text(
                          //     'message' + " - " + 'created_at',
                          //     style: TextStyle(
                          //         fontSize: 15,
                          //         color: Colors.black.withOpacity(0.8)),
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ]),
                ),
              );
            })),
          ]),
      floatingActionButton: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ],
        ),
        child: FlatButton(
          onPressed: () {
            buildShowDialog(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "New Message",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.edit,
                size: 14,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            elevation: 3,
            title: Row(
              children: <Widget>[
                Icon(UiIcons.information, size: 14, color: Color(0xFF7401E0)),
                SizedBox(width: 10),
                Text(
                  'Admin contact form :',
                  style: Theme.of(context).textTheme.body2.merge(TextStyle(
                      color: Color(0xFF7401E0),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
                )
              ],
            ),
            children: <Widget>[
              Form(
                key: _profileSettingsFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              labelText: 'Select Department',
                              labelStyle: TextStyle(
                                fontSize: 15,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 16.0),
                              hintText: 'Select Department',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _currentSelectedValue,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _currentSelectedValue = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _supportType.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(color: Theme.of(context).hintColor),
                      decoration: _buildInputDecoration(),
                      onSaved: (String value) {
                        formData['message'] = value;
                      },
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RaisedGradientButton(
                child: Text(
                  'Message',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFCC00FF), Color(0xFF7401E0)],
                ),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print('valid!');
                    print(formKey);
                  } else {
                    print('invalid!');
                  }
                },
              ),
              SizedBox(height: 10),
            ],
          );
        });
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      labelText: 'Type Text Here...',
      labelStyle: TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white70,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.grey[400], width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }
}

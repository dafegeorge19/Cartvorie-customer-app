import 'package:cartvorie/config/ui_icons.dart';
import 'package:cartvorie/config/validators.dart';
import 'package:cartvorie/src/models/user.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:cartvorie/src/services/profile_service.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart' show DateFormat;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileSettingsDialog extends StatefulWidget {
  final UserModel user;
  final VoidCallback onChanged;

  ProfileSettingsDialog({Key key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(UiIcons.user_1),
                    SizedBox(width: 10),
                    Text(
                      'Profile Settings',
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'Code', labelText: 'First Name'),
                          initialValue: widget.user.user.firstname,
                          validator: (input) => input.trim().length < 3
                              ? 'Not a valid full name'
                              : null,
                          onSaved: (input) => widget.user.user.lastname = input,
                        ),
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'Sahir', labelText: 'Last Name'),
                          initialValue: widget.user.user.lastname,
                          validator: (input) => input.trim().length < 3
                              ? 'Not a valid full name'
                              : null,
                          onSaved: (input) => widget.user.user.lastname = input,
                        ),
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(
                              hintText: 'youremail@gmail.com',
                              labelText: 'Email Address'),
                          initialValue: widget.user.user.email,
                          validator: validateEmail,
                          onSaved: (input) => widget.user.user.email = input,
                        ),
                        // phone number
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$")),
                          ],
                          decoration: getInputDecoration(
                              hintText: 'phone number',
                              labelText: 'phone Number'),
                          initialValue: widget.user.user.phoneNumber,
                          validator: validateRequired,
                          onSaved: (input) =>
                              widget.user.user.phoneNumber = input,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          'Save',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Text(
        "Edit",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  Future<void> _submit() async {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      final result = await context
          .read(profileServiceProvider)
          .updateUserProfile(widget.user.accessToken, widget.user);
      print(result);
      Navigator.pop(context);
    }
  }
}

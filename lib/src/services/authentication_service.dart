import 'dart:convert';

import 'package:cartvorie/config/base_api.dart';
import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';


final authenticationProvider = StateNotifierProvider((ref)=>AuthenticationService());

enum AuthStatus {
  LoggedIn,
  NotLoggedIn,
  Authenticating,
  Registered,
  NotRegistered,
  AppOpened,
  Registering,
  LoggedOut,
  Verified,
  Verifying,
}

class AuthenticationService extends StateNotifier<AuthStatus> {
  AuthStatus _loggedInAuthStatus = AuthStatus.LoggedIn;
  AuthStatus _notLoggedInAuthStatus = AuthStatus.NotLoggedIn;
  AuthStatus _registeredAuthStatus = AuthStatus.Registered;
  AuthStatus _notRegisteredAuthStatus = AuthStatus.NotRegistered;
  AuthStatus _appOpenedAuthStatus = AuthStatus.AppOpened;
  AuthStatus _registeringAuthStatus = AuthStatus.Registering;
  AuthStatus _loggedOutAuthStatus = AuthStatus.LoggedOut;
  AuthStatus _authenticationAuthStatus = AuthStatus.Authenticating;
  AuthStatus _verified= AuthStatus.Verified;
  AuthStatus _notVerified = AuthStatus.Verifying;
  AuthenticationService([AuthStatus authStatus]) : super( authStatus ?? AuthStatus.NotLoggedIn);

  AuthStatus get loggedInAuthStatus => _loggedInAuthStatus;

  AuthStatus get registeredInAuthStatus => _registeredAuthStatus;

  AuthStatus get notLoggedInAuthStatus => _notLoggedInAuthStatus;

  AuthStatus get notRegisteredAuthStatus => _notRegisteredAuthStatus;

  AuthStatus get appOpenedAuthStatus => _appOpenedAuthStatus;

  AuthStatus get registeringAuthStatus => _registeringAuthStatus;

  AuthStatus get loggedOutAuthStatus => _loggedOutAuthStatus;

  AuthStatus get authenticating => _authenticationAuthStatus;

  AuthStatus get verified => _verified;

  AuthStatus get notVerified => _notVerified;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    state = AuthStatus.Authenticating;

    Response response = await post(
      BaseApi.login,
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      UserModel authUser =  UserModel.fromJson(responseData) ;
      UserPreferences().saveUser(authUser);
      final getUser = await UserPreferences().getUser();
        if(getUser.status == true){
          state = AuthStatus.LoggedIn;
          state = AuthStatus.Verified;
        }
        else{
          state = AuthStatus.Verifying;
        }
      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      state = AuthStatus.NotLoggedIn;
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String passwordConfirmation,
    String accountType,
  ) async {
    var result;
    state = AuthStatus.Registering;

    final Map<String, dynamic> registrationData = {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'account_type': accountType,
    };
    Response response = await post(
      BaseApi.register,
      body: json.encode(registrationData),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode == 200){
      final Map<String, dynamic> responseData = json.decode(response.body);
      UserModel authUser = UserModel.fromJson(responseData);
      print('gotten user${authUser.user.firstname}');
        UserPreferences().saveUser(authUser);
      state = AuthStatus.Registered;
      state = AuthStatus.Verifying;
      result = {'status': true, 'message': 'Successful', 'user': authUser};

    } else{

      state = AuthStatus.NotRegistered;
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;

  }

  void verifyEmail(String email) async {
    final Map<String, dynamic> registrationData = {
      'email': email,
    };

    Response response = await post(
      BaseApi.register,
      body: json.encode(registrationData),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode == 200){
      var code = registrationData['data'];
      VerificationPreference().saveVerificationCode(code);
      return code;
    }
  }

  void confirmVerification(String code)async{
   final vCode= await VerificationPreference().getVerificationCode();
    if(code == vCode){
      state = AuthStatus.Verified;
    }
  }

  void logout ()async{
    UserPreferences().removeUser();
    state = AuthStatus.LoggedOut;
  }
  void setVerified(){
    state = verified;
  }
}
/// verification not complete from end point
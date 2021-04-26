import 'package:cartvorie/src/models/user_model.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userPreferenceProvider = Provider<UserPreferences>((ref) {
  return UserPreferences();
});

class AppOpened {
  void saveOpenState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('app_opened', 'opened');
  }

  Future<String> getOpenState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String open = prefs.getString('app_opened');
    return open;
  }
}

class VerificationPreference {
  void saveVerificationCode(String verificationCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('code', verificationCode);
  }

  Future<String> getVerificationCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString('code');
    return code;
  }
}

class UserPreferences {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("id", user.user.userId);
    prefs.setString("firstname", user.user.firstname);
    prefs.setString("lastname", user.user.lastname);
    prefs.setString("phone", user.user.phoneNumber);
    prefs.setString("email", user.user.email);
    prefs.setString("account_type", user.user.accountType);
    prefs.setString("access_token", user.accessToken);
    prefs.setBool('status', user.status);
    print(
        "object prefere  name: ${user.user.firstname} ${user.user.lastname} ");

    return true;
  }

  static Future<String> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access_token");
    return accessToken;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt("id");
    String firsName = prefs.getString("firstname");
    String lastName = prefs.getString("lastname");
    String email = prefs.getString("email");
    String phoneNumber = prefs.getString("phone");
    String accountType = prefs.getString("account_type");
    bool status = prefs.getBool('status');
    String accessToken = prefs.getString("access_token");

    return UserModel(
      user: UserData(
        userId: id,
        firstname: firsName,
        lastname: lastName,
        email: email,
        phoneNumber: phoneNumber,
        accountType: accountType,
      ),
      accessToken: accessToken,
      status: status,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("firstName");
    prefs.remove("lastName");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("account_type");
    prefs.remove("access_token");
    prefs.remove('status');
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }

  Future<bool> getStatus(arg) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('status');
    return status;
  }
}

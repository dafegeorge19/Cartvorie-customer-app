import 'package:cartvorie/config/user_preference.dart';
import 'package:cartvorie/src/models/user_model.dart';
import 'package:cartvorie/src/models/settings_model.dart';
import 'package:cartvorie/src/services/location_calculator.dart';
import 'package:cartvorie/src/services/shop_service.dart';
import 'package:hooks_riverpod/all.dart';

final getUserProvider = FutureProvider<UserModel>((ref) async {
  final userProvider = ref.watch(userPreferenceProvider).getUser();
  final user = await userProvider;
  return user;
});

final getSettingsProvider = FutureProvider<SettingsModel>((ref) async {
  final settingProvider = ref.watch(shopServiceProvider).getSettingsDetails();
  final setting = await settingProvider;
  return setting;
});

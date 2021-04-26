import 'package:cartvorie/src/services/authentication_service.dart';
import 'package:hooks_riverpod/all.dart';

final authenticationStateProvider = Provider<AuthStatus>(
    (ref) => ref.watch(authenticationProvider.state));



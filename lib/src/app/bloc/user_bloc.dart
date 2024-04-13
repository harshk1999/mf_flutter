import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/models/login/otp_model.dart';

class UserBloc {
  final ValueNotifier<User?> _userNotifier = ValueNotifier<User?>(null);
  ValueListenable<User?> get user => _userNotifier;

  set setUser(User user) {
    _userNotifier.value = user;
  }
}

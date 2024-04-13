import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/auth_repo/login_repository.dart';
import 'package:mf_app/src/app/repository/models/login/otp_model.dart';
import 'package:mf_app/src/app/services/storage_service.dart';

abstract class SplashViewState {}

class SplashIntial implements SplashViewState {}

class LoggedOut implements SplashViewState {}

class SplashError implements SplashViewState {
  final String error;

  SplashError({required this.error});
}

class LoggedIn implements SplashViewState {
  final User user;

  LoggedIn({required this.user});
}

class SplashViewModel {
  final LoginRepository loginRepository;

  final ValueNotifier<SplashViewState> _splashNotifier =
      ValueNotifier<SplashViewState>(SplashIntial());

  SplashViewModel({required this.loginRepository}) {
    checkLoginStatus();
  }
  ValueListenable<SplashViewState> get splashNotifier => _splashNotifier;

  Future<void> checkLoginStatus() async {
    try {
      final user = await loginRepository.getUser();

      if (user != null) {
        _splashNotifier.value = LoggedIn(user: user);
        return;
      }

      _splashNotifier.value = LoggedOut();
    } catch (e) {
      _splashNotifier.value = SplashError(error: e.toString());
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/auth_repo/login_repository.dart';
import 'package:mf_app/src/app/repository/models/login/otp_model.dart';

abstract class OtpState {}

class EnterOtp implements OtpState {}

class OtpLoading implements OtpState {}

class OtpError implements OtpState {
  final String error;

  OtpError({required this.error});
}

class LoggedIn implements OtpState {
  final User user;

  LoggedIn({required this.user});
}

class LoggedOut implements OtpState {}

class OTPViewModel {
  final LoginRepository otpRepo;

  OTPViewModel({required this.otpRepo});

  final ValueNotifier<OtpState> _otpNotifier = ValueNotifier(EnterOtp());
  ValueListenable<OtpState> get otpNotifier => _otpNotifier;
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    _otpNotifier.value = OtpLoading();

    try {
      final user = await otpRepo.getUserAndVerifyOtp(phoneNumber, otp);
      _otpNotifier.value = LoggedIn(user: user);
    } on String catch (e) {
      _otpNotifier.value = OtpError(error: e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    await otpRepo.logout();
    _otpNotifier.value = LoggedOut();
  }

  // Future<void> checkPanStatus() async {
  //   try {
  //     final hasPan = await otpRepo.hasPan();
  //     if (hasPan) {
  //       _otpNotifier.value = OtpWithPan();
  //     } else {
  //       _otpNotifier.value = OtpWithoutPan();
  //     }
  //   } catch (e) {
  //     _otpNotifier.value = OtpError(error: e.toString());
  //   }
  // }
}

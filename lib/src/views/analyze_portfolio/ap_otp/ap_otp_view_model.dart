import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/analyze_your_portfolio/mf_central_repo.dart';

abstract class APOtpState {}

class APOtpInitial implements APOtpState {}

class APOtpLoading implements APOtpState {}

class APOtpError implements APOtpState {
  final String error;

  APOtpError({required this.error});
}

class APOtpEntered implements APOtpState {}

class AnalyzePortfoliOtpViewModel {
  final MfCentralRepository mfCentralRepository;

  AnalyzePortfoliOtpViewModel({required this.mfCentralRepository});

  final ValueNotifier<APOtpState> _apOtpNotifier =
      ValueNotifier<APOtpState>(APOtpInitial());

  ValueListenable<APOtpState> get apOtpNotifier => _apOtpNotifier;

  Future<void> verifyOtpAnanlyzePortfolio(
      String mobileNumber, String otp) async {
    _apOtpNotifier.value = APOtpLoading();
    try {
      await mfCentralRepository.verifyOtpMfCentral(mobileNumber, otp);
      _apOtpNotifier.value = APOtpEntered();
    } catch (e) {
      _apOtpNotifier.value = APOtpError(error: e.toString());
      rethrow;
    }
  }

  final ValueNotifier<bool> _toggleNotifier = ValueNotifier(false);
  ValueListenable<bool> get toggleNotifier => _toggleNotifier;

  void toggleVisbility() {
    _toggleNotifier.value = !toggleNotifier.value;
  }
}

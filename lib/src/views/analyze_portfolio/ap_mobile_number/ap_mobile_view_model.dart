import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/analyze_your_portfolio/mf_central_repo.dart';
import 'package:mf_app/src/app/repository/models/login/otp_model.dart';

abstract class ApPhoneNumberState {}

class ApPhoneNumberInitial implements ApPhoneNumberState {}

class ApPhoneNumberLoading implements ApPhoneNumberState {}

class ApPhoneNumberError implements ApPhoneNumberState {
  final String error;

  ApPhoneNumberError({required this.error});
}

class ApPhoneNumberUpdated implements ApPhoneNumberState {}

class AnalyzePortfolioPhoneViewModel {
  final MfCentralRepository mfCentralRepository;

  AnalyzePortfolioPhoneViewModel({required this.mfCentralRepository});

  final ValueNotifier<ApPhoneNumberState> _apPhoneNotiifer =
      ValueNotifier(ApPhoneNumberInitial());
  ValueListenable<ApPhoneNumberState> get apPhoneNotifier => _apPhoneNotiifer;

  Future<void> updatePhoneNumber(String phoneNumber, User user) async {
    _apPhoneNotiifer.value = ApPhoneNumberLoading();
    try {
      final pan = user.pan;
      final mobileNumber = phoneNumber;
      await mfCentralRepository.requestOtp(pan, mobileNumber);
      _apPhoneNotiifer.value = ApPhoneNumberUpdated();
    } catch (e) {
      _apPhoneNotiifer.value = ApPhoneNumberError(error: e.toString());
      rethrow;
    }
  }
}

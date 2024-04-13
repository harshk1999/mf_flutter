import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/auth_repo/login_repository.dart';

abstract class APPanState {}

class APPanInitial implements APPanState {}

class APPanLoading implements APPanState {}

class APPanError implements APPanState {
  final String error;

  APPanError({required this.error});
}

class APPanEntered implements APPanState {}

class AnalyzePortfolioPanViewModel {
  final LoginRepository loginRepository;

  AnalyzePortfolioPanViewModel({required this.loginRepository});

  final ValueNotifier<APPanState> _apPanNotifier =
      ValueNotifier<APPanState>(APPanInitial());

  ValueListenable<APPanState> get apPanNotifier => _apPanNotifier;

  Future<void> updatePanForMfCentral(String pan, String userId) async {
    _apPanNotifier.value = APPanLoading();
    try {
      await loginRepository.updatePan(pan, userId);
      _apPanNotifier.value = APPanEntered();
    } catch (e) {
      _apPanNotifier.value = APPanError(error: e.toString());
      rethrow;
    }
  }
}

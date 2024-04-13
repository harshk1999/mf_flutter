import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/auth_repo/login_repository.dart';

abstract class PanState {}

class PanInitial implements PanState {}

class PanLoading implements PanState {}

class PanError implements PanState {
  final String error;

  PanError({required this.error});
}

class PanEntered implements PanState {}

class PanViewModel {
  final LoginRepository loginRepository;

  PanViewModel({required this.loginRepository});

  final ValueNotifier<PanState> _panNotifier =
      ValueNotifier<PanState>(PanInitial());
  ValueListenable<PanState> get panNotifier => _panNotifier;

  Future<void> updatePanForMfCentral(String pan, String userId) async {
    _panNotifier.value = PanLoading();
    try {
      await loginRepository.updatePan(pan, userId);
      _panNotifier.value = PanEntered();
    } catch (e) {
      _panNotifier.value = PanError(error: e.toString());
      rethrow;
    }
  }
}

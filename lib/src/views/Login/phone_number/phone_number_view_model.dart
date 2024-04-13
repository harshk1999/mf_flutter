import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/auth_repo/login_repository.dart';

abstract class PhoneNumberState {}

class PhoneNumberInitial implements PhoneNumberState {}

class PhoneNumberLoading implements PhoneNumberState {}

class PhoneNumberError implements PhoneNumberState {
  final String error;

  PhoneNumberError(this.error);
}

class PhoneNumberEntered implements PhoneNumberState {
  final String successMsg;

  PhoneNumberEntered({required this.successMsg});
}

class PhoneNumberField {
  final String? phoneNumber;

  PhoneNumberField({required this.phoneNumber});

  factory PhoneNumberField.empty() {
    return PhoneNumberField(phoneNumber: null);
  }
}

class PhoneNumberViewModel {
  final LoginRepository phoneNumberRepo;

  final ValueNotifier<PhoneNumberState> _phoneNumbeNotifier =
      ValueNotifier<PhoneNumberState>(PhoneNumberInitial());

  PhoneNumberViewModel({required this.phoneNumberRepo});
  ValueListenable<PhoneNumberState> get phoneNumberNotifier =>
      _phoneNumbeNotifier;

  final ValueNotifier<PhoneNumberField> _phoneNumberFieldNotifier =
      ValueNotifier<PhoneNumberField>(PhoneNumberField.empty());
  ValueListenable<PhoneNumberField> get phoneNumberFieldNotifier =>
      _phoneNumberFieldNotifier;

  Future<void> enterPhoneNumber(String phoneNumber) async {
    try {
      if (phoneNumber.isEmpty) {
        _phoneNumberFieldNotifier.value =
            PhoneNumberField(phoneNumber: 'Mobile Number cannot be empty');
        return;
      }

      if (phoneNumber.length < 10 && phoneNumber.length > 10) {
        _phoneNumberFieldNotifier.value =
            PhoneNumberField(phoneNumber: 'Enter a Valid Mobile Number');
        return;
      }
      _phoneNumberFieldNotifier.value = PhoneNumberField(phoneNumber: null);

      _phoneNumbeNotifier.value = PhoneNumberLoading();
      final successMsg = await phoneNumberRepo.sendOtp(phoneNumber);
      _phoneNumbeNotifier.value = PhoneNumberEntered(successMsg: successMsg);
    } on String catch (e) {
      _phoneNumbeNotifier.value = PhoneNumberError(e.toString());
    } catch (e) {
      rethrow;
    }
  }
}

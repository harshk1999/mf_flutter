import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mf_app/src/app/constants.dart';
import 'package:mf_app/src/app/repository/models/login/otp_model.dart';
import 'package:mf_app/src/app/services/storage_service.dart';

class LoginRepository {
  late String _sessionId;
  late String _pan;
  late String _mobileNumber;

  Future<String> sendOtp(String phoneNumber) async {
    final body = {"phone_number": phoneNumber};
    final response = await http.post(Uri.parse('$devServerUrl/api/mf/login'),
        body: jsonEncode(body));
    _sessionId = response.headers["set-cookie"] ?? "";
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final message = responseData['data']['message'];
      return message;
    } else {
      throw 'Error';
    }
  }

  // Future<void> otpVerfication(String PhoneNumber , String otp) {

  // }

  Future<User> getUserAndVerifyOtp(String phoneNumber, String otp) async {
    final body = {"phone_number": phoneNumber, "otp": otp};
    final response = await http.post(
        Uri.parse('$devServerUrl/api/mf/login/otp-verification'),
        body: jsonEncode(body),
        headers: {"cookie": _sessionId});

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final user = User.fromJson(responseData['data']['user']);
      _sessionId = response.headers['set-cookie'] ?? _sessionId;

      _pan = user.pan;
      _mobileNumber = user.mobileNo;
      await StorageService.saveData('session_id', _sessionId);
      await StorageService.saveData('pan', _pan);
      // await StorageService.saveData('mobile', _mobileNumber);
      await StorageService.saveObject('user', user.toJson());
      // print(StorageService.saveObject('user', user)1);
      return user;
    } else {
      throw Exception('Failed to verify OTP: ${response.statusCode}');
    }
  }

  Future<bool> isLoggedIn() async {
    final sessionId = await StorageService.getData('session_id');
    if (sessionId != null) {
      _sessionId = sessionId;
    }
    return sessionId != null;
  }

  Future<User?> getUser() async {
    final user = await StorageService.getData('user');
    if (user == null) {
      return null;
    }
    final decodedUser = jsonDecode(user);
    return User.fromJson(decodedUser);
  }

  Future<bool> hasPan() async {
    final pan = await StorageService.getData('pan');
    if (pan != null) {
      _pan = pan;
    }

    return pan != null;
  }

  Future<void> updatePan(String pan, String userId) async {
    final body = {"pan": pan};
    final response = await http.patch(
        Uri.parse('$devServerUrl/api/user/$userId'),
        body: jsonEncode(body),
        headers: {"cookie": _sessionId});

    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        throw "Invalid Session";
      }
      throw "Pan Not Udpated";
    }
  }

  Future<void> logout() async {
    await StorageService.removeData('session_id');
    await StorageService.removeData('pan');
    await StorageService.removeData('user');
    _sessionId = '';
    _pan = '';
  }
}

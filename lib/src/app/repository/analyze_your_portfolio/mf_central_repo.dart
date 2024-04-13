import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mf_app/src/app/constants.dart';
import 'package:mf_app/src/app/repository/models/mf_central/portfolio_analysis_model.dart';
import 'package:mf_app/src/app/services/storage_service.dart';

class MfCentralRepository {
  late String _sessionId;

  Future<(String, String)> requestOtp(String pan, String mobileNumber) async {
    final body = {"pan": pan, "mobile": mobileNumber};
    final cookie = await StorageService.getData('session_id');

    final response = await http.post(
        Uri.parse('$devServerUrl/api/tool/portfolio-analysis'),
        body: jsonEncode(body),
        headers: {"cookie": cookie!});
    // _sessionId = response.headers["set-cookie"] ?? '';
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final String isFetched = responseData['data']['is_fetched'];
      final String msg = responseData['data']['message'];

      return (isFetched, msg);
    } else {
      throw Exception('failed to Analyse Your portfolio');
    }
  }

  Future<void> verifyOtpMfCentral(String mobileNumber, String otp) async {
    final body = {"mobile_no": mobileNumber, "otp": otp};
    final cookie = await StorageService.getData('session_id');

    final response = await http.post(
        Uri.parse('$devServerUrl/api/tool/investorConsent'),
        body: jsonEncode(body),
        headers: {"cookie": cookie!});

    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        throw "Invalid Session";
      }
      throw "Invalid Otp";
    }
  }

  Future<PortfolioMfCentral> fetchPortfolioData(String mobileNumber) async {
    int maxAttempts = 12;
    int attempt = 1;
    final cookie = await StorageService.getData('session_id');

    while (attempt <= maxAttempts) {
      final response = await http.get(
          Uri.parse('$devServerUrl/api/tool/portfolio?mobile=$mobileNumber'),
          headers: {'cookie': cookie!});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        PortfolioMfCentral portfolioMfCentral =
            PortfolioMfCentral.fromJson(data["data"]);

        return portfolioMfCentral;
      }
      await Future.delayed(const Duration(seconds: 5));
      attempt++;
    }

    throw Exception('Failed to fetch portfolio data within 1 minute');
  }
}

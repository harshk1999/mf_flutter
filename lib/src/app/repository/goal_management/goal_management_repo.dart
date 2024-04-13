import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mf_app/src/app/constants.dart';

import 'package:mf_app/src/app/repository/models/goal_management/goal_management_model.dart';

class GoalManagementRepository {
  Future<RecommendedFunds> getAllFunds(
      int pageNo, int fundRating, int noOfRecords) async {
    final response = await http.get(Uri.parse(
        '$devServerUrl/api/mf/allfunds?fund_rating=$fundRating&no_of_records=$noOfRecords&page_no=$pageNo'));

    Map<String, dynamic> data = jsonDecode(response.body);

    RecommendedFunds recommendedFunds = RecommendedFunds.fromJson(data['data']);

    return recommendedFunds;
  }
}

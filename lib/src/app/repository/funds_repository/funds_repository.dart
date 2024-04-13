import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mf_app/src/app/constants.dart';
import 'package:mf_app/src/app/repository/models/all_funds/all_funds_model.dart';
import 'package:mf_app/src/app/repository/models/all_funds/faqs.dart';
import 'package:mf_app/src/app/repository/models/all_funds/filters_list_model.dart';
import 'package:mf_app/src/app/repository/models/all_funds/fund_info_model.dart';
import 'package:mf_app/src/app/repository/models/all_funds/performance_model.dart';
import 'package:mf_app/src/app/repository/models/all_funds/single_fund_detail_model.dart';
import 'package:mf_app/src/app/repository/models/explore_models/popular_funds_in_category_model.dart';
import 'package:mf_app/src/app/repository/models/explore_models/search_model.dart';
import 'package:mf_app/src/app/repository/models/explore_models/top_smc_fund_model.dart';
import 'package:mf_app/src/app/repository/models/graphs/allocation_model.dart';
import 'package:mf_app/src/app/repository/models/graphs/graphs_model.dart';
import 'package:http/http.dart' as http;

class FundsRepository {
  Future<List<TopFunds>> getTopFunds() async {
    try {
      // String response =
      //     await rootBundle.loadString('assets/json/explore/top_smc_funds.json');

      final response =
          await http.get(Uri.parse('$devServerUrl/api/mf/topsmcfunds'));
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> funds = data['data'] == null
          ? []
          : data['data'].map((e) => TopFunds.fromJson(e)).toList();
      List<TopFunds> topFunds = List<TopFunds>.from(funds);
      return topFunds;
    } catch (e) {
      rethrow;
      // throw Exception('Failed to load Data');
    }
  }

  Future<PopularFundsInCategory> getPopularFundsAndTrendingCateogries(
      String category) async {
    try {
      final response = await http.get(
          Uri.parse('$devServerUrl/api/mf/popularfunds?category=$category'));

      Map<String, dynamic> data = jsonDecode(response.body);

      PopularFundsInCategory popularFundsInCategory =
          PopularFundsInCategory.fromJson(data['data']);

      return popularFundsInCategory;
    } catch (e) {
      rethrow;
    }
  }

  // Future<FiltersList> getFiltersList() {}

  // Future<FundInfo> getFundInfo(int id) async {
  //   try {
  //     // String baseUrl =
  //     //     'https://dfc7-2405-201-403b-90c7-3f67-53a3-cd91-331a.ngrok-free.app';
  //     // final response =
  //     //     await http.get(Uri.parse('$baseUrl/api/mf/fund/$id/about/managers'));

  //     String response =
  //         await rootBundle.loadString('assets/json/all_funds/fund_info.json');
  //     Map<String, dynamic> data = jsonDecode(response);
  //     FundInfo fundInfo = FundInfo.fromJson(data['data']);
  //     return fundInfo;
  //   } catch (e) {
  //     rethrow;
  //   }

  // Future<List<CategoryDetails>> getCategoriesBySector(String sector) async {
  //   try {
  //     String response = await rootBundle
  //         .loadString('assets/json/explore/trendingCategories.json');
  //     Map<String, dynamic> data = jsonDecode(response);
  //     TrendingCategories trendingCategories = TrendingCategories.fromJson(data);

  //     for (var trendingCategory in trendingCategories.trendingCategories) {
  //       if (trendingCategory.sector == sector) {
  //         return trendingCategory.categories;
  //       }
  //     }
  //     return [];
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<List<SearchResult>> getSearchResult(
      String name, int noOfRecords) async {
    final response = await http.get(Uri.parse(
        '$devServerUrl/api/mf/search?name=$name&no_of_records=$noOfRecords'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      final search = Search.fromJson(body);
      return search.data;
    } else {
      throw Exception('failed to load Search');
    }
  }

  Future<AllFunds> getAllFunds(int pageNo, String sortedByValues,
      List<(String, List<String>)> filters) async {
    String url =
        '$devServerUrl/api/mf/allfunds?page_no=$pageNo&sort=$sortedByValues';
    for (var a in filters) {
      String values = "";
      for (var i = 0; i < a.$2.length; i++) {
        if (i != 0) {
          values += ",";
        }
        values += a.$2[i];
      }
      url += "&${a.$1}=$values";
    }
    // print(url);
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);

    AllFunds allFunds = AllFunds.fromJson(data['data']);

    return allFunds;
  }

  Future<FiltersList> getFilterList() async {
    final response =
        await http.get(Uri.parse('$devServerUrl/api/mf/scheme/filters'));
    Map<String, dynamic> data = jsonDecode(response.body);

    FiltersList filtersList = FiltersList.fromJson(data['data']);

    return filtersList;
  }

  Future<SingleFundDetails> getSingleFundDetail(int schemeId) async {
    try {
      // String response = await rootBundle
      //     .loadString('assets/json/all_funds/single_fund_details.json');

      final response =
          await http.get(Uri.parse('$devServerUrl/api/mf/$schemeId/details'));

      Map<String, dynamic> data = jsonDecode(response.body);

      SingleFundDetails singleFundDetails =
          SingleFundDetails.fromJson(data['data']);
      return singleFundDetails;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Composition>> getCompositionAllocation(int id) async {
    final response = await http
        .get(Uri.parse('$devServerUrl/api/mf/schemes/$id/composition'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> compositionsData = responseData["data"]["composition"];

      List<Composition> compositions =
          compositionsData.map((json) => Composition.fromJson(json)).toList();
      return compositions;
    } else {
      throw Exception('Failed to load composition data');
    }
  }

  // Future<Stats> getStats() async {
  //   try {
  //     String response = await rootBundle
  //         .loadString('assets/json/all_funds/single_fund_details.json');

  //     Map<String, dynamic> data = jsonDecode(response);

  //     Stats stats = Stats.fromJson(data['data']['stats']);

  //     return stats;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<FundForGraph> getFundForGraph(int schemeId, String duration) async {
    try {
      // String response =
      //     await rootBundle.loadString('assets/json/all_funds/graphs.json');

      final response = await http.get(
          Uri.parse('$devServerUrl/api/mf/$schemeId/graph?duration=$duration'));

      Map<String, dynamic> data = jsonDecode(response.body);

      FundForGraph fundForGraph = FundForGraph.fromJson(data['data']['fund']);

      return fundForGraph;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PerformanceComparsion>> getPerformance(String time) async {
    try {
      final response = await http.get(Uri.parse(
          '$devServerUrl/api/mf/fund/category/equity/subcategory/flexi-cap/returns?time=${time.toLowerCase()}'));
      Map<String, dynamic> data = jsonDecode(response.body);

      List<dynamic> performances =
          data['data'].map((e) => PerformanceComparsion.fromJson(e)).toList();
      List<PerformanceComparsion> performaceList =
          List<PerformanceComparsion>.from(performances);
      return performaceList;
    } catch (e) {
      rethrow;
    }
  }

  Future<FundInformation> getFundInfo(int id) async {
    final response = await http
        .get(Uri.parse('$devServerUrl/api/mf/fund/$id/about/managers'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      FundInformation fundInfo = FundInformation.fromJson(data['data']);
      return fundInfo;
    } else {
      throw ('No Fund Information Found');
    }
  }

  Future<FundQuestions> getFaqs() async {
    try {
      final response =
          await http.get(Uri.parse('$devServerUrl/api/mf/scheme/faqs'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        FundQuestions ques = FundQuestions.fromJson(data['data']);
        return ques;
      } else {
        throw ('No FAQs Available');
      }
    } catch (e) {
      rethrow;
    }
  }
}

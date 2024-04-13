class AllMutualFunds {
  final AllFunds data;

  AllMutualFunds({
    required this.data,
  });

  factory AllMutualFunds.fromJson(Map<String, dynamic> json) => AllMutualFunds(
        data: AllFunds.fromJson(json["data"]),
      );
}

class AllFunds {
  final List<FundInfo> fundInfo;
  final int totalRecords;
  final int pageNumber;

  AllFunds({
    required this.fundInfo,
    required this.totalRecords,
    required this.pageNumber,
  });

  factory AllFunds.fromJson(Map<String, dynamic> json) => AllFunds(
        fundInfo: List<FundInfo>.from(
            json["fund_info"].map((x) => FundInfo.fromJson(x))),
        totalRecords: json["total_records"],
        pageNumber: json["page_number"],
      );
}

class FundInfo {
  final String iconUrl;
  final String name;
  final String category;
  final String subCategory;
  final String schemeType;
  final double ret1Year;
  final double ret3Year;
  final double ret5Year;
  final int fundSize;
  final int fundRating;
  final bool bookmark;
  final String riskType;
  final int schemeId;

  FundInfo({
    required this.iconUrl,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.schemeType,
    required this.ret1Year,
    required this.ret3Year,
    required this.ret5Year,
    required this.fundSize,
    required this.fundRating,
    required this.bookmark,
    required this.riskType,
    required this.schemeId,
  });

  factory FundInfo.fromJson(Map<String, dynamic> json) => FundInfo(
        iconUrl: json["icon_url"],
        name: json["name"],
        category: json["category"],
        subCategory: json["sub_category"],
        schemeType: json["scheme_type"],
        ret1Year: json["ret_1year"].toDouble(),
        ret3Year: json["ret_3year"].toDouble(),
        ret5Year: json["ret_5year"].toDouble(),
        fundSize: json["fund_size"],
        fundRating: json["fund_rating"],
        bookmark: json["bookmark"],
        riskType: json["risk_type"],
        schemeId: json["scheme_id"],
      );
}

class FundDetail {
  final SingleFundDetails data;

  FundDetail({
    required this.data,
  });

  factory FundDetail.fromJson(Map<String, dynamic> json) => FundDetail(
        data: SingleFundDetails.fromJson(json["data"]),
      );
}

class SingleFundDetails {
  final Details details;
  final Stats stats;
  final About about;
  final double return3Year;

  SingleFundDetails({
    required this.details,
    required this.stats,
    required this.about,
    required this.return3Year,
  });

  factory SingleFundDetails.fromJson(Map<String, dynamic> json) =>
      SingleFundDetails(
        details: Details.fromJson(json["details"]),
        stats: Stats.fromJson(json["stats"]),
        about: About.fromJson(json["about"]),
        return3Year: json["return_3_year"]?.toDouble(),
      );
}

class About {
  final int exitLoad;
  final int lockIn;
  final String age;
  final String benchmarks;
  final double beta;

  About({
    required this.exitLoad,
    required this.lockIn,
    required this.age,
    required this.benchmarks,
    required this.beta,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        exitLoad: json["exit_load"],
        lockIn: json["lock_in"],
        age: json["age"],
        benchmarks: json["benchmarks"],
        beta: json["beta"]?.toDouble(),
      );
}

class Details {
  final String iconUrl;
  final String name;
  final String category;
  final String subCategory;
  final bool bookmark;
  final int schemeId;

  Details({
    required this.iconUrl,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.bookmark,
    required this.schemeId,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        iconUrl: json["icon_url"],
        name: json["name"],
        category: json["category"],
        subCategory: json["sub_category"],
        bookmark: json["bookmark"],
        schemeId: json["scheme_id"],
      );
}

class Stats {
  final double nav;
  final double hike;
  final int fundSize;
  final int minSip;
  final double expenseRatio;
  final int vrRating;
  final String riskometer;

  Stats({
    required this.nav,
    required this.hike,
    required this.fundSize,
    required this.minSip,
    required this.expenseRatio,
    required this.vrRating,
    required this.riskometer,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        nav: json["nav"]?.toDouble(),
        hike: json["hike"]?.toDouble(),
        fundSize: json["fund_size"],
        minSip: json["min_SIP"] ?? 0,
        expenseRatio: json["expense_ratio"],
        vrRating: json["vr_rating"],
        riskometer: json["riskometer"],
      );
}

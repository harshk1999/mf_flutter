class PopularFundsAndTrendingCategories {
  final PopularFundsInCategory data;

  PopularFundsAndTrendingCategories({
    required this.data,
  });

  factory PopularFundsAndTrendingCategories.fromJson(
          Map<String, dynamic> json) =>
      PopularFundsAndTrendingCategories(
        data: PopularFundsInCategory.fromJson(json["data"]),
      );
}

class PopularFundsInCategory {
  final List<PopularFund> popularFunds;
  final List<TrendingCategory> trendingCategories;

  PopularFundsInCategory({
    required this.popularFunds,
    required this.trendingCategories,
  });

  factory PopularFundsInCategory.fromJson(Map<String, dynamic> json) =>
      PopularFundsInCategory(
        popularFunds: (json["popular_funds"] as List<dynamic>?)
                ?.map((x) => PopularFund.fromJson(x))
                .toList() ??
            [],
        trendingCategories: (json["trending_categories"] as List<dynamic>?)
                ?.map((x) => TrendingCategory.fromJson(x))
                .toList() ??
            [],
      );
}

class PopularFund {
  final String iconUrl;
  final String name;
  final double returns;
  final String duration;
  final bool bookmark;
  final int rating;
  final String category;
  final int schemeId;

  PopularFund({
    required this.iconUrl,
    required this.name,
    required this.returns,
    required this.duration,
    required this.bookmark,
    required this.rating,
    required this.category,
    required this.schemeId,
  });

  factory PopularFund.fromJson(Map<String, dynamic> json) => PopularFund(
        iconUrl: json["icon_url"],
        name: json["name"],
        returns: json["returns"]?.toDouble(),
        duration: json["duration"],
        bookmark: json["bookmark"],
        rating: json["rating"],
        category: json["category"],
        schemeId: json["scheme_id"],
      );

  Map<String, dynamic> toJson() => {
        "icon_url": iconUrl,
        "name": name,
        "returns": returns,
        "duration": duration,
        "bookmark": bookmark,
        "rating": rating,
        "category": category,
        "scheme_id": schemeId,
      };
}

class TrendingCategory {
  final String name;
  final String icon;

  TrendingCategory({
    required this.name,
    required this.icon,
  });

  factory TrendingCategory.fromJson(Map<String, dynamic> json) =>
      TrendingCategory(
        name: json["name"],
        icon: json["icon"],
      );
}

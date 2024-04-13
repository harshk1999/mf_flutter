class TrendingCategories {
  final List<TrendingCategory> trendingCategories;

  TrendingCategories({
    required this.trendingCategories,
  });

  factory TrendingCategories.fromJson(Map<String, dynamic> json) =>
      TrendingCategories(
        trendingCategories: List<TrendingCategory>.from(
            json["trendingCategories"]
                .map((x) => TrendingCategory.fromJson(x))),
      );
}

class TrendingCategory {
  final String sector;
  final List<CategoryDetails> categories;

  TrendingCategory({
    required this.sector,
    required this.categories,
  });

  factory TrendingCategory.fromJson(Map<String, dynamic> json) =>
      TrendingCategory(
        sector: json["sector"],
        categories: List<CategoryDetails>.from(
            json["categories"].map((x) => CategoryDetails.fromJson(x))),
      );
}

class CategoryDetails {
  final String name;
  final String icon;

  CategoryDetails({
    required this.name,
    required this.icon,
  });

  factory CategoryDetails.fromJson(Map<String, dynamic> json) =>
      CategoryDetails(
        name: json["name"],
        icon: json["Icon"],
      );
}

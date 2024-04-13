class Filters {
  final FiltersList data;

  Filters({
    required this.data,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        data: FiltersList.fromJson(json["data"]),
      );
}

class FiltersList {
  final List<FundHouse> fundHouses;
  final List<Category> category;
  final List<FundsSubCategory> fundsSubCategory;

  FiltersList({
    required this.fundHouses,
    required this.category,
    required this.fundsSubCategory,
  });

  factory FiltersList.fromJson(Map<String, dynamic> json) => FiltersList(
        fundHouses: List<FundHouse>.from(
            json["FundHouses"].map((x) => FundHouse.fromJson(x))),
        category: List<Category>.from(
            json["Category"].map((x) => Category.fromJson(x))),
        fundsSubCategory: List<FundsSubCategory>.from(
            json["FundsSubCategory"].map((x) => FundsSubCategory.fromJson(x))),
      );
}

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );
}

class FundHouse {
  final String name;
  final int id;

  FundHouse({
    required this.name,
    required this.id,
  });

  factory FundHouse.fromJson(Map<String, dynamic> json) => FundHouse(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class FundsSubCategory {
  final String name;
  final String category;

  FundsSubCategory({
    required this.name,
    required this.category,
  });

  factory FundsSubCategory.fromJson(Map<String, dynamic> json) =>
      FundsSubCategory(
        name: json["name"],
        category: json["category"],
      );
}

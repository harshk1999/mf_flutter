class SchemeComposition {
  final Data data;

  SchemeComposition({
    required this.data,
  });

  factory SchemeComposition.fromJson(Map<String, dynamic> json) =>
      SchemeComposition(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final List<Composition> composition;

  Data({
    required this.composition,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        composition: List<Composition>.from(
            json["composition"].map((x) => Composition.fromJson(x))),
      );
}

class Composition {
  final String name;
  final double percentage;
  final List<Category> categories;

  Composition({
    required this.name,
    required this.percentage,
    required this.categories,
  });

  factory Composition.fromJson(Map<String, dynamic> json) => Composition(
        name: json["name"],
        percentage: json["percentage"]?.toDouble(),
        categories: json['categories'] == null
            ? []
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  final String name;
  final List<Allocation> allocations;

  Category({
    required this.name,
    required this.allocations,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        allocations: json['allocations'] == null
            ? []
            : List<Allocation>.from(
                json["allocations"].map((x) => Allocation.fromJson(x))),
      );
}

class Allocation {
  final String name;
  final double percentage;

  Allocation({
    required this.name,
    required this.percentage,
  });

  factory Allocation.fromJson(Map<String, dynamic> json) => Allocation(
        name: json["name"],
        percentage: json["percentage"]?.toDouble(),
      );
}

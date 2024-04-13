class Allocation {
  final Data data;

  Allocation({
    required this.data,
  });

  factory Allocation.fromJson(Map<String, dynamic> json) => Allocation(
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
  final int percentage;
  final List<Category> categories;

  Composition({
    required this.name,
    required this.percentage,
    required this.categories,
  });

  factory Composition.fromJson(Map<String, dynamic> json) => Composition(
        name: json["name"],
        percentage: json["percentage"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  final String name;
  final List<AllocationElement> allocations;

  Category({
    required this.name,
    required this.allocations,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        allocations: List<AllocationElement>.from(
            json["allocations"].map((x) => AllocationElement.fromJson(x))),
      );
}

class AllocationElement {
  final String name;
  final double percentage;

  AllocationElement({
    required this.name,
    required this.percentage,
  });

  factory AllocationElement.fromJson(Map<String, dynamic> json) =>
      AllocationElement(
        name: json["name"],
        percentage: json["percentage"]?.toDouble(),
      );
}

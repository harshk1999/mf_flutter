class OverViewGraph {
  final Data data;

  OverViewGraph({
    required this.data,
  });

  factory OverViewGraph.fromJson(Map<String, dynamic> json) => OverViewGraph(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final FundForGraph fund;
  final Benchmark benchmark;

  Data({
    required this.fund,
    required this.benchmark,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fund: FundForGraph.fromJson(json["fund"]),
        benchmark: Benchmark.fromJson(json["benchmark"]),
      );
}

class Benchmark {
  final int benchmarkId;
  final String name;
  final dynamic benchmark;
  final dynamic date;

  Benchmark({
    required this.benchmarkId,
    required this.name,
    required this.benchmark,
    required this.date,
  });

  factory Benchmark.fromJson(Map<String, dynamic> json) => Benchmark(
        benchmarkId: json["benchmark_id"],
        name: json["name"],
        benchmark: json["benchmark"],
        date: json["date"],
      );
}

class FundForGraph {
  final int schemeId;
  final String name;
  final List<DateTime> date;
  final List<double> value;
  final double returnPercentage;

  FundForGraph({
    required this.schemeId,
    required this.name,
    required this.date,
    required this.value,
    required this.returnPercentage,
  });

  factory FundForGraph.fromJson(Map<String, dynamic> json) => FundForGraph(
        schemeId: json["scheme_id"],
        name: json["name"],
        date: json["date"] == null
            ? []
            : List<DateTime>.from(json["date"].map((x) => DateTime.parse(x))),
        value: json["value"] == null
            ? []
            : List<double>.from(json["value"].map((x) => x?.toDouble())),
        returnPercentage: json["return_percentage"]?.toDouble(),
      );
}

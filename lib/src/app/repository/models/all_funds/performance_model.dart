class Performance {
  final List<PerformanceComparsion> data;

  Performance({
    required this.data,
  });

  factory Performance.fromJson(Map<String, dynamic> json) => Performance(
        data: List<PerformanceComparsion>.from(
            json["data"].map((x) => PerformanceComparsion.fromJson(x))),
      );
}

class PerformanceComparsion {
  final String name;
  final int nav;
  final double datumReturn;
  final int schemeId;
  final String time;

  PerformanceComparsion({
    required this.name,
    required this.nav,
    required this.datumReturn,
    required this.schemeId,
    required this.time,
  });

  factory PerformanceComparsion.fromJson(Map<String, dynamic> json) =>
      PerformanceComparsion(
        name: json["name"],
        nav: json["nav"],
        datumReturn: json["return"]?.toDouble(),
        schemeId: json["scheme_id"],
        time: json["time"]!,
      );
}

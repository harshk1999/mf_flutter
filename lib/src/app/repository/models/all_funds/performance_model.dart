class Data {
  final List<Performance> data;

  Data({
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Performance>.from(
            json["data"].map((x) => Performance.fromJson(x))),
      );
}

class Performance {
  final String name;
  final double datumReturn;
  final int schemeId;
  final String time;

  Performance({
    required this.name,
    required this.datumReturn,
    required this.schemeId,
    required this.time,
  });

  factory Performance.fromJson(Map<String, dynamic> json) => Performance(
        name: json["name"],
        datumReturn: json["return"],
        schemeId: json["scheme_id"],
        time: json["time"],
      );
}

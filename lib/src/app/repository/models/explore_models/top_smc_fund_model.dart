class Funds {
  final List<TopFunds> data;

  Funds({
    required this.data,
  });

  factory Funds.fromJson(Map<String, dynamic> json) {
    if (json["data"] == null) {
      return Funds(data: []);
    }
    return Funds(
      data: List<TopFunds>.from(json["data"].map((x) => TopFunds.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TopFunds {
  final String iconUrl;
  final String name;
  final double returns;
  final String duration;
  final bool bookmark;
  final int rating;
  final String category;
  final int schemeId;

  TopFunds({
    required this.iconUrl,
    required this.name,
    required this.returns,
    required this.duration,
    required this.bookmark,
    required this.rating,
    required this.category,
    required this.schemeId,
  });

  factory TopFunds.fromJson(Map<String, dynamic> json) => TopFunds(
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

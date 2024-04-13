class ExploreData {
  final String status;
  final ExploreDetails data;

  ExploreData({
    required this.status,
    required this.data,
  });

  factory ExploreData.fromJson(Map<String, dynamic> json) {
    return ExploreData(
      status: json['status'],
      data: ExploreDetails.fromJson(json['data']),
    );
  }
}

class ExploreDetails {
  final double currentAmount;
  final double returns;
  final String mfName;
  final double mfRating;
  final double mfCagr;
  final String mfIcon;

  ExploreDetails({
    required this.currentAmount,
    required this.returns,
    required this.mfName,
    required this.mfRating,
    required this.mfCagr,
    required this.mfIcon,
  });

  factory ExploreDetails.fromJson(Map<String, dynamic> json) {
    return ExploreDetails(
      currentAmount: json['current_amount'] ?? 0.0,
      returns: json['returns'] ?? 0.0,
      mfName: json['mf_name'] ?? '',
      mfRating: json['mf_rating'] ?? 0.0,
      mfCagr: json['mf_cagr'] ?? 0.0,
      mfIcon: json['mf_icon'] ?? '',
    );
  }
}

class FundInfo {
  final FundInformation data;

  FundInfo({
    required this.data,
  });

  factory FundInfo.fromJson(Map<String, dynamic> json) => FundInfo(
        data: FundInformation.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class FundInformation {
  final List<ManagerInfo> managerInfo;
  final String about;

  FundInformation({
    required this.managerInfo,
    required this.about,
  });

  factory FundInformation.fromJson(Map<String, dynamic> json) =>
      FundInformation(
        managerInfo: List<ManagerInfo>.from(
            json["manager_info"].map((x) => ManagerInfo.fromJson(x))),
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "manager_info": List<dynamic>.from(managerInfo.map((x) => x.toJson())),
        "about": about,
      };
}

class ManagerInfo {
  final String name;
  final String experience;
  final String education;
  final String iconUrl;

  ManagerInfo({
    required this.name,
    required this.experience,
    required this.education,
    required this.iconUrl,
  });

  factory ManagerInfo.fromJson(Map<String, dynamic> json) => ManagerInfo(
        name: json["name"],
        experience: json["experience"],
        education: json["education"],
        iconUrl: json["icon_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "experience": experience,
        "education": education,
        "icon_url": iconUrl,
      };
}

class Otp {
  final OneTimePin data;

  Otp({
    required this.data,
  });

  factory Otp.fromJson(Map<String, dynamic> json) => Otp(
        data: OneTimePin.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class OneTimePin {
  final String message;
  final User user;

  OneTimePin({
    required this.message,
    required this.user,
  });

  factory OneTimePin.fromJson(Map<String, dynamic> json) => OneTimePin(
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  final String id;
  final String name;
  final String emailId;
  final String mobileNo;
  final String uccMfi;
  final String uccMfd;
  final String pan;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic mandates;

  User({
    required this.id,
    required this.name,
    required this.emailId,
    required this.mobileNo,
    required this.uccMfi,
    required this.uccMfd,
    required this.pan,
    required this.createdAt,
    required this.updatedAt,
    required this.mandates,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        emailId: json["email_id"],
        mobileNo: json["mobile_no"],
        uccMfi: json["ucc_mfi"],
        uccMfd: json["ucc_mfd"],
        pan: json["pan"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mandates: json["mandates"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email_id": emailId,
        "mobile_no": mobileNo,
        "ucc_mfi": uccMfi,
        "ucc_mfd": uccMfd,
        "pan": pan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "mandates": mandates,
      };
}

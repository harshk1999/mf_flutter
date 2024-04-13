class Pan {
  final UpdatedPan data;

  Pan({
    required this.data,
  });
}

class UpdatedPan {
  final String message;
  final UserAfterPanUpdate user;

  UpdatedPan({
    required this.message,
    required this.user,
  });
}

class UserAfterPanUpdate {
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

  UserAfterPanUpdate({
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
}

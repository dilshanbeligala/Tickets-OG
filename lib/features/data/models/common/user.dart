class User {
  final String? firstName;
  final String? eventName;
  final int? eventId;
  final String? userStatus;
  final String? userRoleStatus;
  final int? userCredentialId;
  final String? mobile;
  final int? userDetailId;
  final int? userRoleId;
  final List<String>? userRole;
  final String? email;
  final String? sub;
  final int? iat;
  final int? exp;

  User({
    this.firstName,
    this.eventName,
    this.eventId,
    this.userStatus,
    this.userRoleStatus,
    this.userCredentialId,
    this.mobile,
    this.userDetailId,
    this.userRoleId,
    this.userRole,
    this.email,
    this.sub,
    this.iat,
    this.exp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] as String?,
      eventName: json['eventName'] as String?,
      eventId: json['eventId'] as int?,
      userStatus: json['userStatus'] as String?,
      userRoleStatus: json['userRoleStatus'] as String?,
      userCredentialId: json['userCredentialId'] as int?,
      mobile: json['mobile'] as String?,
      userDetailId: json['userDetailId'] as int?,
      userRoleId: json['userRoleId'] as int?,
      userRole: (json['userRole'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      email: json['email'] as String?,
      sub: json['sub'] as String?,
      iat: json['iat'] as int?,
      exp: json['exp'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'eventName': eventName,
      'eventId': eventId,
      'userStatus': userStatus,
      'userRoleStatus': userRoleStatus,
      'userCredentialId': userCredentialId,
      'mobile': mobile,
      'userDetailId': userDetailId,
      'userRoleId': userRoleId,
      'userRole': userRole,
      'email': email,
      'sub': sub,
      'iat': iat,
      'exp': exp,
    };
  }
}

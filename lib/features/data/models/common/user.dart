class User {
  String? email;
  String? name;
  String? role;
  String? phoneNumber;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.email,
        this.name,
        this.role,
        this.phoneNumber,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    role = json['role'];
    phoneNumber = json['phoneNumber'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['role'] = role;
    data['phoneNumber'] = phoneNumber;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
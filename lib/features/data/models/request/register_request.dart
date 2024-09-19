class RegisterRequest {
  String? email;
  String? password;
  String? confirmPassword;
  String? name;
  String? phoneNumber;
  String? role;

  RegisterRequest(
      {this.email,
        this.password,
        this.confirmPassword,
        this.name,
        this.phoneNumber,
        this.role});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    return data;
  }
}

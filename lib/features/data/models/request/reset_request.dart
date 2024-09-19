class ResetRequest {
  String? email;
  String? newPassword;
  String? resetToken;

  ResetRequest({this.email, this.newPassword, this.resetToken});

  ResetRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    newPassword = json['newPassword'];
    resetToken = json['resetToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['newPassword'] = newPassword;
    data['resetToken'] = resetToken;
    return data;
  }
}

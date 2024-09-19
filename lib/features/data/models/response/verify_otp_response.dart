class VerifyOtpResponse {
  bool? success;
  ResetToken? data;
  String? message;

  VerifyOtpResponse({this.success, this.data, this.message});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ResetToken.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ResetToken {
  String? resetToken;

  ResetToken({this.resetToken});

  ResetToken.fromJson(Map<String, dynamic> json) {
    resetToken = json['resetToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resetToken'] = resetToken;
    return data;
  }
}

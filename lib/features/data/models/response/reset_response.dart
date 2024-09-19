class ResetResponse {
  bool? success;
  dynamic data;
  String? message;

  ResetResponse({this.success, this.data, this.message});

  ResetResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}

class ScanResponse {
  String? statusCode;
  String? message;
  dynamic data;

  ScanResponse({this.statusCode, this.message, this.data});

  ScanResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}

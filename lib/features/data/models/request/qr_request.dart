class QrRequest {
  String? qrData;

  QrRequest({this.qrData});

  QrRequest.fromJson(Map<String, dynamic> json) {
    qrData = json['qrData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qrData'] = qrData;
    return data;
  }
}

class GetTicketHistory {
  String? statusCode;
  String? message;
  List<TicketDetails>? data;

  GetTicketHistory({this.statusCode, this.message, this.data});

  GetTicketHistory.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TicketDetails>[];
      json['data'].forEach((v) {
        data!.add(TicketDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketDetails {
  String? eventCategory;
  double? price;
  String? userName;
  String? scanTime;
  String? scanDate;
  String? ticketId;
  String? verifyId;
  String? eventName;

  TicketDetails(
      {this.eventCategory,
        this.price,
        this.userName,
        this.scanTime,
        this.scanDate,
        this.ticketId,
        this.verifyId,
        this.eventName});

  TicketDetails.fromJson(Map<String, dynamic> json) {
    eventCategory = json['eventCategory'];
    price = json['price'];
    userName = json['userName'];
    scanTime = json['scanTime'];
    scanDate = json['scanDate'];
    ticketId = json['ticketId'];
    verifyId = json['verifyId'];
    eventName = json['eventName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['eventCategory'] = eventCategory;
    data['price'] = price;
    data['userName'] = userName;
    data['scanTime'] = scanTime;
    data['scanDate'] = scanDate;
    data['ticketId'] = ticketId;
    data['verifyId'] = verifyId;
    data['eventName'] = eventName;
    return data;
  }
}

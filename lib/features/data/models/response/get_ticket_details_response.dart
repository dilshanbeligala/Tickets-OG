class GetTicketDetailsResponse {
  String? statusCode;
  String? message;
  TicketData? data;

  GetTicketDetailsResponse({this.statusCode, this.message, this.data});

  GetTicketDetailsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? TicketData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TicketData {
  List<TicketDetailDTOList>? ticketDetailDTOList;

  TicketData({this.ticketDetailDTOList});

  TicketData.fromJson(Map<String, dynamic> json) {
    if (json['ticketDetailDTOList'] != null) {
      ticketDetailDTOList = <TicketDetailDTOList>[];
      json['ticketDetailDTOList'].forEach((v) {
        ticketDetailDTOList!.add(TicketDetailDTOList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ticketDetailDTOList != null) {
      data['ticketDetailDTOList'] =
          ticketDetailDTOList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketDetailDTOList {
  String? ticketType;
  int? numberOfTickets;
  double? ticketPrice;
  int? purchaseTickets;
  int? onBordTicket;
  int? needToOnBordTicket;

  TicketDetailDTOList(
      {this.ticketType,
        this.numberOfTickets,
        this.ticketPrice,
        this.purchaseTickets,
        this.onBordTicket,
        this.needToOnBordTicket});

  TicketDetailDTOList.fromJson(Map<String, dynamic> json) {
    ticketType = json['ticketType'];
    numberOfTickets = json['numberOfTickets'];
    ticketPrice = json['ticketPrice'];
    purchaseTickets = json['purchaseTickets'];
    onBordTicket = json['onBordTicket'];
    needToOnBordTicket = json['needToOnBordTicket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketType'] = ticketType;
    data['numberOfTickets'] = numberOfTickets;
    data['ticketPrice'] = ticketPrice;
    data['purchaseTickets'] = purchaseTickets;
    data['onBordTicket'] = onBordTicket;
    data['needToOnBordTicket'] = needToOnBordTicket;
    return data;
  }
}

class GetTicketDetailsResponse {
  String? success;
  String? message;
  TicketData? data;

  GetTicketDetailsResponse({this.success, this.message, this.data});

  GetTicketDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? TicketData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TicketData {
  List<TicketDetailDTOList>? ticketDetailDTOList;
  PurchaseTickets? purchaseTickets;
  PurchaseTickets? onBordTicket;
  PurchaseTickets? needToOnBordTicket;

  TicketData(
      {this.ticketDetailDTOList,
        this.purchaseTickets,
        this.onBordTicket,
        this.needToOnBordTicket});

  TicketData.fromJson(Map<String, dynamic> json) {
    if (json['ticketDetailDTOList'] != null) {
      ticketDetailDTOList = <TicketDetailDTOList>[];
      json['ticketDetailDTOList'].forEach((v) {
        ticketDetailDTOList!.add(TicketDetailDTOList.fromJson(v));
      });
    }
    purchaseTickets = json['purchaseTickets'] != null
        ? PurchaseTickets.fromJson(json['purchaseTickets'])
        : null;
    onBordTicket = json['onBordTicket'] != null
        ? PurchaseTickets.fromJson(json['onBordTicket'])
        : null;
    needToOnBordTicket = json['needToOnBordTicket'] != null
        ? PurchaseTickets.fromJson(json['needToOnBordTicket'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ticketDetailDTOList != null) {
      data['ticketDetailDTOList'] =
          ticketDetailDTOList!.map((v) => v.toJson()).toList();
    }
    if (purchaseTickets != null) {
      data['purchaseTickets'] = purchaseTickets!.toJson();
    }
    if (onBordTicket != null) {
      data['onBordTicket'] = onBordTicket!.toJson();
    }
    if (needToOnBordTicket != null) {
      data['needToOnBordTicket'] = needToOnBordTicket!.toJson();
    }
    return data;
  }
}

class TicketDetailDTOList {
  String? ticketType;
  int? numberOfTickets;
  int? ticketPrice;

  TicketDetailDTOList(
      {this.ticketType, this.numberOfTickets, this.ticketPrice});

  TicketDetailDTOList.fromJson(Map<String, dynamic> json) {
    ticketType = json['ticketType'];
    numberOfTickets = json['numberOfTickets'];
    ticketPrice = json['ticketPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketType'] = ticketType;
    data['numberOfTickets'] = numberOfTickets;
    data['ticketPrice'] = ticketPrice;
    return data;
  }
}

class PurchaseTickets {
  int? vip;
  int? normal;

  PurchaseTickets({this.vip, this.normal});

  PurchaseTickets.fromJson(Map<String, dynamic> json) {
    vip = json['VIP'];
    normal = json['NORMAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['VIP'] = vip;
    data['NORMAL'] = normal;
    return data;
  }
}

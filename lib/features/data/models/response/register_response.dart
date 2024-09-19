

import 'package:tickets_og/features/data/models/common/common_barrel.dart';

class RegisterResponse {
  bool? success;
  User? data;
  String? message;

  RegisterResponse({this.success, this.data, this.message});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
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



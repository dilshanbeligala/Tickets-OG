import 'package:equatable/equatable.dart';

class ErrorResponseModel extends Equatable {
  final String? errorCode;
  final String? errorTitle;
  final String? errorDescription;

  const ErrorResponseModel({
    this.errorCode,
    this.errorTitle,
    this.errorDescription,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      errorCode: json['errorCode'],
      errorTitle: json['errorTitle'],
      errorDescription: json['errorDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errorCode': errorCode,
      'errorTitle': errorTitle,
      'errorDescription': errorDescription,
    };
  }

  @override
  List<Object?> get props => [errorCode, errorTitle, errorDescription];
}

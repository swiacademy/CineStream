class ValidationTokenModel {
  bool? success;
  String? expiresAt;
  String? requestToken;

  int? statusCode;
  String? statusMessage;

  ValidationTokenModel(
      {this.success,
      this.expiresAt,
      this.requestToken,
      this.statusCode,
      this.statusMessage});

  ValidationTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    expiresAt = json['expires_at'];
    requestToken = json['request_token'];
  }

  ValidationTokenModel.fromFailedJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['expires_at'] = expiresAt;
    data['request_token'] = requestToken;

    data['status_code'] = statusCode;
    data['status_message'] = statusMessage;
    return data;
  }
}

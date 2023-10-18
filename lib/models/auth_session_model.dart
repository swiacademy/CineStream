class AuthSessionModel {
  bool? success;
  String? sessionId;

  bool? failure;
  int? statusCode;
  String? statusMessage;

  AuthSessionModel(
      {this.success,
      this.sessionId,
      this.failure,
      this.statusCode,
      this.statusMessage});

  AuthSessionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    sessionId = json['session_id'];
  }

  AuthSessionModel.fromFailedJson(Map<String, dynamic> json) {
    success = json['success'];
    failure = json['failure'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['session_id'] = sessionId;

    data['failure'] = failure;
    data['status_code'] = statusCode;
    data['status_message'] = statusMessage;
    return data;
  }
}

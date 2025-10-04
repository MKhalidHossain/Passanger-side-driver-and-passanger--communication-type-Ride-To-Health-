class VerifyOtpResponseModel {
  final bool success;
  final String message;
  final VerifyOtpData? data;

  VerifyOtpResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? VerifyOtpData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class VerifyOtpData {
  final bool isPhoneVerified;
  final bool isEmailVerified;

  VerifyOtpData({
    required this.isPhoneVerified,
    required this.isEmailVerified,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpData(
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      isEmailVerified: json['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
    };
  }
}

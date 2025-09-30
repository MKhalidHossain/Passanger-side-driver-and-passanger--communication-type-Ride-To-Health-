class ResetPasswordWithOtpResponseModel {
  final bool success;
  final String message;

  ResetPasswordWithOtpResponseModel({
    required this.success,
    required this.message,
  });

  factory ResetPasswordWithOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordWithOtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}

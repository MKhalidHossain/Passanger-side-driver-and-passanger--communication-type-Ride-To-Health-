class RequestPasswordResetResponseModel {
  final bool success;
  final String message;

  RequestPasswordResetResponseModel({
    required this.success,
    required this.message,
  });

  factory RequestPasswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    return RequestPasswordResetResponseModel(
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

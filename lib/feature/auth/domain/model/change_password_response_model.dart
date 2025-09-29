class ChangePasswordResponseModel {
  final bool success;
  final String message;

  ChangePasswordResponseModel({required this.success, required this.message});

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message};
  }
}

class UpdateLocationResponseModel {
  final bool ?success;
  final String? message;

  UpdateLocationResponseModel({
     this.success,
     this.message,
  });

  factory UpdateLocationResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateLocationResponseModel(
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

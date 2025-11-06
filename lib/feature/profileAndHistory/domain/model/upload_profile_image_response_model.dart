// upload_profile_image_response_model.dart

class UploadProfileImageResponseModel {
  final bool ?success;
  final String? message;
  final UploadProfileImageData? data;

  UploadProfileImageResponseModel({
     this.success,
     this.message,
    this.data,
  });

  factory UploadProfileImageResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadProfileImageResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? UploadProfileImageData.fromJson(json['data'])
          : null,
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

class UploadProfileImageData {
  final String profileImage;

  UploadProfileImageData({required this.profileImage});

  factory UploadProfileImageData.fromJson(Map<String, dynamic> json) {
    return UploadProfileImageData(
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profileImage': profileImage,
    };
  }
}

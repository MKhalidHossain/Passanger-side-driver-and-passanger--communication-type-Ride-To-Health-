class DeleteSavedPlaceResponseModel {
  final bool ?success;
  final String? message;

  DeleteSavedPlaceResponseModel({
     this.success,
     this.message,
  });

  factory DeleteSavedPlaceResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteSavedPlaceResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
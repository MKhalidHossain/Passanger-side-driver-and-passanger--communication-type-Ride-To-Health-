class LogInResponseModel {
  final bool? success;
  final String? message;
  final Data? data;

  LogInResponseModel({this.success, this.message, this.data});

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) {
    return LogInResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class Data {
  final String? accessToken;
  final String? refreshToken;
  final User? user;

  Data({this.accessToken, this.refreshToken, this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accessToken: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': accessToken,
      'refreshToken': refreshToken,
      'user': user?.toJson(),
    };
  }
}

class User {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? profileImage;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;

  User({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.role,
    this.profileImage,
    this.isEmailVerified,
    this.isPhoneVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
      profileImage: json['profileImage'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'profileImage': profileImage,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
    };
  }
}

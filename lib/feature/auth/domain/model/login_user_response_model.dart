class LogInResponseModel {
  final bool success;
  final String message;
  final LogInData? data;

  LogInResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) {
    return LogInResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LogInData.fromJson(json['data']) : null,
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

class LogInData {
  final String token;
  final User user;

  LogInData({
    required this.token,
    required this.user,
  });

  factory LogInData.fromJson(Map<String, dynamic> json) {
    return LogInData(
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final String? profileImage;
  final bool isEmailVerified;
  final bool isPhoneVerified;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.profileImage,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'],
      isEmailVerified: json['isEmailVerified'] ?? false,
      isPhoneVerified: json['isPhoneVerified'] ?? false,
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

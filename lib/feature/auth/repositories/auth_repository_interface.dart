abstract class AuthRepositoryInterface {
  Future<dynamic> register(
    String fullName,
    String email,
    String phoneNumber,
    String password,
    String role,
  );
  Future<dynamic> login(String emailOrPhone, String password);
  Future<dynamic> verifyOtpPhone(String userId, String otp, String type);
  Future<dynamic> requestPasswordReset(String? emailOrPhone);
  Future<dynamic> resetPasswordWithOtp(
    String emailOrPhone,
    String otp,
    String newPassword,
  );
  Future<dynamic> changePassword(String currentPassword, String newPassword);

  Future<dynamic> accessAndRefreshToken(String refreshToken);




  Future<dynamic> logout();

  bool isLoggedIn();
  Future<bool> clearUserCredentials();
  bool clearSharedAddress();
  String getUserToken();

  Future<dynamic> updateToken();
  Future<bool?> saveUserToken(String token, String refreshToken);
  Future<dynamic> updateAccessAndRefreshToken();

  bool isFirstTimeInstall();
  void setFirstTimeInstall();
}

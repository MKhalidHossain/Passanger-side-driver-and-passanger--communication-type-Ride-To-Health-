import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/urls.dart';
import '../../../helpers/remote/data/api_client.dart';
import '../../../utils/app_constants.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements AuthRepositoryInterface {
  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;
  AuthRepository({required this.apiClient, required this.sharedPreferences});

  @override
  Future accessAndRefreshToken(Pattern refreshToken) {
    // TODO: implement accessAndRefreshToken
    throw UnimplementedError();
  }

  @override
  Future changePassword(String currentPassword, String newPassword) async {
    return await apiClient.postData(Urls.changePassword, {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
  }

  @override
  bool clearSharedAddress() {
    // TODO: implement clearSharedAddress
    throw UnimplementedError();
  }

  @override
  Future<bool> clearUserCredentials() {
    return sharedPreferences.remove(AppConstants.token);
  }

  @override
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? '';
  }

  @override
  bool isFirstTimeInstall() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  @override
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  @override
  Future login(String emailOrPhone, String password) async {
    return await apiClient.postData(Urls.login, {
      'emailOrPhone': emailOrPhone,
      'password': password,
    });
  }

  @override
  Future logout() async {
    return await apiClient.postData(Urls.logOut, {});
  }

  @override
  Future register(
    String fullName,
    String email,
    String phoneNumber,
    String password,
    String role,
  ) async {
    return await apiClient.postData(Urls.register, {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'role': role,
    });
  }

  @override
  Future requestPasswordReset(String? emailOrPhone) async {
    return await apiClient.postData(Urls.requestPasswordReset, {
      'emailOrPhone': emailOrPhone,
    });
  }

  @override
  Future resetPassword(
    String email,
    String newPassword,
    String repeatNewPassword,
  ) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future resetPasswordWithOtp(
    String emailOrPhone,
    String otp,
    String newPassword,
  ) async {
    return await apiClient.postData(Urls.resetPasswordWithOtp, {
      'emailOrPhone': emailOrPhone,
      'otp': otp,
      'newPassword': newPassword,
    });
  }

  @override
  Future<bool?> saveUserToken(String token, String refreshToken) async {
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  @override
  void setFirstTimeInstall() {
    sharedPreferences.setBool('firstTimeInstall', true);
  }

  @override
  Future updateAccessAndRefreshToken() async {
    return await apiClient.postData(Urls.refreshAccessToken, {
      'refreshToken': sharedPreferences.getString(AppConstants.refreshToken),
    });
  }

  @override
  Future updateToken() {
    // TODO: implement updateToken
    throw UnimplementedError();
  }

  @override
  Future verifyOtpPhone(String userId, String otp, String type) async {
    return await apiClient.postData(Urls.verifyOtpPhone, {
      'userId': userId,
      'otp': otp,
      'type': type,
    });
  }
}

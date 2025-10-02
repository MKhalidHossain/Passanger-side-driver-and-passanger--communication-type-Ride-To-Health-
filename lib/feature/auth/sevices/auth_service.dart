import '../repositories/auth_repository_interface.dart';
import 'auth_service_interface.dart';

class AuthService implements AuthServiceInterface {
  final AuthRepositoryInterface authRepositoryInterface;

  AuthService(this.authRepositoryInterface);
  
  @override
  Future accessAndRefreshToken(String refreshToken) async{
    return await authRepositoryInterface.accessAndRefreshToken(refreshToken);
  }
  
  @override
  Future changePassword(String currentPassword, String newPassword) async{
    return await authRepositoryInterface.changePassword(currentPassword, newPassword);
  }
  
  @override
  bool clearSharedAddress() {
    return authRepositoryInterface.clearSharedAddress();
  }
  
  @override
  Future<bool> clearUserCredentials() async{
    return await authRepositoryInterface.clearUserCredentials();
  }
  
  @override
  String getUserToken() {
    return authRepositoryInterface.getUserToken();
  }
  
  @override
  bool isFirstTimeInstall() {
    return authRepositoryInterface.isFirstTimeInstall();
  }
  
  @override
  bool isLoggedIn() {
    return authRepositoryInterface.isLoggedIn();
  }

  @override
  Future saveLogin(String token) {
    return authRepositoryInterface.saveLogin(token);
  }
  
  @override
  Future login(String emailOrPhone, String password) async{
    return await authRepositoryInterface.login(emailOrPhone, password);
  }
  
  @override
  Future logout() async{
    return await authRepositoryInterface.logout();
  }
  
  @override
  Future register(String fullName, String email, String phoneNumber, String password, String role) async{
    return await authRepositoryInterface.register(fullName, email, phoneNumber, password, role);
  }
  
  @override
  Future requestPasswordReset(String? emailOrPhone) async{
    return await authRepositoryInterface.requestPasswordReset(emailOrPhone);
  }
  

  
  @override
  Future resetPasswordWithOtp(String emailOrPhone, String otp, String newPassword) async{
    return await authRepositoryInterface.resetPasswordWithOtp(emailOrPhone, otp, newPassword);
  }
  
  @override
  Future<bool?> saveUserToken(String token, String refreshToken) async{
    return await authRepositoryInterface.saveUserToken(token, refreshToken);
  }
  
 
  
  @override
  void setFirstTimeInstall() {
    authRepositoryInterface.setFirstTimeInstall();
  }
  
  @override
  Future updateAccessAndRefreshToken() async{
    return await authRepositoryInterface.updateAccessAndRefreshToken();
  }
  
  @override
  Future updateToken() async{
    return await authRepositoryInterface.updateToken();
  }
  
  @override
  Future verifyOtpPhone(String userId, String otp, String type) async{
    return await authRepositoryInterface.verifyOtpPhone(userId, otp, type);
  }

}

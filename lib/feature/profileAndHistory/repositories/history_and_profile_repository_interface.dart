import 'package:get/get_connect/http/src/response/response.dart';
import 'package:rideztohealth/feature/profileAndHistory/domain/request_model/update_profile_request_model.dart';

abstract class HistoryAndProfileRepositoryInterface {
  Future<Response> getProfile();
  Future<Response> updateProfile(String fullName, String email);
  Future<Response> updateProfileImage(String image);
  Future<Response> updateLocation(String latitude, String longitude, String address);
  Future<Response> updateUserProfile(UpdateProfileRequestModel requestModel);
}

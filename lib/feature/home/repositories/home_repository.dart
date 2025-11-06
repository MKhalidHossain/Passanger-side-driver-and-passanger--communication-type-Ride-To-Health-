import 'package:get/get_connect/http/src/response/response.dart';
import 'package:rideztohealth/feature/home/repositories/home_repository_interface.dart';
import 'package:rideztohealth/helpers/remote/data/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/urls.dart';

class HomeRepository implements HomeRepositoryInterface{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  HomeRepository(this.apiClient, this.sharedPreferences);

  @override
  Future<Response> getRecentTrips() {
    // TODO: implement getRecentTrips
    throw UnimplementedError();
  }
  
  @override
  Future<Response> allCategories() async{
    return await apiClient.getData(Urls.allCategories);
  }
  
  @override
  Future<Response> getACategory() {
    return apiClient.getData(Urls.getACategory);
  }
}
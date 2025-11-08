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
  Future<Response> getACategory() async{
    return await apiClient.getData(Urls.getACategory);
  }
  
  @override
  Future<Response> addSavedPlaces(String name , String addresss, double latitude, double longitude, String type) async{
    return await apiClient.postData(Urls.addSavedPlace,{
      {
      "name": name,
      "address": addresss,
      "latitude": latitude,
      "longitude": longitude,
      "type": type
      }
    });
  }
  
  @override
  Future<Response> deleteSavedPlaces(String placeId) async{
    return await apiClient.deleteData(Urls.deleteSavedPlace + placeId);
  }
  
  @override
  Future<Response> getSavedPlaces() async{
    return await apiClient.getData(Urls.getSavedPlaces);
  }
}
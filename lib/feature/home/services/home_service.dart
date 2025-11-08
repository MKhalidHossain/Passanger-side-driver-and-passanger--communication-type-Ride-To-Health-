import 'package:get/get_connect/http/src/response/response.dart';

import '../repositories/home_repository_interface.dart';
import 'home_service_interface.dart';

class HomeService implements HomeServiceInterface{
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeService(this.homeRepositoryInterface);
  @override
  Future<Response> getRecentTrips() {
    // TODO: implement getRecentTrips
    throw UnimplementedError();
  }
  
  @override
  Future<Response> allCategories() async{
    return await homeRepositoryInterface.allCategories();
  }
  
  @override
  Future<Response> getACategory() async{
    return await homeRepositoryInterface.getACategory();
  }
  
  @override
  Future<Response> addSavedPlaces(String name , String addresss, double latitude, double longitude, String type) async{
    return await homeRepositoryInterface.addSavedPlaces( name ,  addresss,  latitude,  longitude,  type);
  }
  
  @override
  Future<Response> deleteSavedPlaces(String placeId) async{
   return await homeRepositoryInterface.deleteSavedPlaces(placeId);
  }
  
  @override
  Future<Response> getSavedPlaces() async{
    return await homeRepositoryInterface.getSavedPlaces();
  }
}
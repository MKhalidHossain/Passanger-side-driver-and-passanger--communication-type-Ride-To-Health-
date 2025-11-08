import 'package:get/get_connect/http/src/response/response.dart';

abstract class HomeServiceInterface {
  Future<Response> getRecentTrips();
  Future<Response> allCategories();
  Future<Response> getACategory();

  // Saved Places
  Future<Response> addSavedPlaces(String name , String addresss, double latitude, double longitude, String type);
  Future<Response> getSavedPlaces();
  Future<Response> deleteSavedPlaces(String placeId);
}
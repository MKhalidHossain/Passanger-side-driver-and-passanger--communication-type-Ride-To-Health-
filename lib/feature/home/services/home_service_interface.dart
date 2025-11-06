import 'package:get/get_connect/http/src/response/response.dart';

abstract class HomeServiceInterface {
  Future<Response> getRecentTrips();
  Future<Response> allCategories();
  Future<Response> getACategory();
}
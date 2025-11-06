import 'package:get/get_connect/http/src/response/response.dart';

abstract class HomeRepositoryInterface {
  Future<Response> getRecentTrips();
}
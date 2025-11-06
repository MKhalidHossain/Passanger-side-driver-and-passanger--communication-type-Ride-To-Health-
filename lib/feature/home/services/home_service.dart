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
}
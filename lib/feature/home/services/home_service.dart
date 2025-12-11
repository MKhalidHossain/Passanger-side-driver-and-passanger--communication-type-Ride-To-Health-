import 'package:get/get_connect/http/src/response/response.dart';
import 'package:rideztohealth/feature/payment/domain/create_payment_request_model.dart';

import '../repositories/home_repository_interface.dart';
import '../domain/request_model/ride_booking_info_request_model.dart';
import 'home_service_interface.dart';

class HomeService implements HomeServiceInterface{
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeService(this.homeRepositoryInterface);

  
  @override
  Future<Response> getAllServices() async{
    return await homeRepositoryInterface.getAllServices();
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


    @override
  Future<Response> getRecentTrips() async{
    return await homeRepositoryInterface.getRecentTrips();
  }
  
  @override
  Future<Response> getSearchDestinationForFindNearestDrivers(String latitude, String longitude) async{
    return await homeRepositoryInterface.getSearchDestinationForFindNearestDrivers(latitude, longitude);
  }

    @override
  Future<Response<dynamic>> createPayment(CreatePaymentRequestModel requestModel)async {
    return await homeRepositoryInterface.createPayment(requestModel);
  }

  @override
  Future<Response> requestRide(RideBookingInfo requestModel) async {
    return await homeRepositoryInterface.requestRide(requestModel);
  }
}

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:rideztohealth/feature/payment/domain/create_payment_request_model.dart';
import '../domain/request_model/ride_booking_info_request_model.dart';

abstract class HomeServiceInterface {

  Future<Response> getAllServices();
  Future<Response> getACategory();

  // Saved Places
  Future<Response> addSavedPlaces(String name , String addresss, double latitude, double longitude, String type);
  Future<Response> getSavedPlaces();
  Future<Response> deleteSavedPlaces(String placeId);


  Future<Response> getRecentTrips();

  Future<Response> getSearchDestinationForFindNearestDrivers(String latitude, String longitude);
  Future<Response> createPayment(CreatePaymentRequestModel requestModel);
  Future<Response> requestRide(RideBookingInfo requestModel);
}

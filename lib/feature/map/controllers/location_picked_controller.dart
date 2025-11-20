import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../domain/models/place_prediction.dart';
import '../service/location_service_interface.dart';

class LocationPickedController extends GetxController implements GetxService{
  final LocationServiceInterface locationServiceInterface = Get.find<LocationServiceInterface>();
  
 
  bool isLoading = false;

  RxList<PlacePrediction> autoCompliteSuggetion = RxList<PlacePrediction>();




   Future<void> searchChanged(String query) async {
    try {
      isLoading = true;
      update();

      final response = await locationServiceInterface
          .searchPlaces(query: query);
          autoCompliteSuggetion.value = response;

    } catch (e) {
      print("⚠️ Error from Location Picked Controller : searchChanged : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }
}
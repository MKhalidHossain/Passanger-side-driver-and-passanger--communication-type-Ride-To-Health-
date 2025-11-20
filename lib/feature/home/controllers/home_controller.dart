import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rideztohealth/feature/home/domain/reponse_model/add_saved_place_response_model.dart';
import 'package:rideztohealth/feature/home/domain/reponse_model/delete_saved_place_response_model.dart';
import 'package:rideztohealth/feature/home/domain/reponse_model/get_all_services_response_model.dart';
import '../../../core/constants/urls.dart';
import '../domain/reponse_model/get_a_category_response_model.dart';
import '../domain/reponse_model/get_recent_trips_response_model.dart';
import '../domain/reponse_model/get_saved_places_response_model.dart';
import '../services/home_service_interface.dart';


class HomeController extends GetxController implements GetxService {
  // final localHomeController = Get.find<LocalHomeController>();

  final HomeServiceInterface homeServiceInterface;

  HomeController(this.homeServiceInterface);

  GetAllServicesResponseModel getAllCategoryResponseModel =
      GetAllServicesResponseModel();
  GetACategoryResponseModel getACategoryResponseModel =
      GetACategoryResponseModel();

  AddSavedPlacesResponseModel addSavedPlacesResponseModel =
      AddSavedPlacesResponseModel();
  GetSavedPlacesResponseModel getSavedPlacesResponseModel =
      GetSavedPlacesResponseModel();
  DeleteSavedPlaceResponseModel deleteSavedPlaceResponseModel = 
      DeleteSavedPlaceResponseModel();

  GetRecentTripsResponseModel getRecentTripsResponseModel = 
      GetRecentTripsResponseModel();


  bool isLoading = false;


Future<void> getAllServices() async {
  try {
    isLoading = true;
    update();

    final response = await homeServiceInterface.getAllServices();

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("✅ getAllServices: Categories fetched successfully.");
       // Ensure response.body is a Map before passing to fromJson
      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      getAllCategoryResponseModel = GetAllServicesResponseModel.fromJson(response.body);

      isLoading = false;
      update();
    } else {
        getAllCategoryResponseModel = GetAllServicesResponseModel.fromJson(response.body);
    }
  } catch (e) {
    print("⚠️ Error fetching profile : getAllServices : $e\n");
  } finally {
    isLoading = false;
    update();
  }
}

Future<void> addSavedPlaces(String name , String addresss, double latitude, double longitude, String type) async {
  try {
    isLoading = true;
    update();

    final response = await homeServiceInterface.addSavedPlaces(name, addresss , latitude , longitude , type);

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("✅ addSavedPlaces: HomeController fetched successfully.");
       // Ensure response.body is a Map before passing to fromJson
      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      addSavedPlacesResponseModel = AddSavedPlacesResponseModel.fromJson(response.body);

      isLoading = false;
      update();
    } else {
        addSavedPlacesResponseModel = AddSavedPlacesResponseModel.fromJson(response.body);
    }
  } catch (e) {
    print("⚠️ Error fetching HomeController : addSavedPlaces : $e\n");
  } finally {
    isLoading = false;
    update();
  }
}


Future<void> getSavedPlaces() async {
  try {
    isLoading = true;
    update();

    final response = await homeServiceInterface.getSavedPlaces();

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("✅ getSavedPlaces: HomeController fetched successfully.");
       // Ensure response.body is a Map before passing to fromJson
      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      getSavedPlacesResponseModel = GetSavedPlacesResponseModel.fromJson(response.body);

      isLoading = false;
      update();
    } else {
        getSavedPlacesResponseModel = GetSavedPlacesResponseModel.fromJson(response.body);
    }
  } catch (e) {
    print("⚠️ Error fetching HomeController : getSavedPlaces : $e\n");
  } finally {
    isLoading = false;
    update();
  }
}


Future<void> deleteSavedPlaces(String placeId) async {
  try {
    isLoading = true;
    update();

    final response = await homeServiceInterface.deleteSavedPlaces(placeId);

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("✅ deleteSavedPlaces: HomeController fetched successfully.");
       // Ensure response.body is a Map before passing to fromJson
      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      deleteSavedPlaceResponseModel = DeleteSavedPlaceResponseModel.fromJson(response.body);

      isLoading = false;
      update();
    } else {
        deleteSavedPlaceResponseModel = DeleteSavedPlaceResponseModel.fromJson(response.body);
    }
  } catch (e) {
    print("⚠️ Error fetching HomeController : deleteSavedPlaces : $e\n");
  } finally {
    isLoading = false;
    update();
  }
}

Future<void> getRecentTrips() async {
  try {
    isLoading = true;
    update();

    final response = await homeServiceInterface.getRecentTrips();

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("✅ getRecentTrips: HomeController fetched successfully.");
       // Ensure response.body is a Map before passing to fromJson
      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      getRecentTripsResponseModel = GetRecentTripsResponseModel.fromJson(response.body);

      isLoading = false;
      update();
    } else {
      getRecentTripsResponseModel = GetRecentTripsResponseModel.fromJson(response.body);
    }
  } catch (e) {
    print("⚠️ Error fetching HomeController : getRecentTrips : $e\n");
  } finally {
    isLoading = false;
    update();
  }
}


}


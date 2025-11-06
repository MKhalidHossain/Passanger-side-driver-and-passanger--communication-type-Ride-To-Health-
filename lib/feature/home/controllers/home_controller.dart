import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rideztohealth/feature/home/domain/reponse_model/get_all_category_response_model.dart';

import '../../../core/constants/urls.dart';
import '../services/home_service_interface.dart';


class HomeController extends GetxController implements GetxService {
  // final localHomeController = Get.find<LocalHomeController>();

  final HomeServiceInterface homeServiceInterface;

  HomeController(this.homeServiceInterface);

  GetAllCategoryResponseModel getAllCategoryResponseModel =
      GetAllCategoryResponseModel();
  GetAllCategoryResponseModel getAllSubCategoryResponseModel =
      GetAllCategoryResponseModel();


  bool isLoading = false;


Future<void> getAllCategory() async {
  try {
    isLoading = true;
    update();

    final response = await homeServiceInterface.allCategories();

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("✅ getAllCategory: Categories fetched successfully.");
       // Ensure response.body is a Map before passing to fromJson
      // final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      getAllCategoryResponseModel = GetAllCategoryResponseModel.fromJson(response.body);

      isLoading = false;
      update();
    } else {
        getAllCategoryResponseModel = GetAllCategoryResponseModel.fromJson(response.body);
    }
  } catch (e, stackTrace) {
    print("⚠️ Error fetching profile : getAllCategory : $e\n");
  } finally {
    isLoading = false;
    update();
  }
}

}


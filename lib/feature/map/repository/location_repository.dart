import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rideztohealth/core/constants/app_constant.dart';
import 'package:rideztohealth/feature/map/domain/models/place_prediction.dart';
import 'package:rideztohealth/feature/map/presentation/screens/location_confirmation_screen.dart';
import 'package:rideztohealth/feature/map/service/location_service_interface.dart';
import 'package:rideztohealth/helpers/remote/data/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location_repository_interface.dart';

class LocationRepository implements LocationRepositoryInterface{

 final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

LocationRepository(this.apiClient, this.sharedPreferences);
  @override
  Future<List<PlacePrediction>> searchPlaces({required String query}) async {

  final url = Uri.parse(
    "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    "?input=$query"
    "&key=${AppConstant.apiKey}"
  );

  final response = await http.get(url);

  // debugPrint("Autocomplete Response: ${response.body}");

  final data = jsonDecode(response.body);

  if (data["status"] != "OK") {
    debugPrint("Places API Error: ${data['status']}");
    return [];
  }

  final predictions = List<Map<String, dynamic>>.from(data['predictions']);

  return predictions.map((e) => PlacePrediction.fromPlacesLegacyApiResponse(e)).toList();
}

} 
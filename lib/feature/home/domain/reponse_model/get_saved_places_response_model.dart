import 'dart:convert';

class GetSavedPlacesResponseModel {
  bool ?success;
  List<SavedPlace> ?data;

  GetSavedPlacesResponseModel({
     this.success,
     this.data,
  });

  factory GetSavedPlacesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSavedPlacesResponseModel(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((item) => SavedPlace.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data!.map((item) => item.toJson()).toList(),
    };
  }

  static GetSavedPlacesResponseModel fromJsonString(String jsonString) {
    return GetSavedPlacesResponseModel.fromJson(json.decode(jsonString));
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}

class SavedPlace {
  String name;
  String address;
  List<double> coordinates;
  String type;
  String id;

  SavedPlace({
    required this.name,
    required this.address,
    required this.coordinates,
    required this.type,
    required this.id,
  });

  factory SavedPlace.fromJson(Map<String, dynamic> json) {
    return SavedPlace(
      name: json['name'] as String,
      address: json['address'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((item) => item as double)
          .toList(),
      type: json['type'] as String,
      id: json['_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'coordinates': coordinates,
      'type': type,
      '_id': id,
    };
  }
}
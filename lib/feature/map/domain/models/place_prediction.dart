class PlacePrediction {
  final String description;
  final String placeId;
  final String mainText;
  final String secondaryText;

  PlacePrediction({
    required this.description,
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    final struct = json['structured_formatting'] ?? {};

    return PlacePrediction(
      description: json['description'] ?? '',
      placeId: json['place_id'] ?? '',
      mainText: struct['main_text'] ?? (json['description'] ?? ''),
      secondaryText: struct['secondary_text'] ?? '',
    );
  }
}


// class PlacePrediction {
//   final String placeId;
//   final String description;

//   PlacePrediction({required this.placeId, required this.description});

//   factory PlacePrediction.fromPlacesNewApiResponse(Map<String, dynamic> json) {
//     return PlacePrediction(
//       placeId: json["placePrediction"]['placeId'] as String,
//       description: json["placePrediction"]['text']['text'] as String,
//     );
//   }

//   factory PlacePrediction.fromPlacesLegacyApiResponse(Map<String, dynamic> json) {
//     return PlacePrediction(
//       placeId: json['place_id'] as String,
//       description: json['description'] as String,
//     );
//   }


// }
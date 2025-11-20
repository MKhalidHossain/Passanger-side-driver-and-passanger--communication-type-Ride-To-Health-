class PlacePrediction {
  final String placeId;
  final String description;

  PlacePrediction({required this.placeId, required this.description});

  factory PlacePrediction.fromPlacesNewApiResponse(Map<String, dynamic> json) {
    return PlacePrediction(
      placeId: json["placePrediction"]['placeId'] as String,
      description: json["placePrediction"]['text']['text'] as String,
    );
  }

  factory PlacePrediction.fromPlacesLegacyApiResponse(Map<String, dynamic> json) {
    return PlacePrediction(
      placeId: json['place_id'] as String,
      description: json['description'] as String,
    );
  }
}
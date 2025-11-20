class PlacePrediction {
  final String placeId;
  final String description;

  PlacePrediction({required this.placeId, required this.description});

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
      placeId: json["placePrediction"]['placeId'] as String,
      description: json["placePrediction"]['text']['text'] as String,
    );
  }
}
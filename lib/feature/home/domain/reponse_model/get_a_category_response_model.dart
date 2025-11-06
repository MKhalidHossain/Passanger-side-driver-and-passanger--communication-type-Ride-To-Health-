class GetACategoryResponseModel {
  final bool success;
  final CategoryData? data;

  GetACategoryResponseModel({
    required this.success,
    this.data,
  });

  factory GetACategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return GetACategoryResponseModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? CategoryData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class CategoryData {
  final String? id;
  final String? name;
  final String? categoryImage;
  final int? v;

  CategoryData({
    this.id,
    this.name,
    this.categoryImage,
    this.v,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      categoryImage: json['categoryImage'] as String?,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'categoryImage': categoryImage,
      '__v': v,
    };
  }
}

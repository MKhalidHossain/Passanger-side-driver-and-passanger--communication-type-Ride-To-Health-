class GetAllCategoryResponseModel {
  final bool ?success;
  final CategoryData? data;

  GetAllCategoryResponseModel({
     this.success,
    this.data,
  });

  factory GetAllCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return GetAllCategoryResponseModel(
      success: json['success'] ?? false,
      data: (json['data'] is Map<String, dynamic>)
    ? CategoryData.fromJson(json['data'])
    : null,

    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };
}

class CategoryData {
  final List<Category>? categories;
  final Pagination? pagination;

  CategoryData({
    this.categories,
    this.pagination,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'categories': categories?.map((e) => e.toJson()).toList(),
        'pagination': pagination?.toJson(),
      };
}

class Category {
  final String? id;
  final String? name;
  final String? categoryImage;
  final int? v;

  Category({
    this.id,
    this.name,
    this.categoryImage,
    this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      categoryImage: json['categoryImage'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'categoryImage': categoryImage,
        '__v': v,
      };
}

class Pagination {
  final int? current;
  final int? pages;
  final int? total;

  Pagination({
    this.current,
    this.pages,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      current: json['current'],
      pages: json['pages'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
        'current': current,
        'pages': pages,
        'total': total,
      };
}

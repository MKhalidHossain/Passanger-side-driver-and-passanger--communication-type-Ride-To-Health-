class GetRecentTripsResponseModel {
  final bool? success;
  final TripsData? data;

  GetRecentTripsResponseModel({this.success, this.data});

  factory GetRecentTripsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetRecentTripsResponseModel(
      success: json['success'],
      data: json['data'] != null ? TripsData.fromJson(json['data']) : null,
    );
  }
}

class TripsData {
  final List<Ride>? rides;
  final Pagination? pagination;

  TripsData({this.rides, this.pagination});

  factory TripsData.fromJson(Map<String, dynamic> json) {
    return TripsData(
      rides: json['rides'] != null
          ? List<Ride>.from(json['rides'].map((x) => Ride.fromJson(x)))
          : null,
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class Ride {
  final Location? pickupLocation;
  final Location? dropoffLocation;
  final PromoCode? promoCode;
  final String? id;
  final String? customerId;
  final String? driverId;
  final String? serviceId;
  final double? estimatedDistance;
  final double? estimatedFare;
  final int? estimatedDuration;
  final double? actualDistance;
  final int? actualDuration;
  final double? finalFare;
  final String? status;
  final String? paymentMethod;
  final String? paymentStatus;
  final List<Timeline>? timeline;
  final String? createdAt;
  final int? v;

  Ride({
    this.pickupLocation,
    this.dropoffLocation,
    this.promoCode,
    this.id,
    this.customerId,
    this.driverId,
    this.serviceId,
    this.estimatedDistance,
    this.estimatedDuration,
    this.estimatedFare,
    this.actualDistance,
    this.actualDuration,
    this.finalFare,
    this.status,
    this.paymentMethod,
    this.paymentStatus,
    this.timeline,
    this.createdAt,
    this.v,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      pickupLocation: json['pickupLocation'] != null
          ? Location.fromJson(json['pickupLocation'])
          : null,
      dropoffLocation: json['dropoffLocation'] != null
          ? Location.fromJson(json['dropoffLocation'])
          : null,
      promoCode: json['promoCode'] != null
          ? PromoCode.fromJson(json['promoCode'])
          : null,
      id: json['_id'],
      customerId: json['customerId'],
      driverId: json['driverId'],
      serviceId: json['serviceId'],
      estimatedDistance:
          json['estimatedDistance']?.toDouble(),
      estimatedDuration: json['estimatedDuration'],
      estimatedFare: json['estimatedFare']?.toDouble(),
      actualDistance: json['actualDistance']?.toDouble(),
      actualDuration: json['actualDuration'],
      finalFare: json['finalFare']?.toDouble(),
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      timeline: json['timeline'] != null
          ? List<Timeline>.from(
              json['timeline'].map((x) => Timeline.fromJson(x)))
          : [],
      createdAt: json['createdAt'],
      v: json['__v'],
    );
  }
}

class Location {
  final List<double>? coordinates;
  final String? address;
  final String? type;

  Location({this.coordinates, this.address, this.type});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
          : null,
      address: json['address'],
      type: json['type'],
    );
  }
}

class PromoCode {
  final String? code;
  final double? discount;

  PromoCode({this.code, this.discount});

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    return PromoCode(
      code: json['code'],
      discount: json['discount']?.toDouble(),
    );
  }
}

class Timeline {
  final String? id;
  final String? status;
  final String? timestamp;

  Timeline({this.id, this.status, this.timestamp});

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      id: json['_id'],
      status: json['status'],
      timestamp: json['timestamp'],
    );
  }
}

class Pagination {
  final int? current;
  final int? pages;
  final int? total;

  Pagination({this.current, this.pages, this.total});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      current: json['current'],
      pages: json['pages'],
      total: json['total'],
    );
  }
}

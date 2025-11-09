class GetRecentTripsResponseModel {
  final bool? success;
  final TripData? data;

  GetRecentTripsResponseModel({
    this.success,
    this.data,
  });

  factory GetRecentTripsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetRecentTripsResponseModel(
      success: json['success'],
      data: json['data'] != null ? TripData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class TripData {
  final List<Ride>? rides;
  final Pagination? pagination;

  TripData({
    this.rides,
    this.pagination,
  });

  factory TripData.fromJson(Map<String, dynamic> json) {
    return TripData(
      rides: json['rides'] != null
          ? List<Ride>.from(json['rides'].map((x) => Ride.fromJson(x)))
          : [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rides': rides?.map((x) => x.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class Ride {
  final Location? pickupLocation;
  final Location? dropoffLocation;
  final PromoCode? promoCode;
  final Commission? commission;
  final String? id;
  final String? customerId;
  final String? driverId;
  final String? stripeCustomerId;
  final ServiceId? serviceId;
  final double? estimatedDistance;
  final double? estimatedDuration;
  final double? estimatedFare;
  final double? actualDistance;
  final double? actualDuration;
  final double? finalFare;
  final String? status;
  final String? paymentMethod;
  final String? paymentStatus;
  final List<dynamic>? route;
  final List<dynamic>? timeline;
  final String? createdAt;
  final int? v;

  Ride({
    this.pickupLocation,
    this.dropoffLocation,
    this.promoCode,
    this.commission,
    this.id,
    this.customerId,
    this.driverId,
    this.stripeCustomerId,
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
    this.route,
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
      commission: json['commission'] != null
          ? Commission.fromJson(json['commission'])
          : null,
      id: json['_id'],
      customerId: json['customerId'],
      driverId: json['driverId'],
      stripeCustomerId: json['stripeCustomerId'],
      serviceId: json['serviceId'] != null
          ? ServiceId.fromJson(json['serviceId'])
          : null,
      estimatedDistance:
          (json['estimatedDistance'] as num?)?.toDouble(),
      estimatedDuration:
          (json['estimatedDuration'] as num?)?.toDouble(),
      estimatedFare: (json['estimatedFare'] as num?)?.toDouble(),
      actualDistance: (json['actualDistance'] as num?)?.toDouble(),
      actualDuration: (json['actualDuration'] as num?)?.toDouble(),
      finalFare: (json['finalFare'] as num?)?.toDouble(),
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      route: json['route'] ?? [],
      timeline: json['timeline'] ?? [],
      createdAt: json['createdAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pickupLocation': pickupLocation?.toJson(),
      'dropoffLocation': dropoffLocation?.toJson(),
      'promoCode': promoCode?.toJson(),
      'commission': commission?.toJson(),
      '_id': id,
      'customerId': customerId,
      'driverId': driverId,
      'stripeCustomerId': stripeCustomerId,
      'serviceId': serviceId?.toJson(),
      'estimatedDistance': estimatedDistance,
      'estimatedDuration': estimatedDuration,
      'estimatedFare': estimatedFare,
      'actualDistance': actualDistance,
      'actualDuration': actualDuration,
      'finalFare': finalFare,
      'status': status,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'route': route,
      'timeline': timeline,
      'createdAt': createdAt,
      '__v': v,
    };
  }
}

class Location {
  final List<double>? coordinates;
  final String? address;
  final String? type;

  Location({
    this.coordinates,
    this.address,
    this.type,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: json['coordinates'] != null
          ? List<double>.from(
              json['coordinates'].map((x) => (x as num).toDouble()))
          : [],
      address: json['address'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates,
      'address': address,
      'type': type,
    };
  }
}

class PromoCode {
  final String? code;
  final double? discount;

  PromoCode({
    this.code,
    this.discount,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    return PromoCode(
      code: json['code'],
      discount: (json['discount'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount': discount,
    };
  }
}

class Commission {
  final double? rate;
  final double? amount;

  Commission({
    this.rate,
    this.amount,
  });

  factory Commission.fromJson(Map<String, dynamic> json) {
    return Commission(
      rate: (json['rate'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'amount': amount,
    };
  }
}

class ServiceId {
  final String? id;
  final String? name;

  ServiceId({
    this.id,
    this.name,
  });

  factory ServiceId.fromJson(Map<String, dynamic> json) {
    return ServiceId(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
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

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'pages': pages,
      'total': total,
    };
  }
}

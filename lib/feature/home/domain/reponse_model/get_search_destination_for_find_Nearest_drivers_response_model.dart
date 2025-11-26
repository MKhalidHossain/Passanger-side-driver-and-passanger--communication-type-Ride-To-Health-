class GetSearchDestinationForFindNearestDriversResponseModel {
  final bool ?success;
  final dynamic message;
  final List<DriverData> ?data;

  GetSearchDestinationForFindNearestDriversResponseModel({
     this.success,
     this.message,
     this.data,
  });

  factory GetSearchDestinationForFindNearestDriversResponseModel.fromJson(
      Map<String, dynamic> json) {
    return GetSearchDestinationForFindNearestDriversResponseModel(
      success: json['success'] ?? false,
      message: json['message']?.toString() ?? "",
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => DriverData.fromJson(e))
          .toList(),
    );
  }
}

class DriverData {
  final CurrentLocation? currentLocation;
  final Earnings? earnings;
  final Ratings? ratings;
  final String? vehicleId;
  final String id;
  final UserId? userId;
  final String? licenseNumber;
  final String? licenseImage;
  final String? nidNumber;
  final String? nidImage;
  final String? selfieImage;
  final Vehicle? vehicle;
  final List<String> serviceTypes;
  final String? status;
  final bool isOnline;
  final bool isAvailable;
  final List<dynamic> withdrawals;
  final List<dynamic> suspensions;
  final String createdAt;
  final int v;
  final double heading;
  final double speed;
  final String? stripeDriverId;
  final String? city;
  final String? dateOfBirth;
  final EmergencyContact? emergencyContact;
  final String? state;
  final String? streetAddress;
  final String? zipcode;
  final String? currentRideId;
  final List<dynamic> paymentMethods;

  DriverData({
    this.currentLocation,
    this.earnings,
    this.ratings,
    this.vehicleId,
    required this.id,
    this.userId,
    this.licenseNumber,
    this.licenseImage,
    this.nidNumber,
    this.nidImage,
    this.selfieImage,
    this.vehicle,
    required this.serviceTypes,
    this.status,
    required this.isOnline,
    required this.isAvailable,
    required this.withdrawals,
    required this.suspensions,
    required this.createdAt,
    required this.v,
    required this.heading,
    required this.speed,
    this.stripeDriverId,
    this.city,
    this.dateOfBirth,
    this.emergencyContact,
    this.state,
    this.streetAddress,
    this.zipcode,
    this.currentRideId,
    required this.paymentMethods,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) {
    return DriverData(
      currentLocation: json['currentLocation'] != null
          ? CurrentLocation.fromJson(json['currentLocation'])
          : null,
      earnings:
          json['earnings'] != null ? Earnings.fromJson(json['earnings']) : null,
      ratings:
          json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null,
      vehicleId: json['vehicleId'],
      id: json['_id'],
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      licenseNumber: json['licenseNumber'],
      licenseImage: json['licenseImage'],
      nidNumber: json['nidNumber'],
      nidImage: json['nidImage'],
      selfieImage: json['selfieImage'],
      vehicle:
          json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
      serviceTypes:
          (json['serviceTypes'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      status: json['status'],
      isOnline: json['isOnline'] ?? false,
      isAvailable: json['isAvailable'] ?? false,
      withdrawals: json['withdrawals'] ?? [],
      suspensions: json['suspensions'] ?? [],
      createdAt: json['createdAt'] ?? "",
      v: json['__v'] ?? 0,
      heading: (json['heading'] ?? 0).toDouble(),
      speed: (json['speed'] ?? 0).toDouble(),
      stripeDriverId: json['stripeDriverId'],
      city: json['city'],
      dateOfBirth: json['date_of_birth'],
      emergencyContact: json['emergency_contact'] != null
          ? EmergencyContact.fromJson(json['emergency_contact'])
          : null,
      state: json['state'],
      streetAddress: json['street_address'],
      zipcode: json['zipcode'],
      currentRideId: json['currentRideId'],
      paymentMethods: json['paymentMethods'] ?? [],
    );
  }
}

class CurrentLocation {
  final String? type;
  final List<double> coordinates;

  CurrentLocation({this.type, required this.coordinates});

  factory CurrentLocation.fromJson(Map<String, dynamic> json) {
    return CurrentLocation(
      type: json['type'],
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }
}

class Earnings {
  final double total;
  final double available;
  final double withdrawn;

  Earnings({
    required this.total,
    required this.available,
    required this.withdrawn,
  });

  factory Earnings.fromJson(Map<String, dynamic> json) {
    return Earnings(
      total: (json['total'] as num).toDouble(),
      available: (json['available'] as num).toDouble(),
      withdrawn: (json['withdrawn'] as num).toDouble(),
    );
  }
}

class Ratings {
  final double average;
  final int count;
  final int count1;
  final int count2;
  final int count3;
  final int count4;
  final int count5;
  final int totalRatings;

  Ratings({
    required this.average,
    required this.count,
    required this.count1,
    required this.count2,
    required this.count3,
    required this.count4,
    required this.count5,
    required this.totalRatings,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      average: (json['average'] as num).toDouble(),
      count: json['count'] ?? 0,
      count1: json['count1'] ?? 0,
      count2: json['count2'] ?? 0,
      count3: json['count3'] ?? 0,
      count4: json['count4'] ?? 0,
      count5: json['count5'] ?? 0,
      totalRatings: json['totalRatings'] ?? 0,
    );
  }
}

class UserId {
  final String id;
  final String fullName;
  final String phoneNumber;

  UserId({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

class Vehicle {
  final String? type;
  final String? model;
  final int? year;
  final String? plateNumber;
  final String? color;
  final String? image;

  Vehicle({
    this.type,
    this.model,
    this.year,
    this.plateNumber,
    this.color,
    this.image,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      type: json['type'],
      model: json['model'],
      year: json['year'],
      plateNumber: json['plateNumber'],
      color: json['color'],
      image: json['image'],
    );
  }
}

class EmergencyContact {
  final String? name;
  final String? phoneNumber;

  EmergencyContact({
    required this.name,
    this.phoneNumber,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name']?.toString(),
      phoneNumber: json['phoneNumber']?.toString(),
    );
  }
}


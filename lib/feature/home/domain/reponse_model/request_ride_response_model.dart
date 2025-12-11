class RequestRideResponseModel {
  final bool ?success;
  final String? message;
  final RideData? data;
  final NotificationData? notification;

  RequestRideResponseModel({
     this.success,
     this.message,
    this.data,
    this.notification,
  });

  factory RequestRideResponseModel.fromJson(Map<String, dynamic> json) {
    return RequestRideResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? RideData.fromJson(json['data']) : null,
      notification: json['notification'] != null
          ? NotificationData.fromJson(json['notification'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "notification": notification?.toJson(),
      };
}

// ------------------ Ride Data ------------------

class RideData {
  final String rideId;
  final String totalFare;
  final DriverInfo? driverInfo;

  RideData({
    required this.rideId,
    required this.totalFare,
    this.driverInfo,
  });

  factory RideData.fromJson(Map<String, dynamic> json) {
    return RideData(
      rideId: json['rideId'] ?? '',
      totalFare: json['totalFare'] ?? '',
      driverInfo: json['driverInfo'] != null
          ? DriverInfo.fromJson(json['driverInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "rideId": rideId,
        "totalFare": totalFare,
        "driverInfo": driverInfo?.toJson(),
      };
}

// ------------------ Driver Info ------------------

class DriverInfo {
  final String id;
  final String name;
  final String phone;

  DriverInfo({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
      };
}

// ------------------ Notification ------------------

class NotificationData {
  final String senderId;
  final String receiverId;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final String id;
  final String createdAt;
  final int v;

  NotificationData({
    required this.senderId,
    required this.receiverId,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.id,
    required this.createdAt,
    required this.v,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      isRead: json['isRead'] ?? false,
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "receiverId": receiverId,
        "title": title,
        "message": message,
        "type": type,
        "isRead": isRead,
        "_id": id,
        "createdAt": createdAt,
        "__v": v,
      };
}

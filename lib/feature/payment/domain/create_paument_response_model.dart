class PaymentResponseModel {
  bool? success;
  String? url;
  String? sessionId;
  Breakdown? breakdown;

  PaymentResponseModel({
    this.success,
    this.url,
    this.sessionId,
    this.breakdown,
  });

  PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    url = json['url'];
    sessionId = json['sessionId'];
    breakdown = json['breakdown'] != null
        ? Breakdown.fromJson(json['breakdown'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'url': url,
      'sessionId': sessionId,
      'breakdown': breakdown?.toJson(),
    };
  }
}

class Breakdown {
  int? total;
  int? adminFee;
  int? driverAmount;

  Breakdown({
    this.total,
    this.adminFee,
    this.driverAmount,
  });

  Breakdown.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    adminFee = json['adminFee'];
    driverAmount = json['driverAmount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'adminFee': adminFee,
      'driverAmount': driverAmount,
    };
  }
}

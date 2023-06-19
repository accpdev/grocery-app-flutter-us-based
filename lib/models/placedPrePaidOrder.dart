class PlacedPrePaidOrder {
  PlacedPrePaidOrder({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final String status;
  late final String message;
  late final String total;
  late final PlacedPrePaidOrderData data;

  PlacedPrePaidOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = PlacedPrePaidOrderData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['status'] = status;
    itemData['message'] = message;
    itemData['total'] = total;
    itemData['data'] = data.toJson();
    return itemData;
  }
}

class PlacedPrePaidOrderData {
  PlacedPrePaidOrderData({
    required this.orderId,
  });

  late final String orderId;

  PlacedPrePaidOrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, String>{};
    itemData['order_id'] = orderId;
    return itemData;
  }
}

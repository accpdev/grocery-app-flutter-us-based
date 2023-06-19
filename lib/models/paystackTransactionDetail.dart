class PaystackTransactionDetail {
  PaystackTransactionDetail({
    required this.status,
    required this.message,
    required this.data,
  });

  late final bool status;
  late final String message;
  late final PaystackTransactionDetailData data;

  PaystackTransactionDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = PaystackTransactionDetailData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['status'] = status;
    itemData['message'] = message;
    itemData['data'] = data.toJson();
    return itemData;
  }
}

class PaystackTransactionDetailData {
  PaystackTransactionDetailData({
    required this.id,
  });

  late final int id;

  PaystackTransactionDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;

    return itemData;
  }
}

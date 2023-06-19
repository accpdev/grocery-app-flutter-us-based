class NotificationList {
  NotificationList({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final String status;
  late final String message;
  late final String total;
  late final List<NotificationListData> data;

  NotificationList.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = List.from(json['data']).map((e) => NotificationListData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['status'] = status;
    itemData['message'] = message;
    itemData['total'] = total;
    itemData['data'] = data.map((e) => e.toJson()).toList();
    return itemData;
  }
}

class NotificationListData {
  NotificationListData({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.typeId,
    required this.imageUrl,
  });

  late final String id;
  late final String title;
  late final String message;
  late final String type;
  late final String typeId;
  late final String imageUrl;

  NotificationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    message = json['message'].toString();
    type = json['type'].toString();
    typeId = json['type_id'].toString();
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['title'] = title;
    itemData['message'] = message;
    itemData['type'] = type;
    itemData['type_id'] = typeId;
    itemData['image_url'] = imageUrl;
    return itemData;
  }
}

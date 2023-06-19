class AppNotificationSettings {
  String? status;
  String? message;
  String? total;
  List<AppNotificationSettingsData>? data;

  AppNotificationSettings({this.status, this.message, this.total, this.data});

  AppNotificationSettings.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    if (json['data'] != null) {
      data = <AppNotificationSettingsData>[];
      json['data'].forEach((v) {
        data!.add(AppNotificationSettingsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppNotificationSettingsData {
  String? orderStatusId;
  String? mailStatus;
  String? mobileStatus;

  AppNotificationSettingsData({this.orderStatusId, this.mailStatus, this.mobileStatus});

  AppNotificationSettingsData.fromJson(Map<String, dynamic> json) {
    orderStatusId = json['order_status_id'].toString();
    mailStatus = json['mail_status'].toString();
    mobileStatus = json['mobile_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_status_id'] = orderStatusId;
    data['mail_status'] = mailStatus;
    data['mobile_status'] = mobileStatus;
    return data;
  }
}

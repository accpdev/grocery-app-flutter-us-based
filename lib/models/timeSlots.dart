class TimeSlotsSettings {
  TimeSlotsSettings({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final String status;
  late final String message;
  late final String total;
  late final TimeSlotsData data;

  TimeSlotsSettings.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = TimeSlotsData.fromJson(json['data']);
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

class TimeSlotsData {
  TimeSlotsData({
    required this.timeSlotsIsEnabled,
    required this.timeSlotsDeliveryStartsFrom,
    required this.timeSlotsAllowedDays,
    required this.timeSlots,
  });

  late final String timeSlotsIsEnabled;
  late final String timeSlotsDeliveryStartsFrom;
  late final String timeSlotsAllowedDays;
  late final List<TimeSlots> timeSlots;

  TimeSlotsData.fromJson(Map<String, dynamic> json) {
    timeSlotsIsEnabled = json['time_slots_is_enabled'].toString();
    timeSlotsDeliveryStartsFrom = json['time_slots_delivery_starts_from'].toString();
    timeSlotsAllowedDays = json['time_slots_allowed_days'].toString();
    timeSlots = List.from(json['time_slots']).map((e) => TimeSlots.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['time_slots_is_enabled'] = timeSlotsIsEnabled;
    itemData['time_slots_delivery_starts_from'] = timeSlotsDeliveryStartsFrom;
    itemData['time_slots_allowed_days'] = timeSlotsAllowedDays;
    itemData['time_slots'] = timeSlots.map((e) => e.toJson()).toList();
    return itemData;
  }
}

class TimeSlots {
  TimeSlots({
    required this.id,
    required this.title,
    required this.fromTime,
    required this.toTime,
    required this.lastOrderTime,
    required this.status,
  });

  late final String id;
  late final String title;
  late final String fromTime;
  late final String toTime;
  late final String lastOrderTime;
  late final String status;

  TimeSlots.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    fromTime = json['from_time'].toString();
    toTime = json['to_time'].toString();
    lastOrderTime = json['last_order_time'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['title'] = title;
    itemData['from_time'] = fromTime;
    itemData['to_time'] = toTime;
    itemData['last_order_time'] = lastOrderTime;
    itemData['status'] = status;
    return itemData;
  }
}

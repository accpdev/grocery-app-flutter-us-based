class CityByLatLong {
  String? id;
  String? name;
  String? formattedAddress;
  String? latitude;
  String? longitude;
  String? deliveryChargeMethod;
  String? fixedCharge;
  String? perKmCharge;
  String? timeToTravel;
  String? maxDeliverableDistance;

  CityByLatLong({int? id, String? name, String? formattedAddress, String? latitude, String? longitude, String? deliveryChargeMethod, String? fixedCharge, String? perKmCharge, String? timeToTravel, String? maxDeliverableDistance}) {
    if (id != null) {
      id = id;
    }
    if (name != null) {
      name = name;
    }
    if (formattedAddress != null) {
      formattedAddress = formattedAddress;
    }
    if (latitude != null) {
      latitude = latitude;
    }
    if (longitude != null) {
      longitude = longitude;
    }
    if (deliveryChargeMethod != null) {
      deliveryChargeMethod = deliveryChargeMethod;
    }
    if (fixedCharge != null) {
      fixedCharge = fixedCharge;
    }
    if (perKmCharge != null) {
      perKmCharge = perKmCharge;
    }
    if (timeToTravel != null) {
      timeToTravel = timeToTravel;
    }
    if (maxDeliverableDistance != null) {
      maxDeliverableDistance = maxDeliverableDistance;
    }
  }

  CityByLatLong.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    formattedAddress = json['formatted_address'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    deliveryChargeMethod = json['deliverycharge_method'].toString();
    fixedCharge = json['fixedcharge'].toString();
    perKmCharge = json['per_km_charge'].toString();
    timeToTravel = json['time_to_travel'].toString();
    maxDeliverableDistance = json['max_deliverable_distance'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['formatted_address'] = formattedAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['delivery_charge_method'] = deliveryChargeMethod;
    data['fixed_charge'] = fixedCharge;
    data['per_km_charge'] = perKmCharge;
    data['time_to_travel'] = timeToTravel;
    data['max_deliverable_distance'] = maxDeliverableDistance;
    return data;
  }
}

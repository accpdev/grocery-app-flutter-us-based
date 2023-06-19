class Address {
  String? status;
  String? message;
  String? total;
  List<AddressData>? data;

  Address({this.status, this.message, this.total, this.data});

  Address.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
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

class AddressData {
  String? id;
  String? type;
  String? name;
  String? mobile;
  String? alternateMobile;
  String? address;
  String? landmark;
  String? area;
  String? pincode;
  String? cityId;
  String? city;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  String? isDefault;

  AddressData({this.id, this.type, this.name, this.mobile, this.alternateMobile, this.address, this.landmark, this.area, this.pincode, this.cityId, this.city, this.state, this.country, this.latitude, this.longitude, this.isDefault});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
    name = json['name'].toString();
    mobile = json['mobile'].toString();
    alternateMobile = json['alternate_mobile'].toString();
    address = json['address'].toString();
    landmark = json['landmark'].toString();
    area = json['area'].toString();
    pincode = json['pincode'].toString();
    cityId = json['city_id'].toString();
    city = json['city'].toString();
    state = json['state'].toString();
    country = json['country'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    isDefault = json['is_default'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['mobile'] = mobile;
    data['alternate_mobile'] = alternateMobile;
    data['address'] = address;
    data['landmark'] = landmark;
    data['area'] = area;
    data['pincode'] = pincode;
    data['city_id'] = cityId;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_default'] = isDefault;
    return data;
  }
}

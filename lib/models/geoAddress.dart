import 'package:egrocer/helper/utils/generalImports.dart';

class GeoAddress {
  String? id;
  String? lattitud;
  String? longitude;
  String? zipcode;
  String? name;
  String? mobile;
  String? type;
  String? address;
  String? landmark;
  String? area;
  String? city;
  String? state;
  String? district;
  String? country;
  String? alternateMobile;
  String? placeId;
  String? isDefault;

  GeoAddress({
    this.id,
    this.lattitud,
    this.longitude,
    this.zipcode,
    this.name,
    this.mobile,
    this.type,
    this.address,
    this.landmark,
    this.area,
    this.city,
    this.state,
    this.country,
    this.alternateMobile,
    this.isDefault,
    this.district,
    this.placeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lattitud': lattitud,
      'longitude': longitude,
      'zipcode': zipcode,
      'name': name,
      'mobile': mobile,
      'type': type,
      'address': address,
      'landmark': landmark,
      'area': area,
      'city': city,
      'state': state,
      'district': district,
      'country': country,
      'alternateMobile': alternateMobile,
      'placeId': placeId,
      'isDefault': isDefault,
    };
  }

  factory GeoAddress.fromMap(Map<String, dynamic> map) {
    return GeoAddress(
      id: map['id']?.toString(),
      lattitud: map['lattitud']?.toString(),
      longitude: map['longitude']?.toString(),
      zipcode: map['zipcode'].toString(),
      name: map['name'].toString(),
      mobile: map['mobile'].toString(),
      type: map['type'].toString(),
      address: map['address'].toString(),
      landmark: map['landmark'].toString(),
      area: map['area'].toString(),
      city: map['city'].toString(),
      state: map['state'].toString(),
      district: map['district'].toString(),
      country: map['country'].toString(),
      alternateMobile: map['alternateMobile'].toString(),
      placeId: map['placeId'].toString(),
      isDefault: map['isDefault']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoAddress.fromJson(String source) => GeoAddress.fromMap(json.decode(source));
}

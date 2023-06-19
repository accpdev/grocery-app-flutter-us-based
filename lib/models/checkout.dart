class Checkout {
  String? status;
  String? message;
  String? total;
  DeliveryChargeData? data;

  Checkout({this.status, this.message, this.total, this.data});

  Checkout.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = json['data'] != null ? new DeliveryChargeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DeliveryChargeData {
  String? codAllowed;
  String? productVariantId;
  String? quantity;
  DeliveryCharge? deliveryCharge;
  String? totalAmount;
  PromocodeDetails? promocodeDetails;
  String? subTotal;
  String? savedAmount;

  DeliveryChargeData({this.codAllowed, this.productVariantId, this.quantity, this.deliveryCharge, this.totalAmount, this.promocodeDetails, this.subTotal, this.savedAmount});

  DeliveryChargeData.fromJson(Map<String, dynamic> json) {
    codAllowed = json['cod_allowed'].toString();
    productVariantId = json['product_variant_id'].toString();
    quantity = json['quantity'].toString();
    deliveryCharge = json['delivery_charge'] != null ? new DeliveryCharge.fromJson(json['delivery_charge']) : null;
    totalAmount = json['total_amount'].toString();
    promocodeDetails = json['promocode_details'] != null ? new PromocodeDetails.fromJson(json['promocode_details']) : null;
    subTotal = json['sub_total'].toString();
    savedAmount = json['saved_amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod_allowed'] = this.codAllowed;
    data['product_variant_id'] = this.productVariantId;
    data['quantity'] = this.quantity;
    if (this.deliveryCharge != null) {
      data['delivery_charge'] = this.deliveryCharge!.toJson();
    }
    data['total_amount'] = this.totalAmount;
    if (this.promocodeDetails != null) {
      data['promocode_details'] = this.promocodeDetails!.toJson();
    }
    data['sub_total'] = this.subTotal;
    data['saved_amount'] = this.savedAmount;
    return data;
  }
}

class DeliveryCharge {
  String? totalDeliveryCharge;
  List<SellersInfo>? sellersInfo;

  DeliveryCharge({this.totalDeliveryCharge, this.sellersInfo});

  DeliveryCharge.fromJson(Map<String, dynamic> json) {
    totalDeliveryCharge = json['total_delivery_charge'].toString();
    if (json['sellers_info'] != null) {
      sellersInfo = <SellersInfo>[];
      json['sellers_info'].forEach((v) {
        sellersInfo!.add(new SellersInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_delivery_charge'] = this.totalDeliveryCharge;
    if (this.sellersInfo != null) {
      data['sellers_info'] = this.sellersInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellersInfo {
  String? sellerName;
  String? deliveryCharge;
  String? distance;
  String? duration;

  SellersInfo({this.sellerName, this.deliveryCharge, this.distance, this.duration});

  SellersInfo.fromJson(Map<String, dynamic> json) {
    sellerName = json['seller_name'].toString();
    deliveryCharge = json['delivery_charge'].toString();
    distance = json['distance'].toString();
    duration = json['duration'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_name'] = this.sellerName;
    data['delivery_charge'] = this.deliveryCharge;
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    return data;
  }
}

class PromocodeDetails {
  String? id;
  String? isApplicable;
  String? message;
  String? promoCode;
  String? imageUrl;
  String? promoCodeMessage;
  String? total;
  String? discount;
  String? discountedAmount;

  PromocodeDetails({this.id, this.isApplicable, this.message, this.promoCode, this.imageUrl, this.promoCodeMessage, this.total, this.discount, this.discountedAmount});

  PromocodeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    isApplicable = json['is_applicable'].toString();
    message = json['message'].toString();
    promoCode = json['promo_code'].toString();
    imageUrl = json['image_url'].toString();
    promoCodeMessage = json['promo_code_message'].toString();
    total = json['total'].toString();
    discount = json['discount'].toString();
    discountedAmount = json['discounted_amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_applicable'] = this.isApplicable;
    data['message'] = this.message;
    data['promo_code'] = this.promoCode;
    data['image_url'] = this.imageUrl;
    data['promo_code_message'] = this.promoCodeMessage;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['discounted_amount'] = this.discountedAmount;
    return data;
  }
}

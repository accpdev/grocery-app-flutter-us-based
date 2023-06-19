class CartData {
  CartData({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final String status;
  late final String message;
  late final String total;
  late final Data data;

  CartData.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = Data.fromJson(json['data']);
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

class Data {
  Data({
    required this.subTotal,
    required this.cart,
  });

  late final String subTotal;
  late final List<Cart> cart;

  Data.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'].toString();
    cart = List.from(json['cart']).map((e) => Cart.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['sub_total'] = subTotal;
    itemData['cart'] = cart.map((e) => e.toJson()).toList();
    return itemData;
  }
}

class Cart {
  Cart({
    required this.productId,
    required this.productVariantId,
    required this.qty,
    required this.isDeliverable,
    required this.measurement,
    required this.discountedPrice,
    required this.price,
    required this.stock,
    required this.totalAllowedQuantity,
    required this.name,
    required this.unit,
    required this.status,
    required this.imageUrl,
  });

  late final String productId;
  late final String productVariantId;
  late final String qty;
  late final String isDeliverable;
  late final String isUnlimitedStock;
  late final String measurement;
  late final String discountedPrice;
  late final String price;
  late final String stock;
  late final String totalAllowedQuantity;
  late final String name;
  late final String unit;
  late final String status;
  late final String imageUrl;

  Cart.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'].toString();
    productVariantId = json['product_variant_id'].toString();
    qty = json['qty'].toString();
    isDeliverable = json['is_deliverable'].toString();
    isUnlimitedStock = json['is_unlimited_stock'].toString();
    measurement = json['measurement'].toString();
    discountedPrice = json['discounted_price'].toString();
    price = json['price'].toString();
    stock = json['stock'].toString();
    totalAllowedQuantity = json['total_allowed_quantity'].toString();
    name = json['name'].toString();
    unit = json['unit'].toString();
    status = json['status'].toString();
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_variant_id'] = productVariantId;
    data['qty'] = qty;
    data['is_deliverable'] = isDeliverable;
    data['is_deliverable'] = isUnlimitedStock;
    data['measurement'] = measurement;
    data['discounted_price'] = discountedPrice;
    data['price'] = price;
    data['stock'] = stock;
    data['total_allowed_quantity'] = totalAllowedQuantity;
    data['name'] = name;
    data['unit'] = unit;
    data['status'] = status;
    data['image_url'] = imageUrl;
    return data;
  }
}

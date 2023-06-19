class CartList {
  CartList({
    required this.productId,
    required this.productVariantId,
    required this.qty,
  });

  late final String productId;
  late final String productVariantId;
  late final String qty;

  CartList.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productVariantId = json['product_variant_id'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_variant_id'] = productVariantId;
    data['qty'] = qty;
    return data;
  }
}

class ProductDetail {
  ProductDetail({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final String status;
  late final String message;
  late final String total;
  late final ProductData data;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = ProductData.fromJson(json['data']);
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

class ProductData {
  ProductData({
    required this.id,
    required this.name,
    required this.taxId,
    required this.brandId,
    required this.slug,
    required this.categoryId,
    required this.indicator,
    required this.manufacturer,
    required this.madeIn,
    required this.returnStatus,
    required this.cancelableStatus,
    required this.tillStatus,
    required this.description,
    required this.status,
    required this.isApproved,
    required this.returnDays,
    required this.type,
    required this.isUnlimitedStock,
    required this.codAllowed,
    required this.totalAllowedQuantity,
    required this.taxIncludedInPrice,
    required this.dType,
    required this.sellerName,
    required this.images,
    required this.isFavorite,
    required this.variants,
    required this.imageUrl,
  });

  late final String id;
  late final String name;
  late final String taxId;
  late final String brandId;
  late final String slug;
  late final String categoryId;
  late final String indicator;
  late final String manufacturer;
  late final String madeIn;
  late final String returnStatus;
  late final String cancelableStatus;
  late final String tillStatus;
  late final String description;
  late final String status;
  late final String isApproved;
  late final String returnDays;
  late final String type;
  late final String isUnlimitedStock;
  late final String codAllowed;
  late final String totalAllowedQuantity;
  late final String taxIncludedInPrice;
  late final String dType;
  late final String sellerName;
  late final List<String> images;
  late final bool isFavorite;
  late final List<ProductDetailVariants> variants;
  late final String imageUrl;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    taxId = json['tax_id'].toString();
    brandId = json['brand_id'].toString();
    slug = json['slug'].toString();
    categoryId = json['category_id'].toString();
    indicator = json['indicator'].toString();
    manufacturer = json['manufacturer'].toString();
    madeIn = json['made_in'].toString();
    returnStatus = json['return_status'].toString();
    cancelableStatus = json['cancelable_status'].toString();
    tillStatus = json['till_status'].toString();
    description = json['description'].toString();
    status = json['status'].toString();
    isApproved = json['is_approved'].toString();
    returnDays = json['return_days'].toString();
    type = json['type'].toString();
    isUnlimitedStock = json['is_unlimited_stock'].toString();
    codAllowed = json['cod_allowed'].toString();
    totalAllowedQuantity = json['total_allowed_quantity'].toString();
    taxIncludedInPrice = json['tax_included_in_price'].toString();
    dType = json['d_type'].toString();
    sellerName = json['seller_name'].toString();
    images = List.castFrom<dynamic, String>(json['images']);
    isFavorite = json['is_favorite'] ?? false;
    variants = List.from(json['variants']).map((e) => ProductDetailVariants.fromJson(e)).toList();
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['name'] = name;
    itemData['tax_id'] = taxId;
    itemData['brand_id'] = brandId;
    itemData['slug'] = slug;
    itemData['category_id'] = categoryId;
    itemData['indicator'] = indicator;
    itemData['manufacturer'] = manufacturer;
    itemData['made_in'] = madeIn;
    itemData['return_status'] = returnStatus;
    itemData['cancelable_status'] = cancelableStatus;
    itemData['till_status'] = tillStatus;
    itemData['description'] = description;
    itemData['status'] = status;
    itemData['is_approved'] = isApproved;
    itemData['return_days'] = returnDays;
    itemData['type'] = type;
    itemData['is_unlimited_stock'] = isUnlimitedStock;
    itemData['cod_allowed'] = codAllowed;
    itemData['total_allowed_quantity'] = totalAllowedQuantity;
    itemData['tax_included_in_price'] = taxIncludedInPrice;
    itemData['d_type'] = dType;
    itemData['seller_name'] = sellerName;
    itemData['images'] = images;
    itemData['is_favorite'] = isFavorite;
    itemData['variants'] = variants.map((e) => e.toJson()).toList();
    itemData['image_url'] = imageUrl;
    return itemData;
  }
}

class ProductDetailVariants {
  ProductDetailVariants({
    required this.id,
    required this.type,
    required this.measurement,
    required this.price,
    required this.discountedPrice,
    required this.stock,
    required this.stockUnitName,
    required this.cartCount,
    required this.status,
    required this.images,
  });

  late final String id;
  late final String type;
  late final String measurement;
  late final String price;
  late final String discountedPrice;
  late final String stock;
  late final String stockUnitName;
  late final String cartCount;
  late final String status;
  late final List<String> images;

  ProductDetailVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
    measurement = json['measurement'].toString();
    price = json['price'].toString();
    discountedPrice = json['discounted_price'].toString();
    stock = json['stock'].toString();
    stockUnitName = json['stock_unit_name'];
    cartCount = json['cart_count'].toString();
    status = json['status'].toString();
    images = List.castFrom<dynamic, String>(json['images']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['measurement'] = measurement;
    data['price'] = price;
    data['discounted_price'] = discountedPrice;
    data['stock'] = stock;
    data['stock_unit_name'] = stockUnitName;
    data['cart_count'] = cartCount;
    data['status'] = status;
    data['images'] = images;
    return data;
  }
}

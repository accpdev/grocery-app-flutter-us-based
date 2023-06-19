import 'package:egrocer/helper/utils/generalImports.dart';

class HomeScreenData {
  HomeScreenData({
    required this.category,
    required this.sliders,
    required this.offers,
    required this.sections,
  });

  late final List<Category> category;
  late final List<Sliders> sliders;
  late final List<Offers> offers;
  late final List<Sections> sections;

  HomeScreenData.fromJson(Map<String, dynamic> json) {
    category = List.from(json['category']).map((e) => Category.fromJson(e)).toList();
    sliders = List.from(json['sliders']).map((e) => Sliders.fromJson(e)).toList();
    offers = List.from(json['offers']).map((e) => Offers.fromJson(e)).toList();
    sections = List.from(json['sections']).map((e) => Sections.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['category'] = category.map((e) => e.toJson()).toList();
    itemData['sliders'] = sliders.map((e) => e.toJson()).toList();
    itemData['offers'] = offers.map((e) => e.toJson()).toList();
    itemData['sections'] = sections.map((e) => e.toJson()).toList();
    return itemData;
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.hasChild,
    required this.imageUrl,
  });

  late final String id;
  late final String name;
  late final String subtitle;
  late final bool hasChild;
  late final String imageUrl;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    subtitle = json['subtitle'].toString();
    hasChild = json['has_active_child'];
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['name'] = name;
    itemData['subtitle'] = subtitle;
    itemData['has_active_child'] = hasChild;
    itemData['image_url'] = imageUrl;
    return itemData;
  }
}

class Sliders {
  Sliders({
    required this.id,
    required this.type,
    required this.typeId,
    required this.sliderUrl,
    required this.typeName,
    required this.imageUrl,
  });

  late final String id;
  late final String type;
  late final String typeId;
  late final String sliderUrl;
  late final String typeName;
  late final String imageUrl;

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
    typeId = json['type_id'].toString();
    sliderUrl = json['slider_url'].toString();
    typeName = json['type_name'].toString();
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['type'] = type;
    itemData['type_id'] = typeId;
    itemData['slider_url'] = sliderUrl;
    itemData['type_name'] = typeName;
    itemData['image_url'] = imageUrl;
    return itemData;
  }
}

class Offers {
  Offers({
    required this.id,
    required this.position,
    required this.sectionPosition,
    required this.imageUrl,
  });

  late final String id;
  late final String position;
  late final String sectionPosition;
  late final String imageUrl;

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    position = json['position'].toString();
    sectionPosition = json['section_position'].toString();
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['position'] = position;
    itemData['section_position'] = sectionPosition;
    itemData['image_url'] = imageUrl;
    return itemData;
  }
}

class Sections {
  Sections({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.productType,
    required this.products,
  });

  late final String id;
  late final String title;
  late final String shortDescription;
  late final String productType;
  late final List<ProductListItem> products;

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    shortDescription = json['short_description'].toString();
    productType = json['product_type'].toString();
    products = List.from(json['products']).map((e) => ProductListItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['title'] = title;
    itemData['short_description'] = shortDescription;
    itemData['product_type'] = productType;
    itemData['products'] = products;
    return itemData;
  }
}

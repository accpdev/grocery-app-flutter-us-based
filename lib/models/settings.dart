class Settings {
  String? status;
  String? message;
  SettingsData? data;

  Settings({this.status, this.message, this.data});

  Settings.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? new SettingsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SettingsData {
  String? appName;
  String? supportNumber;
  String? supportEmail;
  String? currentVersion;
  String? isVersionSystemOn;
  String? storeAddress;
  String? mapLatitude;
  String? mapLongitude;
  String? currency;
  String? currencyCode;
  String? decimalPoint;
  String? systemTimezone;
  String? maxCartItemsCount;
  String? minOrderAmount;
  String? areaWiseDeliveryCharge;
  String? minAmount;
  String? deliveryCharge;
  String? isReferEarnOn;
  String? minReferEarnOrderAmount;
  String? referEarnBonus;
  String? referEarnMethod;
  String? maxReferEarnAmount;
  String? minimumWithdrawalAmount;
  String? maxProductReturnDays;
  String? deliveryBoyBonusPercentage;
  String? userWalletRefillLimit;
  String? taxName;
  String? taxNumber;
  String? lowStockLimit;
  String? generateOtp;
  String? appModeCustomer;
  String? appModeSeller;
  String? appModeDeliveryBoy;
  String? googlePlaceApiKey;
  String? timeSlotsIsEnabled;
  String? timeSlotsDeliveryStartsFrom;
  String? timeSlotsAllowedDays;
  String? privacyPolicy;
  String? returnsAndExchangesPolicy;
  String? shippingPolicy;
  String? cancellationPolicy;
  String? termsConditions;
  String? privacyPolicyDeliveryBoy;
  String? termsConditionsDeliveryBoy;
  String? privacyPolicySeller;
  String? termsConditionsSeller;
  String? aboutUs;
  String? contactUs;
  String? defaultCityId;
  String? appModeCustomerRemark;
  String? appModeSellerRemark;
  String? appModeDeliveryBoyRemark;
  String? requiredForceUpdate;
  String? popupEnabled;
  String? popupAlwaysShowHome;
  String? popupType;
  String? popupTypeId;
  String? popupUrl;
  String? popupImage;
  String? iosIsVersionSystemOn;
  String? iosRequiredForceUpdate;
  String? iosCurrentVersion;
  String? color;
  String? commonMetaKeywords;
  String? commonMetaDescription;
  String? showColorPickerInWebsite;
  String? webLogo;
  String? loading;
  String? favicon;
  DefaultCity? defaultCity;
  List<int>? favoriteProductIds;

  SettingsData({this.appName, this.supportNumber, this.supportEmail, this.currentVersion, this.isVersionSystemOn, this.storeAddress, this.mapLatitude, this.mapLongitude, this.currency, this.currencyCode, this.decimalPoint, this.systemTimezone, this.maxCartItemsCount, this.minOrderAmount, this.areaWiseDeliveryCharge, this.minAmount, this.deliveryCharge, this.isReferEarnOn, this.minReferEarnOrderAmount, this.referEarnBonus, this.referEarnMethod, this.maxReferEarnAmount, this.minimumWithdrawalAmount, this.maxProductReturnDays, this.deliveryBoyBonusPercentage, this.userWalletRefillLimit, this.taxName, this.taxNumber, this.lowStockLimit, this.generateOtp, this.appModeCustomer, this.appModeSeller, this.appModeDeliveryBoy, this.googlePlaceApiKey, this.timeSlotsIsEnabled, this.timeSlotsDeliveryStartsFrom, this.timeSlotsAllowedDays, this.privacyPolicy, this.returnsAndExchangesPolicy, this.shippingPolicy, this.cancellationPolicy, this.termsConditions, this.privacyPolicyDeliveryBoy, this.termsConditionsDeliveryBoy, this.privacyPolicySeller, this.termsConditionsSeller, this.aboutUs, this.contactUs, this.defaultCityId, this.appModeCustomerRemark, this.appModeSellerRemark, this.appModeDeliveryBoyRemark, this.requiredForceUpdate, this.popupEnabled, this.popupAlwaysShowHome, this.popupType, this.popupTypeId, this.popupUrl, this.popupImage, this.iosIsVersionSystemOn, this.iosRequiredForceUpdate, this.iosCurrentVersion, this.color, this.commonMetaKeywords, this.commonMetaDescription, this.showColorPickerInWebsite, this.webLogo, this.loading, this.favicon, this.defaultCity, this.favoriteProductIds});

  SettingsData.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'].toString();
    supportNumber = json['support_number'].toString();
    supportEmail = json['support_email'].toString();
    currentVersion = json['current_version'].toString();
    isVersionSystemOn = json['is_version_system_on'].toString();
    storeAddress = json['store_address'].toString();
    mapLatitude = json['map_latitude'].toString();
    mapLongitude = json['map_longitude'].toString();
    currency = json['currency'].toString();
    currencyCode = json['currency_code'].toString();
    decimalPoint = json['decimal_point'].toString();
    systemTimezone = json['system_timezone'].toString();
    maxCartItemsCount = json['max_cart_items_count'].toString();
    minOrderAmount = json['min_order_amount'].toString();
    areaWiseDeliveryCharge = json['area_wise_delivery_charge'].toString();
    minAmount = json['min_amount'].toString();
    deliveryCharge = json['delivery_charge'].toString();
    isReferEarnOn = json['is_refer_earn_on'].toString();
    minReferEarnOrderAmount = json['min_refer_earn_order_amount'].toString();
    referEarnBonus = json['refer_earn_bonus'].toString();
    referEarnMethod = json['refer_earn_method'].toString();
    maxReferEarnAmount = json['max_refer_earn_amount'].toString();
    minimumWithdrawalAmount = json['minimum_withdrawal_amount'].toString();
    maxProductReturnDays = json['max_product_return_days'].toString();
    deliveryBoyBonusPercentage = json['delivery_boy_bonus_percentage'].toString();
    userWalletRefillLimit = json['user_wallet_refill_limit'].toString();
    taxName = json['tax_name'].toString();
    taxNumber = json['tax_number'].toString();
    lowStockLimit = json['low_stock_limit'].toString();
    generateOtp = json['generate_otp'].toString();
    appModeCustomer = json['app_mode_customer'].toString();
    appModeSeller = json['app_mode_seller'].toString();
    appModeDeliveryBoy = json['app_mode_delivery_boy'].toString();
    googlePlaceApiKey = json['google_place_api_key'].toString();
    timeSlotsIsEnabled = json['time_slots_is_enabled'].toString();
    timeSlotsDeliveryStartsFrom = json['time_slots_delivery_starts_from'].toString();
    timeSlotsAllowedDays = json['time_slots_allowed_days'].toString();
    privacyPolicy = json['privacy_policy'].toString();
    returnsAndExchangesPolicy = json['returns_and_exchanges_policy'].toString();
    shippingPolicy = json['shipping_policy'].toString();
    cancellationPolicy = json['cancellation_policy'].toString();
    termsConditions = json['terms_conditions'].toString();
    privacyPolicyDeliveryBoy = json['privacy_policy_delivery_boy'].toString();
    termsConditionsDeliveryBoy = json['terms_conditions_delivery_boy'].toString();
    privacyPolicySeller = json['privacy_policy_seller'].toString();
    termsConditionsSeller = json['terms_conditions_seller'].toString();
    aboutUs = json['about_us'].toString();
    contactUs = json['contact_us'].toString();
    defaultCityId = json['default_city_id'].toString();
    appModeCustomerRemark = json['app_mode_customer_remark'].toString();
    appModeSellerRemark = json['app_mode_seller_remark'].toString();
    appModeDeliveryBoyRemark = json['app_mode_delivery_boy_remark'].toString();
    requiredForceUpdate = json['required_force_update'].toString();
    popupEnabled = json['popup_enabled'].toString();
    popupAlwaysShowHome = json['popup_always_show_home'].toString();
    popupType = json['popup_type'].toString();
    popupTypeId = json['popup_type_id'].toString();
    popupUrl = json['popup_url'].toString();
    popupImage = json['popup_image'].toString();
    iosIsVersionSystemOn = json['ios_is_version_system_on'].toString();
    iosRequiredForceUpdate = json['ios_required_force_update'].toString();
    iosCurrentVersion = json['ios_current_version'].toString();
    color = json['color'].toString();
    commonMetaKeywords = json['common_meta_keywords'].toString();
    commonMetaDescription = json['common_meta_description'].toString();
    showColorPickerInWebsite = json['show_color_picker_in_website'].toString();
    webLogo = json['web_logo'].toString();
    loading = json['loading'].toString();
    favicon = json['favicon'].toString();
    defaultCity = json['default_city'] != null ? new DefaultCity.fromJson(json['default_city']) : null;
    favoriteProductIds = json['favorite_product_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['support_number'] = this.supportNumber;
    data['support_email'] = this.supportEmail;
    data['current_version'] = this.currentVersion;
    data['is_version_system_on'] = this.isVersionSystemOn;
    data['store_address'] = this.storeAddress;
    data['map_latitude'] = this.mapLatitude;
    data['map_longitude'] = this.mapLongitude;
    data['currency'] = this.currency;
    data['currency_code'] = this.currencyCode;
    data['decimal_point'] = this.decimalPoint;
    data['system_timezone'] = this.systemTimezone;
    data['max_cart_items_count'] = this.maxCartItemsCount;
    data['min_order_amount'] = this.minOrderAmount;
    data['area_wise_delivery_charge'] = this.areaWiseDeliveryCharge;
    data['min_amount'] = this.minAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['is_refer_earn_on'] = this.isReferEarnOn;
    data['min_refer_earn_order_amount'] = this.minReferEarnOrderAmount;
    data['refer_earn_bonus'] = this.referEarnBonus;
    data['refer_earn_method'] = this.referEarnMethod;
    data['max_refer_earn_amount'] = this.maxReferEarnAmount;
    data['minimum_withdrawal_amount'] = this.minimumWithdrawalAmount;
    data['max_product_return_days'] = this.maxProductReturnDays;
    data['delivery_boy_bonus_percentage'] = this.deliveryBoyBonusPercentage;
    data['user_wallet_refill_limit'] = this.userWalletRefillLimit;
    data['tax_name'] = this.taxName;
    data['tax_number'] = this.taxNumber;
    data['low_stock_limit'] = this.lowStockLimit;
    data['generate_otp'] = this.generateOtp;
    data['app_mode_customer'] = this.appModeCustomer;
    data['app_mode_seller'] = this.appModeSeller;
    data['app_mode_delivery_boy'] = this.appModeDeliveryBoy;
    data['google_place_api_key'] = this.googlePlaceApiKey;
    data['time_slots_is_enabled'] = this.timeSlotsIsEnabled;
    data['time_slots_delivery_starts_from'] = this.timeSlotsDeliveryStartsFrom;
    data['time_slots_allowed_days'] = this.timeSlotsAllowedDays;
    data['privacy_policy'] = this.privacyPolicy;
    data['returns_and_exchanges_policy'] = this.returnsAndExchangesPolicy;
    data['shipping_policy'] = this.shippingPolicy;
    data['cancellation_policy'] = this.cancellationPolicy;
    data['terms_conditions'] = this.termsConditions;
    data['privacy_policy_delivery_boy'] = this.privacyPolicyDeliveryBoy;
    data['terms_conditions_delivery_boy'] = this.termsConditionsDeliveryBoy;
    data['privacy_policy_seller'] = this.privacyPolicySeller;
    data['terms_conditions_seller'] = this.termsConditionsSeller;
    data['about_us'] = this.aboutUs;
    data['contact_us'] = this.contactUs;
    data['default_city_id'] = this.defaultCityId;
    data['app_mode_customer_remark'] = this.appModeCustomerRemark;
    data['app_mode_seller_remark'] = this.appModeSellerRemark;
    data['app_mode_delivery_boy_remark'] = this.appModeDeliveryBoyRemark;
    data['required_force_update'] = this.requiredForceUpdate;
    data['popup_enabled'] = this.popupEnabled;
    data['popup_always_show_home'] = this.popupAlwaysShowHome;
    data['popup_type'] = this.popupType;
    data['popup_type_id'] = this.popupTypeId;
    data['popup_url'] = this.popupUrl;
    data['popup_image'] = this.popupImage;
    data['ios_is_version_system_on'] = this.iosIsVersionSystemOn;
    data['ios_required_force_update'] = this.iosRequiredForceUpdate;
    data['ios_current_version'] = this.iosCurrentVersion;
    data['color'] = this.color;
    data['common_meta_keywords'] = this.commonMetaKeywords;
    data['common_meta_description'] = this.commonMetaDescription;
    data['show_color_picker_in_website'] = this.showColorPickerInWebsite;
    data['web_logo'] = this.webLogo;
    data['loading'] = this.loading;
    data['favicon'] = this.favicon;
    if (this.defaultCity != null) {
      data['default_city'] = this.defaultCity!.toJson();
    }
    data['favorite_product_ids'] = this.favoriteProductIds;
    return data;
  }
}

class DefaultCity {
  String? id;
  String? name;
  String? state;
  String? formattedAddress;
  String? latitude;
  String? longitude;

  DefaultCity({this.id, this.name, this.state, this.formattedAddress, this.latitude, this.longitude});

  DefaultCity.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    state = json['state'].toString();
    formattedAddress = json['formatted_address'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['formatted_address'] = this.formattedAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class ApiAndParams {
  //============== api ===========
  static String apiLogin = "login";
  static String apiSliders = "sliders";
  static String apiCategories = "categories";
  static String apiProducts = "products";
  static String apiFavorites = "favorites";
  static String apiAppSettings = "settings";
  static String apiTimeSlotsSettings = "$apiAppSettings/time_slots";
  static String apiPaymentMethodsSettings = "$apiAppSettings/payment_methods";
  static String apiCity = "city";
  static String apiShop = "shop";
  static String apiFavorite = "favorites";
  static String apiAddProductToFavorite = "favorites/add";
  static String apiRemoveProductFromFavorite = "favorites/remove";
  static String apiProductDetail = "product_by_id";
  static String apiFaq = "faqs";
  static String apiNotification = "notifications";
  static String apiUpdateProfile = "edit_profile";
  static String apiUserDetails = "user_details";
  static String apiCart = "cart";
  static String apiCartAdd = "$apiCart/add";
  static String apiCartRemove = "$apiCart/remove";
  static String apiOrdersHistory = "orders";
  static String apiUpdateOrderStatus = "update_order_status";
  static String apiPromoCode = "promo_code";
  static String apiAddress = "address";
  static String apiAddressAdd = "$apiAddress/add";
  static String apiAddressUpdate = "$apiAddress/update";
  static String apiAddressRemove = "$apiAddress/delete";
  static String apiPlaceOrder = "place_order";
  static String apiInitiateTransaction = "initiate_transaction";
  static String apiAddTransaction = "add_transaction";
  static String apiDeleteAccount = "delete_account";
  static String apiTransaction = "get_user_transactions";
  static String apiNotificationSettings = "mail_settings";
  static String apiNotificationSettingsUpdate = "$apiNotificationSettings/save";
  static String apiOrderInvoice = "invoice";
  static String apiDownloadOrderInvoice = "invoice_download";
  static String apiPaytmTransactionToken = "paytm_txn_token";
  static String apiAddFcmToken = "add_fcm_token";

//============ api params ============

//general
  static String id = "id";
  static String user = "user";
  static String status = "status";
  static String message = "message";
  static String imageUrl = "image_url";
  static String mobile = "mobile";
  static String data = "data";
  static String cityName = "name";
  static String latitude = "latitude";
  static String longitude = "longitude";
  static String cityId = "city_id";
  static String search = "search";
  static String total = "total";
  static String limit = "limit";
  static String offset = "offset";
  static String sort = "sort";
  static String minPrice = "min_price";
  static String maxPrice = "max_price";
  static String brandIds = "brand_ids";
  static String sizes = "sizes";
  static String unitIds = "unit_ids";
  static String isCheckout = "is_checkout";
  static String promoCodeId = "promocode_id";
  static String removeAllCartItems = "is_remove_all";
  static List<String> productListSortTypes = ["", "new", "old", "high", "low", "discount", "popular"];
  static String categoryId = "category_id";
  static String sectionId = "section_id";
  static String cartItemsCount = "cart_items_count";
  static String productId = "product_id";
  static String productVariantId = "product_variant_id";
  static String qty = "qty";
  static String cart = "cart";
  static String saveForLater = "save_for_later";
  static String amount = "amount";

  static String address = "address";
  static String landmark = "landmark";
  static String area = "area";
  static String pinCode = "pincode";
  static String city = "city";
  static String state = "state";
  static String country = "country";
  static String alternateMobile = "alternate_mobile";
  static String isDefault = "is_default";

  static String productVariantIds = "product_variant_id";
  static String quantity = "quantity";
  static String deliveryCharge = "delivery_charge";
  static String finalTotal = "final_total";
  static String paymentMethod = "payment_method";
  static String addressId = "address_id";
  static String deliveryTime = "delivery_time";
  static String orderId = "order_id";
  static String subTotal = "sub_total";

  static String deviceType = "device_type";
  static String appVersion = "app_version";
  static String transactionId = "transaction_id";

//login
  static String authUid = "auth_uid";
  static String fcmToken = "fcm_token";

//category
  static String description = "description";
  static String parentId = "parent_id";
  static String level = "level";
  static String allChilds = "all_childs";

  //user
  static String name = "name";
  static String email = "email";
  static String profile = "profile";
  static String countryCode = "country_code";
  static String balance = "balance";
  static String lblReferralCode = "referral_code";
  static String friendsCode = "friends_code";
  static String createdAt = "created_at";
  static String updatedAt = "updated_at";
  static String accessToken = "access_token";

  //slider
  static String type = "type";
  static String typeId = "type_id";
  static String image = "image";
  static String sliderUrl = "slider_url";
  static String typeName = "type_name";

  //Notification setting api params
  static String statusIds = "status_ids";
  static String mailStatuses = "mail_statuses";
  static String mobileStatuses = "mobile_statuses";
}

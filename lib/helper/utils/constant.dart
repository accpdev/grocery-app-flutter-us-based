import 'package:egrocer/helper/utils/generalImports.dart';

enum NetworkStatus { online, offline }

class Constant {
  //Add your admin panel url here with postfix slash eg. https://www.admin.panel/
  static String hostUrl = "your_admin_panel_url_here";

  static String baseUrl = "${hostUrl}customer/";
  static String packageName = "com.wrteam.egrocer";
  static String appStoreUrl = "place_app_store_url_here";
  static String playStoreUrl = "https://play.google.com/store/apps/details?id=$packageName";

  static String appStoreId = "com.wrteam.egrocer";

  static String deepLinkPrefix = "https://egrocer.page.link";

  static String notificationChannel = "My Notifications";

  static String deepLinkName = "eGrocer";

  static String defaultLangCode = 'en';

  //supported languages
  //https://developers.google.com/admin-sdk/directory/v1/languages
  static List<String> supportedLanguages = ['en', 'hi', 'bn', 'ar', 'ur', 'es', 'fr', 'pt', 'ru'];

  static Map languageNames = {'en': 'English', 'hi': 'Hindi', 'bn': 'Bengali', 'ar': 'Arabic', 'ur': 'Urdu', 'es': 'Spanish', 'fr': 'French', 'pt': 'Portuguese', 'ru': 'Russian'};

  //authenticationScreen with phone constants
  static int otpTimeOutSecond = 60; //otp time out
  static int otpResendSecond = 60; // resend otp timer
  static int messageDisplayDuration = 3500; // resend otp timer

  static int searchHistoryListLimit = 20; // resend otp timer

  static int discountCouponDialogVisibilityTimeInMilliseconds = 3000;

  static String initialCountryCode = "IN"; // initial country code, change as per your requirement

  // Theme list, This system default names please do not change at all
  static List<String> themeList = ["System default", "Light", "Dark"];

  static GlobalKey<NavigatorState> navigatorKay = GlobalKey<NavigatorState>();

  //google api keys
  static String googleApiKey = "";

  //Set here 0 if you want to show all categories at home
  static int homeCategoryMaxLength = 6;

  static int defaultDataLoadLimitAtOnce = 20;

  static String selectedCoupon = "";
  static double discountedAmount = 0.0;
  static double discount = 0.0;
  static bool isPromoCodeApplied = false;
  static String selectedPromoCodeId = "0";

  static BorderRadius borderRadius5 = BorderRadius.circular(5);
  static BorderRadius borderRadius7 = BorderRadius.circular(7);
  static BorderRadius borderRadius10 = BorderRadius.circular(10);
  static BorderRadius borderRadius13 = BorderRadius.circular(13);

  static late SessionManager session;
  static List<String> searchedItemsHistoryList = [];

//Order statues codes
  static List<String> orderStatusCode = [
    "1", //Awaiting Payment
    "2", //Received
    "3", //Processed
    "4", //Shipped
    "5", //Out For Delivery
    "6", //Delivered
    "7", //Cancelled
    "8" //Returned
  ];

  static Map cityAddressMap = {};

  //authenticationScreen type
  static String authTypePhone = "mobile";

  // App Settings
  static List<int> favorits = [];
  static String currency = "";
  static String maxAllowItemsInCart = "";
  static String minimumOrderAmount = "";
  static String minimumReferEarnOrderAmount = "";
  static String referEarnBonus = "";
  static String maximumReferEarnAmount = "";
  static String minimumWithdrawalAmount = "";
  static String maximumProductReturnDays = "";
  static String userWalletRefillLimit = "";
  static String isReferEarnOn = "";
  static String referEarnMethod = "";
  static String privacyPolicy = "";
  static String termsConditions = "";
  static String aboutUs = "";
  static String contactUs = "";
  static String returnAndExchangesPolicy = "";
  static String cancellationPolicy = "";
  static String shippingPolicy = "";
  static String currencyCode = "";
  static String decimalPoints = "";

  static String appMaintenanceMode = "";
  static String appMaintenanceModeRemark = "";

  static bool popupBannerEnabled = false;
  static bool showAlwaysPopupBannerAtHomeScreen = false;
  static String popupBannerType = "";
  static String popupBannerTypeId = "";
  static String popupBannerUrl = "";
  static String popupBannerImageUrl = "";

  static String currentRequiredAppVersion = "";
  static String requiredForceUpdate = "";
  static String isVersionSystemOn = "";

  static String currentRequiredIosAppVersion = "";
  static String requiredIosForceUpdate = "";
  static String isIosVersionSystemOn = "";

  static String getAssetsPath(int folder, String filename) {
    //0-image,1-svg,2-language,3-animation

    String path = "";
    switch (folder) {
      case 0:
        path = "assets/images/$filename";
        break;
      case 1:
        path = "assets/svg/$filename.svg";
        break;
      case 2:
        path = "assets/language/$filename.json";
        break;
      case 3:
        path = "assets/animation/$filename.json";
        break;
    }

    return path;
  }

  //Default padding and margin variables

  static double size2 = 2.00;
  static double size3 = 3.00;
  static double size5 = 5.00;
  static double size7 = 7.00;
  static double size8 = 8.00;
  static double size10 = 10.00;
  static double size12 = 12.00;
  static double size14 = 14.00;
  static double size15 = 15.00;
  static double size18 = 18.00;
  static double size20 = 20.00;
  static double size25 = 20.00;
  static double size30 = 30.00;
  static double size35 = 35.00;
  static double size40 = 40.00;
  static double size50 = 50.00;
  static double size60 = 60.00;
  static double size65 = 65.00;
  static double size70 = 70.00;
  static double size75 = 75.00;
  static double size80 = 80.00;

  static Future<Map<String, String>> getProductsDefaultParams() async {
    Map<String, String> params = {};
    /*params[ApiAndParams.cityId] =
        Constant.session.getData(SessionManager.keyCityId);*/
    params[ApiAndParams.latitude] = Constant.session.getData(SessionManager.keyLatitude);
    params[ApiAndParams.longitude] = Constant.session.getData(SessionManager.keyLongitude);

    return params;
  }

  static Future<String> getGetMethodUrlWithParams(String mainUrl, Map params) async {
    if (params.isNotEmpty) {
      mainUrl = "$mainUrl?";
      for (int i = 0; i < params.length; i++) {
        mainUrl = "$mainUrl${i == 0 ? "" : "&"}${params.keys.toList()[i]}=${params.values.toList()[i]}";
      }
    }

    return mainUrl;
  }

  static List<String> selectedBrands = [];
  static List<String> selectedSizes = [];
  static RangeValues currentRangeValues = const RangeValues(0, 0);

  static String getOrderActiveStatusLabelFromCode(String value) {
    if (value.isEmpty) {
      return value;
    }
    /*
      1 -> Payment pending
      2 -> Received
      3 -> Processed
      4 -> Shipped
      5 -> Out For Delivery
      6 -> Delivered
      7 -> Cancelled
      8 -> Returned
     */

    if (value == "1") {
      return "Payment pending";
    }
    if (value == "2") {
      return "Received";
    }
    if (value == "3") {
      return "Confirmed";
    }
    if (value == "4") {
      return "Shipped";
    }
    if (value == "5") {
      return "Out For Delivery";
    }
    if (value == "6") {
      return "Delivered";
    }
    if (value == "7") {
      return "Cancelled";
    }
    return "Returned";
  }

  static resetTempFilters() {
    selectedBrands = [];
    selectedSizes = [];
    currentRangeValues = const RangeValues(0, 0);
  }

  //apis
  // https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670,151.1957&radius=500&types=food&name=cruise&key=API_KEY

  static String apiGeoCode = "https://maps.googleapis.com/maps/api/geocode/json?key=$googleApiKey&latlng=";
}

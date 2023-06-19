import 'package:egrocer/helper/utils/generalImports.dart';

Future getAppSettings({required BuildContext context}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiAppSettings, params: {}, isPost: false, context: context);
  Map<String, dynamic> getData = json.decode(response);
  if (getData[ApiAndParams.status].toString() == "1") {
    SettingsData settings = SettingsData.fromJson(getData[ApiAndParams.data]);

    Constant.favorits = settings.favoriteProductIds?.cast<int>() ?? [];
    Constant.currency = settings.currency ?? "";
    Constant.maxAllowItemsInCart = settings.maxCartItemsCount ?? "";
    Constant.minimumOrderAmount = settings.minOrderAmount ?? "";
    Constant.minimumReferEarnOrderAmount = settings.minReferEarnOrderAmount ?? "";
    Constant.referEarnBonus = settings.referEarnBonus ?? "";
    Constant.maximumReferEarnAmount = settings.maxReferEarnAmount ?? "";
    Constant.minimumWithdrawalAmount = settings.minimumWithdrawalAmount ?? "";
    Constant.maximumProductReturnDays = settings.maxProductReturnDays ?? "";
    Constant.userWalletRefillLimit = settings.userWalletRefillLimit ?? "";
    Constant.isReferEarnOn = settings.isReferEarnOn ?? "";
    Constant.referEarnMethod = settings.referEarnMethod ?? "";
    Constant.privacyPolicy = settings.privacyPolicy ?? "";
    Constant.termsConditions = settings.termsConditions ?? "";
    Constant.aboutUs = settings.aboutUs ?? "";
    Constant.contactUs = settings.contactUs ?? "";
    Constant.returnAndExchangesPolicy = settings.returnsAndExchangesPolicy ?? "";
    Constant.cancellationPolicy = settings.cancellationPolicy ?? "";
    Constant.shippingPolicy = settings.shippingPolicy ?? "";
    Constant.googleApiKey = settings.googlePlaceApiKey ?? "";
    Constant.currencyCode = settings.currencyCode ?? "";
    Constant.decimalPoints = settings.decimalPoint ?? "0";
    Constant.appMaintenanceMode = settings.appModeCustomer ?? "0";
    Constant.appMaintenanceModeRemark = settings.appModeCustomerRemark ?? "";

    Constant.popupBannerEnabled = settings.popupEnabled == "1";
    Constant.showAlwaysPopupBannerAtHomeScreen = settings.popupAlwaysShowHome == "1";
    Constant.popupBannerType = settings.popupType ?? "";
    Constant.popupBannerTypeId = settings.popupTypeId ?? "";
    Constant.popupBannerUrl = settings.popupUrl ?? "";
    Constant.popupBannerImageUrl = settings.popupImage ?? "";

    if (settings.isVersionSystemOn == "1" && settings.currentVersion.toString().isNotEmpty) {
      Constant.isVersionSystemOn = settings.isVersionSystemOn ?? "";
      Constant.currentRequiredAppVersion = settings.currentVersion ?? "";
      Constant.requiredForceUpdate = settings.requiredForceUpdate ?? "";
    }

    if (settings.iosIsVersionSystemOn == "1" && settings.iosCurrentVersion.toString().isNotEmpty) {
      Constant.isIosVersionSystemOn = settings.iosCurrentVersion ?? "";
      Constant.currentRequiredIosAppVersion = settings.iosCurrentVersion ?? "";
      Constant.requiredIosForceUpdate = settings.iosRequiredForceUpdate ?? "";
    }

    String tempLat = settings.defaultCity?.latitude.toString() ?? "0";
    String tempLong = settings.defaultCity?.longitude.toString() ?? "0";
    String tempAddress = settings.defaultCity?.formattedAddress.toString() ?? "";

    if (tempAddress == "" || tempLong == "0" || tempLat == "0" || Constant.session.getData(SessionManager.keyLongitude) == "0" || Constant.session.getData(SessionManager.keyLatitude) == "0" || Constant.session.getData(SessionManager.keyAddress) == "") {
      Constant.session.setData(SessionManager.keyLongitude, tempLong, false);
      Constant.session.setData(SessionManager.keyLatitude, tempLat, false);
      Constant.session.setData(SessionManager.keyAddress, tempAddress, false);
    }

    Constant.session.setBoolData(SessionManager.keyPopupOfferEnabled, settings.popupEnabled == "1", false);
    Constant.session.setBoolData(SessionManager.keyPopupAlwaysShowHome, settings.popupAlwaysShowHome == "1", false);
    Constant.session.setData(SessionManager.keyPopupOfferType, settings.popupType.toString(), false);
    Constant.session.setData(SessionManager.keyPopupOfferTypeId, settings.popupTypeId.toString(), false);
    Constant.session.setData(SessionManager.keyPopupOfferImage, settings.popupImage.toString(), false);
    Constant.session.setData(SessionManager.keyPopupOfferUrl, settings.popupUrl.toString(), false);

    return true;
  } else {
    return false;
  }
}

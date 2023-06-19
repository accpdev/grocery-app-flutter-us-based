import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:flutter/scheduler.dart';

class SessionManager extends ChangeNotifier {
  static String preferenceName = "egrocerappPref";
  static String isUserLogin = "isuserlogin";
  static String introSlider = "introslider";
  static String isDarkTheme = "isDarkTheme";
  static String appThemeName = "appthemename";
  static String keyLangCode = "selectedlanguagecode";
  static String keyRecentAddressSearch = "recentaddress";
  static String keySkipLogin = "keySkipLogin";
  static String keySearchHistory = "keySearchHistory";
  static String keyAuthUid = "keyAuthUid";
  static String keyUserName = "username";
  static String keyUserImage = "image";
  static String keyPhone = "phone";
  static String keyEmail = "email";
  static String keyCountryCode = "countryCode";
  static String keyReferralCode = "lblReferralCode";
  static String keyUserStatus = "userStatus";
  static String keyToken = "keytoken";
  static String keyFCMToken = "keyFCMToken";
  static String keyIsGrid = "isGrid";
  static String keyLatitude = "keyLatitude";
  static String keyLongitude = "keyLongitude";
  static String keyAddress = "keyAddress";
  static String keyPopupOfferAlreadySeen = "keyPopupOfferAlreadySeen";
  static String keyPopupOfferEnabled = "keyPopupOfferEnabled";
  static String keyPopupAlwaysShowHome = "keyPopupAlwaysShowHome";
  static String keyPopupOfferType = "keyPopupOfferType";
  static String keyPreviousPopupOfferType = "keyPreviousPopupOfferType";
  static String keyPopupOfferTypeId = "keyPopupOfferTypeId";
  static String keyPreviousPopupOfferTypeId = "keyPreviousPopupOfferTypeId";
  static String keyPopupOfferImage = "keyPopupOfferImage";
  static String keyPopupOfferUrl = "keyPopupOfferUrl";
  static String keyFavoriteIds = "keyFavoriteIds";

  late SharedPreferences prefs;

  SessionManager({required this.prefs});

  String getData(String id) {
    return prefs.getString(id) ?? "";
  }

  Locale getCurrLang() {
    String langcode = prefs.getString(keyLangCode) ?? Constant.defaultLangCode;

    return Locale(langcode);
  }

  setCurrLang(String languageCode, BuildContext context) {
    prefs.setString(keyLangCode, languageCode);
    notifyListeners();
  }

  void setData(String id, String val, bool isRefresh) {
    prefs.setString(id, val);
    if (isRefresh) {
      notifyListeners();
    }
  }

  void addItemIntoList(String id, String item) {
    if (!Constant.searchedItemsHistoryList.contains(item)) {
      Constant.searchedItemsHistoryList.add(item);
      prefs.setStringList(id, Constant.searchedItemsHistoryList);
    }
  }

  void clearItemList(String id) {
    Constant.searchedItemsHistoryList = [];
    prefs.setStringList(id, []);
  }

  Future setUserData({
    required String name,
    required String email,
    required String profile,
    required String countryCode,
    required String mobile,
    required String lblReferralCode,
    required int status,
    required String token,
    /*required String balance*/
  }) async {
    /*prefs.setString(keyAuthUid, firebaseUid);*/
    prefs.setString(keyUserName, name);
    prefs.setString(keyEmail, email);
    prefs.setString(keyUserImage, profile);
    prefs.setString(keyCountryCode, countryCode);
    prefs.setString(keyPhone, mobile);
    prefs.setString(keyReferralCode, lblReferralCode);
    prefs.setInt(keyUserStatus, status);
    prefs.setString(keyToken, token);
/*
    prefs.setString(keyBalance, balance.toString());
*/
  }

  void setDoubleData(String key, double value) {
    prefs.setDouble(key, value);
    notifyListeners();
  }

  double getDoubleData(String key) {
    return prefs.getDouble(key) ?? 0.0;
  }

  bool getBoolData(String key) {
    return prefs.getBool(key) ?? false;
  }

  void setBoolData(String key, bool value, bool isRefresh) {
    prefs.setBool(key, value);
    if (isRefresh) notifyListeners();
  }

  int getIntData(String key) {
    return prefs.getInt(key) ?? 0;
  }

  void setIntData(String key, int value) {
    prefs.setInt(key, value);
    notifyListeners();
  }

  bool isUserLoggedIn() {
    if (prefs.getBool(isUserLogin) == null) {
      return false;
    } else {
      return prefs.getBool(isUserLogin) ?? false;
    }
  }

  void logoutUser(BuildContext buildContext) {
    showDialog<String>(
      context: buildContext,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          getTranslatedValue(
            context,
            "lblLogoutTitle",
          ),
          softWrap: true,
        ),
        content: Text(
          getTranslatedValue(
            context,
            "lblLogoutMessage",
          ),
          softWrap: true,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              getTranslatedValue(
                context,
                "lblCancel",
              ),
              softWrap: true,
            ),
          ),
          TextButton(
            onPressed: () {
              String themeName = getData(SessionManager.appThemeName);
              String languageCode = getData(SessionManager.keyLangCode);
              String latitude = getData(SessionManager.keyLatitude);
              String longitude = getData(SessionManager.keyLongitude);
              String address = getData(SessionManager.keyAddress);

              bool isDark = false;
              if (themeName == Constant.themeList[2]) {
                isDark = true;
              } else if (themeName == Constant.themeList[1]) {
                isDark = false;
              } else if (themeName == "" || themeName == Constant.themeList[0]) {
                var brightness = SchedulerBinding.instance.window.platformBrightness;
                isDark = brightness == Brightness.dark;

                if (themeName == "") {
                  setData(SessionManager.appThemeName, Constant.themeList[0], false);
                }
              }
              prefs.clear();
              setBoolData(introSlider, true, false);
              setBoolData(isUserLogin, false, false);
              setData(SessionManager.appThemeName, themeName, false);
              setCurrLang(languageCode, buildContext);
              setData(SessionManager.keyLatitude, latitude, false);
              setData(SessionManager.keyLongitude, longitude, false);
              setData(SessionManager.keyAddress, address, false);
              setBoolData(SessionManager.isDarkTheme, isDark, false);
              setBoolData(SessionManager.introSlider, true, false);
              context.read<CartListProvider>().cartList.clear();
              Navigator.of(buildContext).pushNamedAndRemoveUntil(loginScreen, (Route<dynamic> route) => false);
            },
            child: Text(
              getTranslatedValue(
                context,
                "lblOk",
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  void deleteUserAccount(BuildContext buildContext) {
    showDialog<String>(
      context: buildContext,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          getTranslatedValue(context, "lblDeleteUserTitle"),
          softWrap: true,
        ),
        content: Text(
          getTranslatedValue(
            context,
            "lblDeleteUserMessage",
          ),
          softWrap: true,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              getTranslatedValue(
                context,
                "lblCancel",
              ),
              softWrap: true,
            ),
          ),
          TextButton(
            onPressed: () async {
              await getDeleteAccountApi(context: context).then((response) async {
                String themeName = getData(SessionManager.appThemeName);
                String languageCode = getData(SessionManager.keyLangCode);
                String latitude = getData(SessionManager.keyLatitude);
                String longitude = getData(SessionManager.keyLongitude);
                String address = getData(SessionManager.keyAddress);

                bool isDark = false;
                if (themeName == Constant.themeList[2]) {
                  isDark = true;
                } else if (themeName == Constant.themeList[1]) {
                  isDark = false;
                } else if (themeName == "" || themeName == Constant.themeList[0]) {
                  var brightness = SchedulerBinding.instance.window.platformBrightness;
                  isDark = brightness == Brightness.dark;

                  if (themeName == "") {
                    setData(SessionManager.appThemeName, Constant.themeList[0], false);
                  }
                }
                prefs.clear();
                setBoolData(introSlider, true, false);
                setBoolData(isUserLogin, false, false);
                setData(SessionManager.appThemeName, themeName, false);
                setData(SessionManager.keyLatitude, latitude, false);
                setData(SessionManager.keyLongitude, longitude, false);
                setData(SessionManager.keyAddress, address, false);
                setBoolData(SessionManager.isDarkTheme, isDark, false);
                setBoolData(SessionManager.introSlider, true, false);
                setCurrLang(languageCode, buildContext);
                context.read<CartListProvider>().cartList.clear();
                Navigator.of(buildContext).pushNamedAndRemoveUntil(loginScreen, (Route<dynamic> route) => false);
              });
            },
            child: Text(
              getTranslatedValue(
                context,
                "lblOk",
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

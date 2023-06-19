import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PackageInfo packageInfo;
  String currentAppVersion = "1.0.0";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      try {
        FirebaseMessaging.instance.getToken().then((token) {
          if (Constant.session.getData(SessionManager.keyFCMToken).isEmpty) {
            Constant.session.setData(SessionManager.keyFCMToken, token!, false);
            registerFcmKey(context: context, fcmToken: token);
          }
        });
      } catch (ignore) {}

      getAppSettings(context: context).then((value) async {
        packageInfo = await PackageInfo.fromPlatform();
        currentAppVersion = packageInfo.version;
        LocationPermission permission;
        permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        } else if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
        startTime();
      });
    });
  }

  startTime() async {
    return Timer(
      const Duration(seconds: 1),
      () async {
        if (Constant.appMaintenanceMode == "1") {
          Navigator.pushReplacementNamed(context, underMaintenanceScreen);
        } else if (Platform.isAndroid) {
          if (!Constant.session.getBoolData(SessionManager.introSlider)) {
            if ((Constant.isVersionSystemOn == "1" || Constant.currentRequiredAppVersion.isNotEmpty) && (Version.parse(Constant.currentRequiredAppVersion) > Version.parse(currentAppVersion))) {
              if (Constant.requiredForceUpdate == "1") {
                Constant.session.setBoolData(SessionManager.introSlider, true, false);
                Navigator.pushReplacementNamed(context, introSliderScreen);
                Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
              } else {
                Constant.session.setBoolData(SessionManager.introSlider, true, false);
                Navigator.pushReplacementNamed(context, introSliderScreen);
                Navigator.pushNamed(context, appUpdateScreen, arguments: false);
              }
            } else {
              Constant.session.setBoolData(SessionManager.introSlider, true, false);
              Navigator.pushReplacementNamed(context, introSliderScreen);
            }
          } else if (Constant.session.getBoolData(SessionManager.isUserLogin) && Constant.session.getIntData(SessionManager.keyUserStatus) == 2) {
            if (Constant.isVersionSystemOn == "1" && (Version.parse(Constant.currentRequiredAppVersion) > Version.parse(currentAppVersion))) {
              if (Constant.requiredForceUpdate == "1") {
                Navigator.pushReplacementNamed(context, editProfileScreen, arguments: "register");
                Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
              } else {
                Navigator.pushReplacementNamed(context, editProfileScreen, arguments: "register");
                Navigator.pushNamed(context, appUpdateScreen, arguments: false);
              }
            } else {
              Navigator.pushReplacementNamed(context, editProfileScreen, arguments: "register");
            }
          } else {
            if (Constant.session.getBoolData(SessionManager.keySkipLogin) || Constant.session.getBoolData(SessionManager.isUserLogin)) {
              if (Constant.session.getData(SessionManager.keyLatitude) == "0" && Constant.session.getData(SessionManager.keyLongitude) == "0") {
                if (Constant.isVersionSystemOn == "1" && (Version.parse(Constant.currentRequiredAppVersion) > Version.parse(currentAppVersion))) {
                  if (Constant.requiredForceUpdate == "1") {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                    Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
                  } else {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                    Navigator.pushNamed(context, appUpdateScreen, arguments: false);
                  }
                } else {
                  Navigator.pushReplacementNamed(context, mainHomeScreen);
                }
              } else {
                if (Constant.isVersionSystemOn == "1" && (Version.parse(Constant.currentRequiredAppVersion) > Version.parse(currentAppVersion))) {
                  if (Constant.requiredForceUpdate == "1") {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                    Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
                  } else {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                    Navigator.pushNamed(context, appUpdateScreen, arguments: false);
                  }
                } else {
                  Navigator.pushReplacementNamed(context, mainHomeScreen);
                }
              }
            } else {
              if (Constant.isVersionSystemOn == "1" && (Version.parse(Constant.currentRequiredAppVersion) > Version.parse(currentAppVersion))) {
                if (Constant.requiredForceUpdate == "1") {
                  Navigator.pushReplacementNamed(context, loginScreen);
                  Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
                } else {
                  Navigator.pushReplacementNamed(context, loginScreen);
                  Navigator.pushNamed(context, appUpdateScreen, arguments: false);
                }
              } else {
                Navigator.pushReplacementNamed(context, loginScreen);
              }
            }
          }
        } else if (Platform.isIOS) {
          if (!Constant.session.getBoolData(SessionManager.introSlider)) {
            if ((Constant.isIosVersionSystemOn == "1" || Constant.currentRequiredIosAppVersion.isNotEmpty) && (Version.parse(Constant.currentRequiredIosAppVersion) > Version.parse(currentAppVersion))) {
              if (Constant.requiredIosForceUpdate == "1") {
                Constant.session.setBoolData(SessionManager.introSlider, true, false);
                Navigator.pushReplacementNamed(context, introSliderScreen);
                Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
              } else {
                Constant.session.setBoolData(SessionManager.introSlider, true, false);
                Navigator.pushReplacementNamed(context, introSliderScreen);
                Navigator.pushNamed(context, appUpdateScreen, arguments: false);
              }
            } else {
              Constant.session.setBoolData(SessionManager.introSlider, true, false);
              Navigator.pushReplacementNamed(context, introSliderScreen);
            }
          } else if (Constant.session.getBoolData(SessionManager.isUserLogin) && Constant.session.getIntData(SessionManager.keyUserStatus) == 2) {
            if (await versionInformationAvailable()) {
              if (Constant.requiredIosForceUpdate == "1") {
                Navigator.pushReplacementNamed(context, editProfileScreen, arguments: "register");
                Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
              } else {
                Navigator.pushReplacementNamed(context, editProfileScreen, arguments: "register");
                Navigator.pushNamed(context, appUpdateScreen, arguments: false);
              }
            } else {
              Navigator.pushReplacementNamed(context, editProfileScreen, arguments: "register");
            }
          } else {
            if (Constant.session.getBoolData(SessionManager.keySkipLogin) || Constant.session.getBoolData(SessionManager.isUserLogin)) {
              if (Constant.session.getData(SessionManager.keyLatitude) == "0" && Constant.session.getData(SessionManager.keyLongitude) == "0") {
                if (await versionInformationAvailable()) {
                  if (Constant.requiredIosForceUpdate == "1") {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                    Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
                  } else {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                    Navigator.pushNamed(context, appUpdateScreen, arguments: false);
                  }
                } else {
                  Navigator.pushReplacementNamed(context, mainHomeScreen);
                }
              } else {
                if (await versionInformationAvailable()) {
                  if (Constant.requiredIosForceUpdate == "1") {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                    Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
                  } else {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                    Navigator.pushNamed(context, appUpdateScreen, arguments: false);
                  }
                } else {
                  Navigator.pushReplacementNamed(context, mainHomeScreen);
                }
              }
            } else {
              if (await versionInformationAvailable()) {
                if (Constant.requiredIosForceUpdate == "1") {
                  Navigator.pushReplacementNamed(context, loginScreen);
                  Navigator.pushReplacementNamed(context, appUpdateScreen, arguments: true);
                } else {
                  Navigator.pushReplacementNamed(context, loginScreen);
                  Navigator.pushNamed(context, appUpdateScreen, arguments: false);
                }
              } else {
                Navigator.pushReplacementNamed(context, loginScreen);
              }
            }
          }
        }
      },
    );
  }

  Future<bool> versionInformationAvailable() async {
    return Constant.isIosVersionSystemOn == "1" && (Version.parse(Constant.currentRequiredIosAppVersion) > Version.parse(currentAppVersion));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.appColor,
      body: Container(
        alignment: Alignment.center,
        child: Widgets.defaultImg(image: 'splash_logo'),
      ),
    );
  }
}

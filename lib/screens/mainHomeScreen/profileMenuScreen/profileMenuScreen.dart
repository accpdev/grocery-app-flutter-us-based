import 'package:egrocer/helper/utils/generalImports.dart';

class ProfileScreen extends StatefulWidget {
  final ScrollController scrollController;

  const ProfileScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List profileMenus = [];
  bool isUserLogin = Constant.session.isUserLoggedIn();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setProfileMenuList();

    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: Text(
            getTranslatedValue(
              context,
              "lblProfile",
            ),
            softWrap: true,
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          showBackButton: false,
        ),
        body: ListView(
          controller: widget.scrollController,
          children: [
            profileHeader(
              context: context,
              isUserLogin: isUserLogin,
            ),
            if (Constant.session.isUserLoggedIn())
              quickUseWidget(
                context: context,
              ),
            Card(
              margin: const EdgeInsetsDirectional.all(10),
              child: Column(
                children: List.generate(
                  profileMenus.length,
                  (index) => Theme(
                    data: ThemeData(
                      splashColor: ColorsRes.appColorLightHalfTransparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: ListTile(
                      onTap: () {
                        profileMenus[index]['clickFunction'](context);
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      leading: Container(
                        decoration: DesignConfig.boxDecoration(ColorsRes.appColorLightHalfTransparent, 5),
                        padding: const EdgeInsets.all(8),
                        child: Widgets.defaultImg(image: profileMenus[index]['icon'], iconColor: ColorsRes.appColor, height: 20, width: 20),
                      ),
                      title: Text(
                        profileMenus[index]['label'],
                        style: Theme.of(context).textTheme.bodyMedium!.merge(
                              const TextStyle(
                                letterSpacing: 0.5,
                              ),
                            ),
                      ),
                      trailing: Icon(
                        Icons.navigate_next,
                        color: ColorsRes.subTitleMainTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  setProfileMenuList() {
    profileMenus = [];
    profileMenus = [
      {
        "icon": "theme_icon",
        "label": getTranslatedValue(
          context,
          "lblChangeTheme",
        ),
        "clickFunction": Widgets.themeDialog,
      },
      {
        "icon": "translate_icon",
        "label": getTranslatedValue(
          context,
          "lblChangeLanguage",
        ),
        "clickFunction": Widgets.langDialog,
        "isResetLabel": true,
      },
      if (isUserLogin)
        {
          "icon": "settings",
          "label": getTranslatedValue(
            context,
            "lblSettings",
          ),
          "clickFunction": (context) {
            Navigator.pushNamed(context, notificationsAndMailSettingsScreenScreen);
          },
          "isResetLabel": false
        },
      if (isUserLogin)
        {
          "icon": "notification_icon",
          "label": getTranslatedValue(
            context,
            "lblNotification",
          ),
          "clickFunction": (context) {
            Navigator.pushNamed(context, notificationListScreen);
          },
          "isResetLabel": false
        },
      if (isUserLogin)
        {
          "icon": "transaction_icon",
          "label": getTranslatedValue(
            context,
            "lblTransactionHistory",
          ),
          "clickFunction": (context) {
            Navigator.pushNamed(context, transactionListScreen);
          },
          "isResetLabel": false
        },
/*      if (isUserLogin)
        {
          "icon": "refer_friend_icon",
          "label": getTranslatedValue(context, "lblReferAndEarn,
          "clickFunction": ReferAndEarn(),
          "isResetLabel": false
        },*/
      {
        "icon": "contact_icon",
        "label": getTranslatedValue(
          context,
          "lblContactUs",
        ),
        "clickFunction": (context) {
          Navigator.pushNamed(
            context,
            webViewScreen,
            arguments: getTranslatedValue(
              context,
              "lblContactUs",
            ),
          );
        }
      },
      {
        "icon": "about_icon",
        "label": getTranslatedValue(
          context,
          "lblAboutUs",
        ),
        "clickFunction": (context) {
          Navigator.pushNamed(
            context,
            webViewScreen,
            arguments: getTranslatedValue(
              context,
              "lblAboutUs",
            ),
          );
        },
        "isResetLabel": false
      },
      {
        "icon": "rate_icon",
        "label": getTranslatedValue(
          context,
          "lblRateUs",
        ),
        "clickFunction": (BuildContext context) {
          launchUrl(Uri.parse(Platform.isAndroid ? Constant.playStoreUrl : Constant.appStoreUrl), mode: LaunchMode.externalApplication);
        },
      },
      {
        "icon": "share_icon",
        "label": getTranslatedValue(
          context,
          "lblShareApp",
        ),
        "clickFunction": (BuildContext context) {
          String shareAppMessage = getTranslatedValue(
            context,
            "lblShareAppMessage",
          );
          if (Platform.isAndroid) {
            shareAppMessage = "$shareAppMessage${Constant.playStoreUrl}";
          } else if (Platform.isIOS) {
            shareAppMessage = "$shareAppMessage${Constant.appStoreUrl}";
          }
          Share.share(shareAppMessage, subject: "Share app");
        },
      },
      {
        "icon": "faq_icon",
        "label": getTranslatedValue(
          context,
          "lblFAQ",
        ),
        "clickFunction": (context) {
          Navigator.pushNamed(context, faqListScreen);
        }
      },
      {
        "icon": "terms_icon",
        "label": getTranslatedValue(
          context,
          "lblTermsAndConditions",
        ),
        "clickFunction": (context) {
          Navigator.pushNamed(context, webViewScreen,
              arguments: getTranslatedValue(
                context,
                "lblTermsAndConditions",
              ));
        }
      },
      {
        "icon": "privacy_icon",
        "label": getTranslatedValue(
          context,
          "lblPolicies",
        ),
        "clickFunction": (context) {
          Navigator.pushNamed(context, webViewScreen,
              arguments: getTranslatedValue(
                context,
                "lblPolicies",
              ));
        }
      },
      if (isUserLogin)
        {
          "icon": "logout_icon",
          "label": getTranslatedValue(
            context,
            "lblLogout",
          ),
          "clickFunction": Constant.session.logoutUser,
          "isResetLabel": false
        },
      if (isUserLogin)
        {
          "icon": "delete_user_account_icon",
          "label": getTranslatedValue(
            context,
            "lblDeleteUserAccount",
          ),
          "clickFunction": Constant.session.deleteUserAccount,
          "isResetLabel": false
        },
    ];

    setState(() {});
  }
}

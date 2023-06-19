import 'helper/utils/generalImports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isNotEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      await Firebase.initializeApp();
    }

    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  } catch (_) {}

  SharedPreferences prefs = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MyApp(
      prefs: prefs,
    ),
  );
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    LocalAwesomeNotification().init(context);
    LocalAwesomeNotification().requestPermission();
    NotificationService.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryListProvider>(
          create: (context) {
            return CategoryListProvider();
          },
        ),
        ChangeNotifierProvider<CityByLatLongProvider>(
          create: (context) {
            return CityByLatLongProvider();
          },
        ),
        ChangeNotifierProvider<HomeScreenProvider>(
          create: (context) {
            return HomeScreenProvider();
          },
        ),
        ChangeNotifierProvider<ProductChangeListingTypeProvider>(
          create: (context) {
            return ProductChangeListingTypeProvider();
          },
        ),
        ChangeNotifierProvider<FaqProvider>(
          create: (context) {
            return FaqProvider();
          },
        ),
        ChangeNotifierProvider<ProductWishListProvider>(
          create: (context) {
            return ProductWishListProvider();
          },
        ),
        ChangeNotifierProvider<ProductAddOrRemoveFavoriteProvider>(
          create: (context) {
            return ProductAddOrRemoveFavoriteProvider();
          },
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) {
            return UserProfileProvider();
          },
        ),
        ChangeNotifierProvider<CartListProvider>(
          create: (context) {
            return CartListProvider();
          },
        ),
      ],
      child: ChangeNotifierProvider<SessionManager>(
        create: (_) => SessionManager(prefs: widget.prefs),
        child: Consumer<SessionManager>(
          builder: (context, SessionManager sessionNotifier, child) {
            Constant.session = Provider.of<SessionManager>(context);

            Constant.searchedItemsHistoryList = Constant.session.prefs.getStringList(SessionManager.keySearchHistory) ?? [];

            FirebaseMessaging.instance.requestPermission(alert: true, sound: true, badge: true);

            final window = WidgetsBinding.instance.window;

            if (Constant.session.getData(SessionManager.appThemeName).toString().isEmpty) {
              Constant.session.setData(SessionManager.appThemeName, Constant.themeList[0], false);
              Constant.session.setBoolData(SessionManager.isDarkTheme, window.platformBrightness == Brightness.dark, false);
            }

            // This callback is called every time the brightness changes from the device.
            window.onPlatformBrightnessChanged = () {
              if (Constant.session.getData(SessionManager.appThemeName) == Constant.themeList[0]) {
                Constant.session.setBoolData(SessionManager.isDarkTheme, window.platformBrightness == Brightness.dark, true);
              }
            };

            Locale? currLang;
            try {
              currLang = Constant.session.getCurrLang();
            } catch (e) {}

            return MaterialApp(
              navigatorKey: Constant.navigatorKay,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: "/",
              scrollBehavior: ScrollGlowBehavior(),
              debugShowCheckedModeBanner: false,
              locale: currLang ?? Locale("en"),
              title: "eGrocer",
              theme: ColorsRes.setAppTheme(),
              home: const SplashScreen(),
              localizationsDelegates: const [
                TranslationsDelegate(),
                CountryLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: Constant.supportedLanguages.map(
                (languageCode) {
                  return GeneralMethods.getLocaleFromLangCode(languageCode);
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}

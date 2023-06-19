import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:egrocer/screens/getLocationScreen.dart';
import 'package:flutter/cupertino.dart';

const String introSliderScreen = 'introSliderScreen';
const String splashScreen = 'splashScreen';
const String loginScreen = 'loginScreen';
const String webViewScreen = 'webViewScreen';
const String otpScreen = 'otpScreen';
const String editProfileScreen = 'editProfileScreen';
const String getLocationScreen = 'getLocationScreen';
const String confirmLocationScreen = 'confirmLocationScreen';
const String mainHomeScreen = 'mainHomeScreen';
const String homeScreen = 'homeScreen';
const String categoryScreen = 'categoryScreen';
const String wishlistScreen = 'wishlistScreen';
const String cartScreen = 'cartScreen';
const String checkoutScreen = 'checkoutScreen';
const String promoCodeScreen = 'promoCodeScreen';
const String productListScreen = 'productListScreen';
const String productSearchScreen = 'productSearchScreen';
const String productListFilterScreen = 'productListFilterScreen';
const String productDetailScreen = 'productDetailScreen';
const String fullScreenProductImageScreen = 'fullScreenProductImageScreen';
const String addressListScreen = 'addressListScreen';
const String addressDetailScreen = 'addressDetailScreen';
const String orderDetailScreen = 'orderDetailScreen';
const String orderHistoryScreen = 'orderHistoryScreen';
const String notificationListScreen = 'notificationListScreen';
const String transactionListScreen = 'transactionListScreen';
const String faqListScreen = 'faqListScreen';
const String orderPlaceScreen = 'orderPlaceScreen';
const String notificationsAndMailSettingsScreenScreen = 'notificationsAndMailSettingsScreenScreen';
const String underMaintenanceScreen = 'underMaintenanceScreen';
const String appUpdateScreen = 'appUpdateScreen';
const String paypalPaymentScreen = 'paypalPaymentScreen';

String currentRoute = splashScreen;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "";

    switch (settings.name) {
      case introSliderScreen:
        return CupertinoPageRoute(
          builder: (_) => const IntroSliderScreen(),
        );

      case splashScreen:
        return CupertinoPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case loginScreen:
        return CupertinoPageRoute(
          builder: (_) => const LoginAccount(),
        );

      case webViewScreen:
        return CupertinoPageRoute(
          builder: (_) => WebViewScreen(dataFor: settings.arguments as String),
        );

      case otpScreen:
        List<dynamic> firebaseArguments = settings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => OtpVerificationScreen(firebaseAuth: firebaseArguments[0] as FirebaseAuth, otpVerificationId: firebaseArguments[1] as String, phoneNumber: firebaseArguments[2] as String, selectedCountryCode: firebaseArguments[3] as CountryCode),
        );

      case editProfileScreen:
        return CupertinoPageRoute(
          builder: (_) => EditProfile(from: settings.arguments as String),
        );

      case getLocationScreen:
        return CupertinoPageRoute(
          builder: (_) => GetLocation(from: settings.arguments as String),
        );

      case confirmLocationScreen:
        List<dynamic> confirmLocationArguments = settings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ConfirmLocation(
            address: confirmLocationArguments[0],
            from: confirmLocationArguments[1] as String,
          ),
        );

      case mainHomeScreen:
        return CupertinoPageRoute(
          builder: (_) => HomeMainScreen(/*key: Constant.bottomNavigationKey*/),
        );

      case cartScreen:
        return CupertinoPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => PromoCodeProvider(),
              ),
            ],
            child: const CartListScreen(),
          ),
        );

      case checkoutScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<CheckoutProvider>(
            create: (context) => CheckoutProvider(),
            child: const CheckoutScreen(),
          ),
        );

      case promoCodeScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<PromoCodeProvider>(
            create: (context) => PromoCodeProvider(),
            child: PromoCodeListScreen(amount: settings.arguments as double),
          ),
        );

      case productListScreen:
        List<dynamic> productListArguments = settings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ProductListProvider>(
            create: (context) => ProductListProvider(),
            child: ProductListScreen(
              from: productListArguments[0] as String,
              id: productListArguments[1] as String,
              title: GeneralMethods.setFirstLetterUppercase(
                productListArguments[2],
              ),
            ),
          ),
        );

      case productSearchScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ProductSearchProvider>(
            create: (context) => ProductSearchProvider(),
            child: const ProductSearchScreen(),
          ),
        );

      case productListFilterScreen:
        List<dynamic> productListFilterArguments = settings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ProductFilterProvider>(
            create: (context) => ProductFilterProvider(),
            child: ProductListFilterScreen(
              brands: productListFilterArguments[0] as List<Brands>,
              maxPrice: productListFilterArguments[1] as double,
              minPrice: productListFilterArguments[2] as double,
              sizes: productListFilterArguments[3] as List<Sizes>,
            ),
          ),
        );

      case productDetailScreen:
        List<dynamic> productDetailArguments = settings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ProductDetailProvider>(
            create: (context) => ProductDetailProvider(),
            child: ProductDetailScreen(
              id: productDetailArguments[0] as String,
              title: productDetailArguments[1] as String,
              productListItem: productDetailArguments[2],
            ),
          ),
        );

      case fullScreenProductImageScreen:
        List<dynamic> productFullScreenImagesScreen = settings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ProductFullScreenImagesScreen(
            initialPage: productFullScreenImagesScreen[0] as int,
            images: productFullScreenImagesScreen[1] as List<String>,
          ),
        );

      case addressListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<AddressProvider>(
            create: (context) => AddressProvider(),
            child: AddressListScreen(
              from: settings.arguments as String,
            ),
          ),
        );

      case addressDetailScreen:
        List<dynamic> addressDetailArguments = settings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<AddressProvider>(
            create: (context) => AddressProvider(),
            child: AddressDetailScreen(
              address: addressDetailArguments[0],
              addressProviderContext: addressDetailArguments[1] as BuildContext,
            ),
          ),
        );

      case orderHistoryScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<ActiveOrdersProvider>(
            create: (context) => ActiveOrdersProvider(),
            child: const OrdersHistoryScreen(),
          ),
        );

      case orderDetailScreen:
        List<dynamic> orderDetailScreenArguments = settings.arguments as List<dynamic>;
        return CupertinoPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => OrderInvoiceProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => CurrentOrderProvider(),
              )
            ],
            child: OrderSummaryScreen(
              order: orderDetailScreenArguments[0] as Order,
            ),
          ),
        );

      case notificationListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<NotificationProvider>(
            create: (context) => NotificationProvider(),
            child: const NotificationListScreen(),
          ),
        );

      case transactionListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<TransactionProvider>(
            create: (context) => TransactionProvider(),
            child: const TransactionListScreen(),
          ),
        );

      case faqListScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<FaqProvider>(
            create: (context) => FaqProvider(),
            child: const FaqListScreen(),
          ),
        );

      case notificationsAndMailSettingsScreenScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<NotificationsSettingsProvider>(
            create: (context) => NotificationsSettingsProvider(),
            child: const NotificationsAndMailSettingsScreenScreen(),
          ),
        );

      case orderPlaceScreen:
        return CupertinoPageRoute(
          builder: (_) => const OrderPlacedScreen(),
        );

      case underMaintenanceScreen:
        return CupertinoPageRoute(
          builder: (_) => const UnderMaintenanceScreen(),
        );

      case appUpdateScreen:
        return CupertinoPageRoute(
          builder: (_) => AppUpdateScreen(canIgnoreUpdate: settings.arguments as bool),
        );

      case paypalPaymentScreen:
        return CupertinoPageRoute(
          builder: (_) => PayPalPaymentScreen(paymentUrl: settings.arguments as String),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

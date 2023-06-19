import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:flutter/cupertino.dart';

class PayPalPaymentScreen extends StatefulWidget {
  final String paymentUrl;

  const PayPalPaymentScreen({Key? key, required this.paymentUrl}) : super(key: key);

  static Route route(RouteSettings settings) {
    Map arguments = settings.arguments as Map;
    return CupertinoPageRoute(builder: ((context) {
      return PayPalPaymentScreen(paymentUrl: arguments["paymentURL"]);
    }));
  }

  @override
  State<PayPalPaymentScreen> createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
  WebViewController? webViewController;

  DateTime? currentBackPressTime;

  @override
  void initState() {
    print("URL is ${widget.paymentUrl}");
    /* flutterWebViewPlugin.onUrlChanged.listen((url) {
      //Paypal success redirect url - Constant.baseUrl/customer/paypal_redirect/success
      //Paypal fail redirect url - Constant.baseUrl/customer/paypal_redirect/fail

      if (url.startsWith(Constant.baseUrl)) {
        String redirectUrl = url.split("?")[0];
        String paymentStatus = redirectUrl.split("/").last;
        if (paymentStatus.toLowerCase() == "success") {
          Navigator.pop(context, true);
        } else if (paymentStatus.toLowerCase() == "fail") {
          Navigator.pop(context, false);
        }
      }
    });*/
    super.initState();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      GeneralMethods.showMessage(context, getTranslatedValue(context, "doNotPressBackWhilePaymentAndDoubleTapBackButtonToExit"), MessageType.warning);

      return Future.value(false);
    }
    Navigator.pop(context, {"paymentStatus": "Failed"});
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: getAppBar(
            context: context,
            title: Text(
              getTranslatedValue(context, "lblAppName"),
              softWrap: true,
              style: TextStyle(color: ColorsRes.mainTextColor),
            ),
          ),
          body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(Theme.of(context).colorScheme.primaryContainer)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith(Constant.baseUrl)) {
                      String redirectUrl = request.url.split("?")[0];
                      String paymentStatus = redirectUrl.split("/").last;
                      if (paymentStatus.toLowerCase() == "success") {
                        Navigator.pop(context, true);
                        return NavigationDecision.navigate;
                      } else if (paymentStatus.toLowerCase() == "fail") {
                        Navigator.pop(context, false);
                        return NavigationDecision.navigate;
                      }
                    }
                    return NavigationDecision.navigate;
                  },
                  onUrlChange: (request) {
                    if (request.url != null) {
                      if (request.url!.startsWith(Constant.baseUrl)) {
                        String redirectUrl = request.url!.split("?")[0];
                        String paymentStatus = redirectUrl.split("/").last;
                        if (paymentStatus.toLowerCase() == "success") {
                          Navigator.pop(context, true);
                        } else if (paymentStatus.toLowerCase() == "fail") {
                          Navigator.pop(context, false);
                        }
                      }
                    }
                  },
                ),
              )
              ..loadRequest(Uri.parse(widget.paymentUrl.toString())),
          ),
        ),
      ),
    );
  }
}

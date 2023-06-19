import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:lottie/lottie.dart';

class OrderSwipeButton extends StatefulWidget {
  final BuildContext context;
  final bool isEnabled;

  const OrderSwipeButton({Key? key, required this.context, required this.isEnabled}) : super(key: key);

  @override
  State<OrderSwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<OrderSwipeButton> {
  bool isPaymentUnderProcessing = false;
  final Razorpay _razorpay = Razorpay();
  late String razorpayKey = "";
  late String paystackKey = "";
  late double amount = 0.00;
  late PaystackPlugin paystackPlugin;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      paystackPlugin = PaystackPlugin();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleRazorPayPaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleRazorPayPaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleRazorPayExternalWallet);
    });
  }

  void _handleRazorPayPaymentSuccess(PaymentSuccessResponse response) {
    context.read<CheckoutProvider>().transactionId = response.paymentId.toString();
    context.read<CheckoutProvider>().addTransaction(context: context);
  }

  void _handleRazorPayPaymentError(PaymentFailureResponse response) {
    Map<dynamic, dynamic> message = jsonDecode(response.message ?? "")["error"];
    GeneralMethods.showSnackBarMsg(context, message["description"]);
    setState(() {
      isPaymentUnderProcessing = false;
    });
  }

  void _handleRazorPayExternalWallet(ExternalWalletResponse response) {
    GeneralMethods.showSnackBarMsg(context, response.toString());
    setState(() {
      isPaymentUnderProcessing = false;
    });
  }

  void openRazorPayGateway() async {
    final options = {
      'key': razorpayKey, //this should be come from server
      'order_id': context.read<CheckoutProvider>().razorpayOrderId,
      'amount': (amount * 100).toInt(),
      'name': getTranslatedValue(
        context,
        "lblAppName",
      ),
      'currency': 'INR',
      'prefill': {'contact': Constant.session.getData(SessionManager.keyPhone), 'email': Constant.session.getData(SessionManager.keyEmail)}
    };

    _razorpay.open(options);
  }

  // Using package flutter_paystack
  Future openPaystackPaymentGateway() async {
    await paystackPlugin.initialize(publicKey: context.read<CheckoutProvider>().paymentMethodsData?.paystackPublicKey ?? "0");

    Charge charge = Charge()
      ..amount = (amount * 100).toInt()
      ..currency = context.read<CheckoutProvider>().paymentMethodsData?.paystackCurrencyCode ?? ""
      ..reference = context.read<CheckoutProvider>().payStackReference
      ..email = Constant.session.getData(SessionManager.keyEmail);

    CheckoutResponse response = await paystackPlugin.checkout(
      context,
      fullscreen: false,
      logo: Widgets.defaultImg(
        height: 50,
        width: 50,
        image: "logo",
      ),
      method: CheckoutMethod.card,
      charge: charge,
    );

    if (response.status) {
      context.read<CheckoutProvider>().addTransaction(context: context);
    } else {
      setState(() {
        isPaymentUnderProcessing = false;
      });
      GeneralMethods.showSnackBarMsg(context, response.message);
    }
  }

  //Paytm Payment Gateway
  openPaytmPaymentGateway() async {
    try {
      GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiPaytmTransactionToken, params: {ApiAndParams.orderId: context.read<CheckoutProvider>().placedOrderId, ApiAndParams.amount: context.read<CheckoutProvider>().totalAmount.toString()}, isPost: false, context: context).then((value) async {
        await Paytm.payWithPaytm(mId: context.read<CheckoutProvider>().paymentMethodsData?.paytmMerchantId ?? "", orderId: context.read<CheckoutProvider>().placedOrderId, txnToken: context.read<CheckoutProvider>().paytmTxnToken, txnAmount: context.read<CheckoutProvider>().totalAmount.toString(), callBackUrl: '${context.read<CheckoutProvider>().paymentMethodsData?.paytmMode == "sandbox" ? 'https://securegw-stage.paytm.in' : 'https://securegw.paytm.in'}/theia/paytmCallback?ORDER_ID=${context.read<CheckoutProvider>().placedOrderId}', staging: context.read<CheckoutProvider>().paymentMethodsData?.paytmMode == "sandbox", appInvokeEnabled: false).then((value) {
          Map<dynamic, dynamic> response = value["response"];
          if (response["STATUS"] == "TXN_SUCCESS") {
            print("$response");
            context.read<CheckoutProvider>().transactionId = response["TXNID"].toString();
            context.read<CheckoutProvider>().addTransaction(context: context);
          } else {
            GeneralMethods.showSnackBarMsg(context, response["STATUS"]);
            setState(() {
              isPaymentUnderProcessing = false;
            });
          }
        });
      });
    } catch (e) {
      GeneralMethods.showSnackBarMsg(context, e.toString());
      setState(() {
        isPaymentUnderProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isEnabled
        ? Padding(
            padding: EdgeInsetsDirectional.fromSTEB(Constant.size10, 0, Constant.size10, Constant.size10),
            child: SwipeButton(
              borderRadius: BorderRadius.all(Radius.circular(Constant.size5)),
              thumb: Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size10),
                decoration: DesignConfig.boxGradient(
                  8,
                  color1: (!isPaymentUnderProcessing && context.read<CheckoutProvider>().selectedAddress?.id != null) ? ColorsRes.gradient1 : ColorsRes.grey,
                  color2: (!isPaymentUnderProcessing && context.read<CheckoutProvider>().selectedAddress?.id != null) ? ColorsRes.gradient2 : ColorsRes.grey,
                  isSetShadow: false,
                ),
                child: Lottie.asset(
                  Constant.getAssetsPath(3, "swipe_to_order"),
                ),
              ),
              thumbPadding: EdgeInsets.all(Constant.size3),
              height: 60,
              enabled: (!isPaymentUnderProcessing && context.read<CheckoutProvider>().selectedAddress?.id != null),
              activeTrackColor: ColorsRes.appColorLight,
              activeThumbColor: ColorsRes.appColorLight,
              inactiveThumbColor: ColorsRes.grey,
              inactiveTrackColor: ColorsRes.grey,
              onSwipe: () {
                if (context.read<CheckoutProvider>().selectedPaymentMethod == "COD") {
                  context.read<CheckoutProvider>().placeOrder(context: context);
                } else if (context.read<CheckoutProvider>().selectedPaymentMethod == "Razorpay") {
                  razorpayKey = context.read<CheckoutProvider>().paymentMethodsData?.razorpayKey ?? "0";
                  amount = double.parse(context.read<CheckoutProvider>().deliveryChargeData?.totalAmount ?? "0");
                  context.read<CheckoutProvider>().placeOrder(context: context).then((value) {
                    if (value) {
                      context.read<CheckoutProvider>().initiateRazorpayTransaction(context: context).then((value) => openRazorPayGateway());
                    }
                  });
                } else if (context.read<CheckoutProvider>().selectedPaymentMethod == "Paystack") {
                  amount = double.parse(context.read<CheckoutProvider>().deliveryChargeData?.totalAmount ?? "0");
                  context.read<CheckoutProvider>().placeOrder(context: context).then((value) {
                    if (value) {
                      return openPaystackPaymentGateway();
                    }
                  });
                } else if (context.read<CheckoutProvider>().selectedPaymentMethod == "Stripe") {
                  amount = double.parse(context.read<CheckoutProvider>().deliveryChargeData?.totalAmount ?? "0");

                  context.read<CheckoutProvider>().placeOrder(context: context).then((value) {
                    if (value) {
                      StripeService.payWithPaymentSheet(
                        amount: int.parse((amount * 100).toStringAsFixed(0)),
                        isTestEnvironment: true,
                        awaitedOrderId: context.read<CheckoutProvider>().placedOrderId,
                        context: context,
                        currency: context.read<CheckoutProvider>().paymentMethods?.data.stripeCurrencyCode ?? "0",
                      ).then((value) {
                        print(">>>>>>>>>> ${value.message}, ${value.status},${value.success}");
                        if (!value.success!) {
                          setState(() {
                            isPaymentUnderProcessing = false;
                          });
                          GeneralMethods.showSnackBarMsg(
                            context,
                            getTranslatedValue(context, "lblPaymentCancelledByUser"),
                          );
                        }
                      });
                    }
                  });
                } else if (context.read<CheckoutProvider>().selectedPaymentMethod == "Paytm") {
                  amount = double.parse(context.read<CheckoutProvider>().deliveryChargeData?.totalAmount ?? "0");

                  context.read<CheckoutProvider>().placeOrder(context: context).then((value) {
                    if (value is bool) {
                      setState(() {
                        isPaymentUnderProcessing = false;
                      });
                      GeneralMethods.showSnackBarMsg(
                        context,
                        getTranslatedValue(context, "lblSomethingWentWrong"),
                      );
                    } else {
                      openPaytmPaymentGateway();
                    }
                  });
                } else if (context.read<CheckoutProvider>().selectedPaymentMethod == "Paypal") {
                  amount = double.parse(context.read<CheckoutProvider>().deliveryChargeData?.totalAmount ?? "0");
                  context.read<CheckoutProvider>().placeOrder(context: context).then((value) {
                    if (value is bool) {
                      setState(() {
                        isPaymentUnderProcessing = false;
                      });
                    }
                  });
                }

                setState(() {
                  isPaymentUnderProcessing = true;
                });
              },
              child: isPaymentUnderProcessing
                  ? CircularProgressIndicator(color: ColorsRes.appColorWhite)
                  : Text(
                      (context.read<CheckoutProvider>().checkoutAddressState == CheckoutAddressState.addressBlank || context.read<CheckoutProvider>().selectedAddress?.id == null)
                          ? getTranslatedValue(
                              context,
                              "lblUnableToCheckout",
                            )
                          : getTranslatedValue(
                              context,
                              "lblSwipeToPlaceOrder",
                            ),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: (widget.isEnabled && !isPaymentUnderProcessing && context.read<CheckoutProvider>().selectedAddress?.id != null) ? ColorsRes.appColor : ColorsRes.mainTextColor,
                            fontSize: 16,
                          ),
                    ),
            ),
          )
        : CustomShimmer(
            width: MediaQuery.of(context).size.width,
            height: Constant.size60,
            margin: EdgeInsets.all(10),
            borderRadius: 5,
          );
  }
}

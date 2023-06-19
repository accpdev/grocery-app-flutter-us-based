import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:egrocer/screens/cartListScreen/screens/promoCodeScreen/widget/customPromoCodeDialog.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({Key? key}) : super(key: key);

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();

    Constant.isPromoCodeApplied = false;
    Constant.selectedCoupon = "";
    Constant.discountedAmount = 0.0;
    Constant.discount = 0.0;

    //fetch cartList from api
    Future.delayed(Duration.zero).then((value) async {
      await context.read<CartProvider>().getCartListProvider(context: context);
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context: context,
          title: Text(
            getTranslatedValue(
              context,
              "lblCart",
            ),
            softWrap: true,
            style: TextStyle(color: ColorsRes.mainTextColor),
          )),
      body: setRefreshIndicator(
        refreshCallback: () async {
          await context.read<CartProvider>().getCartListProvider(context: context);
        },
        child: Stack(
          children: [
            (context.watch<CartListProvider>().cartList.isNotEmpty || context.read<CartProvider>().cartState == CartState.error)
                ? cartWidget()
                : PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    bottom: 0,
                    child: DefaultBlankItemMessageScreen(
                      image: "cart_empty",
                      title: getTranslatedValue(
                        context,
                        "lblEmptyCartListMessage",
                      ),
                      description: getTranslatedValue(
                        context,
                        "lblEmptyCartListDescription",
                      ),
                      btntext: getTranslatedValue(
                        context,
                        "lblEmptyCartListButtonName",
                      ),
                      callback: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  btnWidget() {
    return Widgets.gradientBtnWidget(context, 10, isSetShadow: false, callback: () {
      Navigator.pushNamed(context, checkoutScreen);
    },
        otherWidgets: Text(
          getTranslatedValue(
            context,
            "lblProceedToCheckout",
          ),
          softWrap: true,
          style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(color: ColorsRes.appColorWhite, letterSpacing: 0.5, fontWeight: FontWeight.w500)),
        ));
  }

  cartWidget() {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return (cartProvider.cartState == CartState.initial || cartProvider.cartState == CartState.loading)
            ? getCartListShimmer(
                context: context,
              )
            : (cartProvider.cartState == CartState.loaded)
                ? Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsetsDirectional.only(bottom: Constant.size10),
                          children: List.generate(
                            cartProvider.cartData.data.cart.length,
                            (index) {
                              Cart cart = cartProvider.cartData.data.cart[index];
                              return Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: Constant.size10,
                                  end: Constant.size10,
                                ),
                                child: CartListItemContainer(
                                  cart: cart,
                                  from: 'cartList',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.all(Constant.size10),
                        margin: EdgeInsetsDirectional.only(bottom: Constant.size10, start: Constant.size10, end: Constant.size10),
                        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: Constant.borderRadius10),
                        child: Column(
                          children: [
                            Consumer<PromoCodeProvider>(
                              builder: (context, promoCodeProvider, _) {
                                return promoCodeLayoutWidget(context);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              textDirection: Directionality.of(context),
                              children: [
                                Text("${getTranslatedValue(context, "lblSubTotal")} (${cartProvider.cartData.data.cart.length} ${cartProvider.cartData.data.cart.length > 1 ? getTranslatedValue(context, "lblItems") : getTranslatedValue(context, "lblItem")})", softWrap: true, style: const TextStyle(fontSize: 17)),
                                if (Constant.isPromoCodeApplied == true)
                                  Text(
                                    "${GeneralMethods.getCurrencyFormat(Constant.discountedAmount)}",
                                    softWrap: true,
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                if (Constant.isPromoCodeApplied == false)
                                  Text(
                                    "${GeneralMethods.getCurrencyFormat(double.parse(cartProvider.subTotal.toString()))}",
                                    softWrap: true,
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            btnWidget()
                          ],
                        ),
                      )
                    ],
                  )
                : DefaultBlankItemMessageScreen(
                    title: getTranslatedValue(
                      context,
                      "lblEmptyCartListMessage",
                    ),
                    description: getTranslatedValue(
                      context,
                      "lblEmptyCartListDescription",
                    ),
                    btntext: getTranslatedValue(
                      context,
                      "lblEmptyCartListButtonName",
                    ),
                    callback: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        mainHomeScreen,
                        (Route<dynamic> route) => false,
                      );
                    },
                    image: "no_product_icon",
                  );
      },
    );
  }

  promoCodeLayoutWidget(BuildContext context) {
    return Consumer<PromoCodeProvider>(
      builder: (context, promoCodeProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, promoCodeScreen, arguments: context.read<CartProvider>().subTotal).then((value) {
                  if (value == true) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CustomPromoCodeDialog(
                          couponAmount: Constant.discount,
                          couponCode: Constant.selectedCoupon,
                        );
                      },
                    );
                  } else {
                    Constant.selectedCoupon = "";
                    Constant.discountedAmount = 0.0;
                    Constant.discount = 0.0;
                    Constant.isPromoCodeApplied = false;
                  }
                  setState(() {});
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 45,
                    decoration: DesignConfig.boxDecoration(ColorsRes.appColor.withOpacity(0.2), 10),
                    child: DashedRect(
                      color: ColorsRes.appColor,
                      strokeWidth: 1.0,
                      gap: 10,
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: CircleAvatar(
                            backgroundColor: ColorsRes.appColor,
                            radius: 100,
                            child: Widgets.defaultImg(
                              image: "discount_coupon_icon",
                              height: 15,
                              width: 15,
                              iconColor: ColorsRes.mainIconColor,
                            ),
                          )),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          Constant.isPromoCodeApplied == true
                              ? Constant.selectedCoupon
                              : getTranslatedValue(
                                  context,
                                  "lblApplyDiscountCode",
                                ),
                          softWrap: true,
                        ),
                      ),
                      if (Constant.isPromoCodeApplied)
                        Text(
                          getTranslatedValue(
                            context,
                            "lblChangeCoupon",
                          ),
                          style: TextStyle(color: ColorsRes.appColor),
                        ),
                      const SizedBox(width: 12),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (Constant.isPromoCodeApplied == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: Directionality.of(context),
                children: [
                  Text(
                    "${getTranslatedValue(
                      context,
                      "lblCoupon",
                    )} (${Constant.selectedCoupon})",
                    softWrap: true,
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text(
                    "-${GeneralMethods.getCurrencyFormat(Constant.discount)}",
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  getCartListShimmer({required BuildContext context}) {
    return ListView(
      children: List.generate(10, (index) {
        return const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
          child: CustomShimmer(
            width: double.maxFinite,
            height: 125,
          ),
        );
      }),
    );
  }
}

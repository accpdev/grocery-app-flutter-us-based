import 'package:egrocer/helper/utils/generalImports.dart';

getDeliveryCharges(BuildContext context) {
  return Container(
    padding: EdgeInsetsDirectional.all(Constant.size10),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: Constant.borderRadius10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslatedValue(
            context,
            "lblOrderSummary",
          ),
          softWrap: true,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorsRes.mainTextColor,
          ),
        ),
        Widgets.getSizedBox(
          height: Constant.size5,
        ),
        Divider(color: ColorsRes.grey, height: 1, thickness: 0.1),
        Widgets.getSizedBox(
          height: Constant.size5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                getTranslatedValue(
                  context,
                  "lblSubTotal",
                ),
                softWrap: true,
                style: const TextStyle(fontSize: 17)),
            Text(
              GeneralMethods.getCurrencyFormat(context.read<CheckoutProvider>().subTotalAmount),
              softWrap: true,
              style: const TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
        Widgets.getSizedBox(
          height: Constant.size7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                    getTranslatedValue(
                      context,
                      "lblDeliveryCharge",
                    ),
                    softWrap: true,
                    style: const TextStyle(fontSize: 17)),
                GestureDetector(
                  onTapDown: (details) async {
                    await showMenu(
                      color: Theme.of(context).cardColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                      context: context,
                      position: RelativeRect.fromLTRB(
                        details.globalPosition.dx,
                        details.globalPosition.dy - 60,
                        details.globalPosition.dx,
                        details.globalPosition.dy,
                      ),
                      items: List.generate(
                        (context.read<CheckoutProvider>().sellerWiseDeliveryCharges?.length ?? 0) + 1,
                        (index) => PopupMenuItem(
                          child: index == 0
                              ? Column(
                                  children: [
                                    Text(
                                      getTranslatedValue(
                                        context,
                                        "lblSellerWiseDeliveryChargesDetail",
                                      ),
                                      softWrap: true,
                                      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      context.read<CheckoutProvider>().sellerWiseDeliveryCharges?[index - 1].sellerName.toString() ?? "0",
                                      softWrap: true,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      GeneralMethods.getCurrencyFormat(
                                        double.parse(
                                          context.read<CheckoutProvider>().sellerWiseDeliveryCharges?[index - 1].deliveryCharge.toString() ?? "0",
                                        ),
                                      ),
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      elevation: 8.0,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 2,
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              GeneralMethods.getCurrencyFormat(context.read<CheckoutProvider>().deliveryCharge),
              softWrap: true,
              style: const TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
        if (Constant.isPromoCodeApplied)
          Widgets.getSizedBox(
            height: Constant.size7,
          ),
        if (Constant.isPromoCodeApplied)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${getTranslatedValue(context, "lblDiscount")}(${Constant.selectedCoupon})",
                softWrap: true,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              Text(
                "-${GeneralMethods.getCurrencyFormat(
                  double.parse(
                    context.read<CheckoutProvider>().deliveryChargeData?.promocodeDetails?.discount ?? "0",
                  ),
                )}",
                softWrap: true,
                style: const TextStyle(
                  fontSize: 17,
                ),
              )
            ],
          ),
        Widgets.getSizedBox(
          height: Constant.size5,
        ),
        Divider(color: ColorsRes.grey, height: 1, thickness: 0.1),
        Widgets.getSizedBox(
          height: Constant.size5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                getTranslatedValue(
                  context,
                  "lblTotal",
                ),
                softWrap: true,
                style: const TextStyle(fontSize: 17)),
            Text(
              GeneralMethods.getCurrencyFormat(context.read<CheckoutProvider>().totalAmount),
              softWrap: true,
              style: TextStyle(
                fontSize: 17,
                color: ColorsRes.appColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

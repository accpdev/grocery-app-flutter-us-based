import 'package:egrocer/helper/utils/generalImports.dart';

getPaymentMethods(PaymentMethodsData? paymentMethodsData, BuildContext context) {
  return paymentMethodsData != null
      ? Card(
          color: Theme.of(context).cardColor,
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(Constant.size10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    getTranslatedValue(
                      context,
                      "lblPaymentMethod",
                    ),
                    softWrap: true,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ColorsRes.mainTextColor)),
                Widgets.getSizedBox(
                  height: Constant.size5,
                ),
                Divider(color: ColorsRes.grey, height: 1, thickness: 0.1),
                Widgets.getSizedBox(
                  height: Constant.size5,
                ),
                Column(
                  children: [
                    if (paymentMethodsData.codPaymentMethod == "1" && context.read<CheckoutProvider>().isCodAllowed == true)
                      GestureDetector(
                        onTap: () {
                          context.read<CheckoutProvider>().setSelectedPaymentMethod("COD");
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.symmetric(vertical: Constant.size5),
                          decoration: BoxDecoration(
                              color: context.read<CheckoutProvider>().selectedPaymentMethod == "COD"
                                  ? Constant.session.getBoolData(SessionManager.isDarkTheme)
                                      ? ColorsRes.appColorBlack
                                      : ColorsRes.appColorWhite
                                  : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              borderRadius: Constant.borderRadius7,
                              border: Border.all(
                                width: context.read<CheckoutProvider>().selectedPaymentMethod == "COD" ? 1 : 0.3,
                                color: context.read<CheckoutProvider>().selectedPaymentMethod == "COD" ? ColorsRes.appColor : ColorsRes.grey,
                              )),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Widgets.defaultImg(image: "ic_cod", width: 25, height: 25),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Text(getTranslatedValue(
                                  context,
                                  "lblCashOnDelivery",
                                )),
                              ),
                              const Spacer(),
                              Radio(
                                value: "COD",
                                groupValue: context.read<CheckoutProvider>().selectedPaymentMethod,
                                activeColor: ColorsRes.appColor,
                                onChanged: (value) {
                                  context.read<CheckoutProvider>().setSelectedPaymentMethod("COD");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (paymentMethodsData.razorpayPaymentMethod == "1")
                      GestureDetector(
                        onTap: () {
                          context.read<CheckoutProvider>().setSelectedPaymentMethod("Razorpay");
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.symmetric(vertical: Constant.size5),
                          decoration: BoxDecoration(
                              color: context.read<CheckoutProvider>().selectedPaymentMethod == "Razorpay"
                                  ? Constant.session.getBoolData(SessionManager.isDarkTheme)
                                      ? ColorsRes.appColorBlack
                                      : ColorsRes.appColorWhite
                                  : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              borderRadius: Constant.borderRadius7,
                              border: Border.all(
                                width: context.read<CheckoutProvider>().selectedPaymentMethod == "Razorpay" ? 1 : 0.3,
                                color: context.read<CheckoutProvider>().selectedPaymentMethod == "Razorpay" ? ColorsRes.appColor : ColorsRes.grey,
                              )),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Widgets.defaultImg(image: "ic_razorpay", width: 25, height: 25),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Text(getTranslatedValue(
                                  context,
                                  "lblRazorpay",
                                )),
                              ),
                              const Spacer(),
                              Radio(
                                value: "Razorpay",
                                groupValue: context.read<CheckoutProvider>().selectedPaymentMethod,
                                activeColor: ColorsRes.appColor,
                                onChanged: (value) {
                                  context.read<CheckoutProvider>().setSelectedPaymentMethod("Razorpay");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (paymentMethodsData.paystackPaymentMethod == "1")
                      GestureDetector(
                        onTap: () {
                          context.read<CheckoutProvider>().setSelectedPaymentMethod("Paystack");
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.symmetric(vertical: Constant.size5),
                          decoration: BoxDecoration(
                              color: context.read<CheckoutProvider>().selectedPaymentMethod == "Paystack"
                                  ? Constant.session.getBoolData(SessionManager.isDarkTheme)
                                      ? ColorsRes.appColorBlack
                                      : ColorsRes.appColorWhite
                                  : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              borderRadius: Constant.borderRadius7,
                              border: Border.all(
                                width: context.read<CheckoutProvider>().selectedPaymentMethod == "Paystack" ? 1 : 0.3,
                                color: context.read<CheckoutProvider>().selectedPaymentMethod == "Paystack" ? ColorsRes.appColor : ColorsRes.grey,
                              )),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Widgets.defaultImg(image: "ic_paystack", width: 25, height: 25),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Text(getTranslatedValue(
                                  context,
                                  "lblPaystack",
                                )),
                              ),
                              const Spacer(),
                              Radio(
                                value: "Paystack",
                                groupValue: context.read<CheckoutProvider>().selectedPaymentMethod,
                                activeColor: ColorsRes.appColor,
                                onChanged: (value) {
                                  context.read<CheckoutProvider>().setSelectedPaymentMethod("Paystack");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (paymentMethodsData.stripePaymentMethod == "1")
                      GestureDetector(
                        onTap: () {
                          context.read<CheckoutProvider>().setSelectedPaymentMethod("Stripe");
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.symmetric(vertical: Constant.size5),
                          decoration: BoxDecoration(
                              color: context.read<CheckoutProvider>().selectedPaymentMethod == "Stripe"
                                  ? Constant.session.getBoolData(SessionManager.isDarkTheme)
                                      ? ColorsRes.appColorBlack
                                      : ColorsRes.appColorWhite
                                  : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              borderRadius: Constant.borderRadius7,
                              border: Border.all(
                                width: context.read<CheckoutProvider>().selectedPaymentMethod == "Stripe" ? 1 : 0.3,
                                color: context.read<CheckoutProvider>().selectedPaymentMethod == "Stripe" ? ColorsRes.appColor : ColorsRes.grey,
                              )),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Widgets.defaultImg(image: "ic_stripe", width: 25, height: 25, iconColor: ColorsRes.mainTextColor),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Text(getTranslatedValue(
                                  context,
                                  "lblStripe",
                                )),
                              ),
                              const Spacer(),
                              Radio(
                                value: "Stripe",
                                groupValue: context.read<CheckoutProvider>().selectedPaymentMethod,
                                activeColor: ColorsRes.appColor,
                                onChanged: (value) {
                                  context.read<CheckoutProvider>().setSelectedPaymentMethod("Stripe");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (paymentMethodsData.paytmPaymentMethod == "1")
                      GestureDetector(
                        onTap: () {
                          context.read<CheckoutProvider>().setSelectedPaymentMethod("Paytm");
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.symmetric(vertical: Constant.size5),
                          decoration: BoxDecoration(
                              color: context.read<CheckoutProvider>().selectedPaymentMethod == "Paytm"
                                  ? Constant.session.getBoolData(SessionManager.isDarkTheme)
                                      ? ColorsRes.appColorBlack
                                      : ColorsRes.appColorWhite
                                  : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              borderRadius: Constant.borderRadius7,
                              border: Border.all(
                                width: context.read<CheckoutProvider>().selectedPaymentMethod == "Paytm" ? 1 : 0.3,
                                color: context.read<CheckoutProvider>().selectedPaymentMethod == "Paytm" ? ColorsRes.appColor : ColorsRes.grey,
                              )),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Widgets.defaultImg(image: "ic_paytm", width: 25, height: 25),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Text(getTranslatedValue(
                                  context,
                                  "lblPaytm",
                                )),
                              ),
                              const Spacer(),
                              Radio(
                                value: "Paytm",
                                groupValue: context.read<CheckoutProvider>().selectedPaymentMethod,
                                onChanged: (value) {
                                  context.read<CheckoutProvider>().setSelectedPaymentMethod("Paytm");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (paymentMethodsData.paypalPaymentMethod == "1")
                      GestureDetector(
                        onTap: () {
                          context.read<CheckoutProvider>().setSelectedPaymentMethod("Paypal");
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.symmetric(vertical: Constant.size5),
                          decoration: BoxDecoration(
                              color: context.read<CheckoutProvider>().selectedPaymentMethod == "Paypal"
                                  ? Constant.session.getBoolData(SessionManager.isDarkTheme)
                                      ? ColorsRes.appColorBlack
                                      : ColorsRes.appColorWhite
                                  : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                              borderRadius: Constant.borderRadius7,
                              border: Border.all(
                                width: context.read<CheckoutProvider>().selectedPaymentMethod == "Paypal" ? 1 : 0.3,
                                color: context.read<CheckoutProvider>().selectedPaymentMethod == "Paypal" ? ColorsRes.appColor : ColorsRes.grey,
                              )),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Widgets.defaultImg(image: "ic_paypal", width: 25, height: 25),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: Constant.size10),
                                child: Text(getTranslatedValue(
                                  context,
                                  "lblPaypal",
                                )),
                              ),
                              const Spacer(),
                              Radio(
                                value: "Paypal",
                                groupValue: context.read<CheckoutProvider>().selectedPaymentMethod,
                                onChanged: (value) {
                                  context.read<CheckoutProvider>().setSelectedPaymentMethod("Paypal");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        )
      : const SizedBox.shrink();
}

class PaymentMethods {
  PaymentMethods({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final String status;
  late final String message;
  late final String total;
  late final PaymentMethodsData data;

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = PaymentMethodsData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['status'] = status;
    itemData['message'] = message;
    itemData['total'] = total;
    itemData['data'] = data.toJson();
    return itemData;
  }
}

class PaymentMethodsData {
  PaymentMethodsData({
    required this.codPaymentMethod,
    required this.codMode,
    required this.razorpayPaymentMethod,
    required this.razorpayKey,
    required this.razorpaySecretKey,
    required this.paystackPaymentMethod,
    required this.paystackPublicKey,
    required this.paystackSecretKey,
    required this.paystackCurrencyCode,
  });

  late final String codPaymentMethod;
  late final String codMode;
  late final String razorpayPaymentMethod;
  late final String razorpayKey;
  late final String razorpaySecretKey;

  late final String paystackPaymentMethod;
  late final String paystackPublicKey;
  late final String paystackSecretKey;
  late final String paystackCurrencyCode;

  late final String stripePaymentMethod;
  late final String stripePublicKey;
  late final String stripeSecretKey;
  late final String stripeCurrencyCode;

  late final String paytmPaymentMethod;
  late final String paytmMerchantId;
  late final String paytmMerchantKey;
  late final String paytmMode;

  late final String paypalPaymentMethod;

  PaymentMethodsData.fromJson(Map<String, dynamic> json) {
    codPaymentMethod = json['cod_payment_method'].toString();
    codMode = json['cod_mode'].toString();

    razorpayPaymentMethod = json['razorpay_payment_method'].toString();
    razorpayKey = json['razorpay_key'].toString();
    razorpaySecretKey = json['razorpay_secret_key'].toString();

    paystackPaymentMethod = json['paystack_payment_method'].toString();
    paystackPublicKey = json['paystack_public_key'].toString();
    paystackSecretKey = json['paystack_secret_key'].toString();
    paystackCurrencyCode = json['paystack_currency_code'].toString();

    stripePaymentMethod = json['stripe_payment_method'].toString();
    stripePublicKey = json['stripe_publishable_key'].toString();
    stripeSecretKey = json['stripe_secret_key'].toString();
    stripeCurrencyCode = json['stripe_currency_code'].toString();

    paytmPaymentMethod = json['paytm_payment_method'].toString();
    paytmMerchantKey = json['paytm_merchant_key'].toString();
    paytmMerchantId = json['paytm_merchant_id'].toString();
    paytmMode = json['paytm_mode'].toString();

    paypalPaymentMethod = json['paypal_payment_method'].toString();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['cod_payment_method'] = codPaymentMethod;
    itemData['cod_mode'] = codMode;

    itemData['razorpay_payment_method'] = razorpayPaymentMethod;
    itemData['razorpay_key'] = razorpayKey;
    itemData['razorpay_secret_key'] = razorpaySecretKey;

    itemData['paystack_payment_method'] = paystackPaymentMethod;
    itemData['paystack_public_key'] = paystackPublicKey;
    itemData['paystack_secret_key'] = paystackSecretKey;
    itemData['paystack_currency_code'] = paystackCurrencyCode;

    itemData['stripe_payment_method'] = stripePaymentMethod;
    itemData['stripe_publishable_key'] = stripePublicKey;
    itemData['stripe_secret_key'] = stripeSecretKey;
    itemData['stripe_currency_code'] = stripeCurrencyCode;

    itemData['paytm_payment_method'] = paytmPaymentMethod;
    itemData['paytm_merchant_key'] = paytmMerchantKey;
    itemData['paytm_merchant_id'] = paytmMerchantId;
    itemData['paytm_mode'] = paytmMode;
    return itemData;
  }
}

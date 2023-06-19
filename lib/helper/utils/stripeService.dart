import 'dart:convert';

import 'package:egrocer/helper/provider/checkoutProvider.dart';
import 'package:egrocer/helper/utils/generalMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String? secret = '';

  static Map<String, String> headers = {'Authorization': 'Bearer ${StripeService.secret}', 'Content-Type': 'application/x-www-form-urlencoded'};

  static getHeaders() {
    return {'Authorization': 'Bearer ${StripeService.secret}', 'Content-Type': 'application/x-www-form-urlencoded'};
  }

  static init(String? stripeId, String? stripeMode) {
    Stripe.publishableKey = stripeId ?? '';
  }

  static Future<StripeTransactionResponse> payWithPaymentSheet({required int amount, required String currency, String? from, required bool isTestEnvironment, required BuildContext context, required String awaitedOrderId}) async {
    try {
      //create Payment intent
      var paymentIntent = await (StripeService.createPaymentIntent(amount: amount, currency: currency, from: from, context: context, awaitedOrderID: awaitedOrderId));
      //setting up Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'IN',
            testEnv: isTestEnvironment,
            currencyCode: currency, /*
                  testEnv: isTestEnvironment*/
          ),
          style: ThemeMode.light,
          merchantDisplayName: getTranslatedValue(context, "lblAppName"),
        ),
      );

      //open payment sheet
      await Stripe.instance.presentPaymentSheet();

      //store paymentID of customer
      //stripePayId = paymentIntent['id'];

      //confirm payment
      /*var response = await Dio().post(
          '${StripeService.paymentApiUrl}/${paymentIntent['id']}',
          options: Options(headers: headers));*/

      http.Response response = await http.post(
          Uri.parse(
            '${StripeService.paymentApiUrl}/${paymentIntent['id']}',
          ),
          headers: headers);

      var getdata = Map.from(json.decode(response.body));

      var statusOfTransaction = getdata['status'];

      if (statusOfTransaction == 'succeeded' || statusOfTransaction == 'pending' || statusOfTransaction == 'captured') {
        context.read<CheckoutProvider>().transactionId = getdata['id'];
        context.read<CheckoutProvider>().addTransaction(context: context);
        return StripeTransactionResponse(message: 'Transaction successful', success: true, status: statusOfTransaction);
      } else {
        return StripeTransactionResponse(message: 'Transaction failed', success: false, status: statusOfTransaction);
      }
    } catch (error) {
      return StripeTransactionResponse(message: 'Transaction failed: ${error.toString()}', success: false, status: 'fail');
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return StripeTransactionResponse(message: message, success: false, status: 'cancelled');
  }

  static Future<Map<String, dynamic>?> createPaymentIntent({required int amount, String? currency, String? from, BuildContext? context, String? awaitedOrderID}) async {
    try {
      Map<String, dynamic> parameter = {
        'amount': amount.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
        //      'description': from,
      };

      if (from == 'order') parameter['metadata[order_id]'] = awaitedOrderID;

      /*final Dio dio = Dio();*/
      // final FormData formData =
      //     FormData.fromMap(parameter, ListFormat.multiCompatible);
      print("API is ${StripeService.paymentApiUrl} \n para $parameter \n secret key $secret\n public key ${Stripe.publishableKey}");

      /*final response = await dio.post(StripeService.paymentApiUrl,
          data: parameter,
          options: Options(headers: StripeService.getHeaders()));*/

      http.Response response = await http.post(
          Uri.parse(
            StripeService.paymentApiUrl,
          ),
          body: parameter,
          headers: StripeService.getHeaders());
      return Map.from(json.decode(response.body));
    } catch (err) {}
    return null;
  }
}

class StripeTransactionResponse {
  final String? message, status;
  bool? success;

  StripeTransactionResponse({this.message, this.success, this.status});
}

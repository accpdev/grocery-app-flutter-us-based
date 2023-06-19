import 'package:egrocer/helper/utils/generalImports.dart';

//This is api for the razorpay transaction
Future<Map<String, dynamic>> getInitiatedTransactionApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiInitiateTransaction, params: params, isPost: true, context: context);
  return json.decode(response);
}

//This is api for the razorpay transaction
Future<Map<String, dynamic>> getPaytmTransactionTokenApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiPaytmTransactionToken, params: params, isPost: false, context: context);

  return json.decode(response);
}

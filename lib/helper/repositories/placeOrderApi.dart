import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getPlaceOrderApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiPlaceOrder, params: params, isPost: true, context: context);
  return json.decode(response);
}

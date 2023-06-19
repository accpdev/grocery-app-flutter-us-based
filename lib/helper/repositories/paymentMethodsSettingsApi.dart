import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getPaymentMethodsSettingsApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiPaymentMethodsSettings, params: params, isPost: false, context: context);
  return json.decode(response);
}

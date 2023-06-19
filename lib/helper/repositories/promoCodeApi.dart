import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getPromoCodeApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiPromoCode, params: params, isPost: false, context: context);

  return json.decode(response);
}

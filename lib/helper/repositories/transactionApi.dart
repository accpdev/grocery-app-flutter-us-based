import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getTransactionApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiTransaction, params: params, isPost: false, context: context);
  return json.decode(response);
}

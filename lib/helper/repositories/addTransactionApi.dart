import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getAddTransactionApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiAddTransaction, params: params, isPost: true, context: context);
  return json.decode(response);
}

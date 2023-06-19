import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getLoginApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiLogin, params: params, isPost: true, context: context);

  Map<String, dynamic> mainData = await json.decode(response);
  return mainData;
}

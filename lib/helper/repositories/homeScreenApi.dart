import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getHomeScreenDataApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiShop, params: params, isPost: false, context: context);

  Map<String, dynamic> mainData = await json.decode(response)["data"];

  return mainData;
}

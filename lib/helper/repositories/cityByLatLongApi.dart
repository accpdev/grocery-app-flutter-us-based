import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getCityByLatLongApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiCity,
    params: params,
    isPost: false,
    context: context,
  );

  Map<String, dynamic> mainData = await json.decode(response);

  return mainData;
}

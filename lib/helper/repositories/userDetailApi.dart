import 'package:egrocer/helper/utils/generalImports.dart';

Future<Map<String, dynamic>> getUserDetail({required BuildContext context}) async {
  var response = await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiUserDetails,
    params: {},
    isPost: false,
    context: context,
  );
  Map<String, dynamic> mainData = await json.decode(response);

  return mainData;
}

import 'package:egrocer/helper/utils/generalImports.dart';

Future getSliderList({required BuildContext context}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiSliders, params: {}, isPost: false, context: context);
  Map getData = json.decode(response);
  if (getData[ApiAndParams.status].toString() == "1") {
    return (getData['data'] as List).map((e) => Sliders.fromJson(e)).toList();
  } else {
    return [];
  }
}

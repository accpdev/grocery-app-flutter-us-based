import 'package:egrocer/helper/utils/generalImports.dart';

Future registerFcmKey({required BuildContext context, required String fcmToken}) async {
  await GeneralMethods.sendApiRequest(
    apiName: ApiAndParams.apiAddFcmToken,
    params: {ApiAndParams.fcmToken: fcmToken},
    isPost: true,
    context: context,
  );
}

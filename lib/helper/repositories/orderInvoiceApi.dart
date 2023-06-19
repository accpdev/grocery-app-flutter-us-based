import 'package:egrocer/helper/utils/generalImports.dart';

Future getOrderInvoiceApi({required BuildContext context, required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(apiName: ApiAndParams.apiDownloadOrderInvoice, params: params, isPost: true, context: context, isRequestedForInvoice: true);

  return await response;
}

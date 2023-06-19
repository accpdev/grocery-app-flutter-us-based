import 'package:egrocer/helper/utils/generalImports.dart';

enum UpdateOrderStatus { initial, inProgress, success, failure }

class UpdateOrderStatusProvider extends ChangeNotifier {
  UpdateOrderStatus _updateOrderStatus = UpdateOrderStatus.initial;
  String errorMessage = "";

  UpdateOrderStatus getUpdateOrderStatus() {
    return _updateOrderStatus;
  }

  void updateStatus({required String orderId, String? orderItemId, required String status, required BuildContext context}) async {
    try {
      _updateOrderStatus = UpdateOrderStatus.inProgress;
      notifyListeners();

      late PackageInfo packageInfo;
      packageInfo = await PackageInfo.fromPlatform();

      Map<String, String> params = {
        "order_id": orderId,
        "order_item_id": orderItemId ?? "",
        "status": status,
        "device_type": Platform.isAndroid
            ? "android"
            : Platform.isIOS
                ? "ios"
                : "other",
        "app_version": packageInfo.version.toString()
      };

      if (orderItemId == null) {
        params.remove("order_item_id");
      }

      Map<String, dynamic> result = await updateOrderStatus(
        params: params,
        context: context,
      );

      if (result[ApiAndParams.status] == 1) {
        Navigator.of(context).pop(true);
        GeneralMethods.showSnackBarMsg(context, getTranslatedValue(context, "lblOrderItemCancelledSuccessfully"));
      } else {
        Navigator.of(context).pop(false);
        GeneralMethods.showSnackBarMsg(context, getTranslatedValue(context, "lblOopsOrderItemUnableToCancel"));
      }
    } catch (e) {
      _updateOrderStatus = UpdateOrderStatus.failure;
      errorMessage = e.toString();
      GeneralMethods.showSnackBarMsg(context, errorMessage);
      notifyListeners();
      Navigator.of(context).pop(false);
    }
  }
}

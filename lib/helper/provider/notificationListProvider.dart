import 'package:egrocer/helper/utils/generalImports.dart';

enum NotificationState {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

class NotificationProvider extends ChangeNotifier {
  NotificationState itemsState = NotificationState.initial;
  String message = '';
  late NotificationList notificationList;
  List<NotificationListData> notifications = [];
  bool hasMoreData = false;
  int totalData = 0;
  int offset = 0;

  getNotificationProvider({
    required Map<String, dynamic> params,
    required BuildContext context,
  }) async {
    if (offset == 0) {
      itemsState = NotificationState.loading;
    } else {
      itemsState = NotificationState.loadingMore;
    }
    notifyListeners();

    try {
      params[ApiAndParams.limit] = Constant.defaultDataLoadLimitAtOnce.toString();
      params[ApiAndParams.offset] = offset.toString();

      Map<String, dynamic> getData = (await getNotificationApi(context: context, params: params));

      if (getData[ApiAndParams.status].toString() == "1") {
        notificationList = NotificationList.fromJson(getData);
        totalData = int.parse(notificationList.total);
        List<NotificationListData> tempNotifications = notificationList.data;

        notifications.addAll(tempNotifications);
      }

      if (notifications.isNotEmpty) {
        hasMoreData = totalData > notifications.length;
        if (hasMoreData) {
          offset += Constant.defaultDataLoadLimitAtOnce;
        }

        itemsState = NotificationState.loaded;

        notifyListeners();
      } else {
        itemsState = NotificationState.error;

        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      itemsState = NotificationState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }
}

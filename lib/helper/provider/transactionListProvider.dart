import 'package:egrocer/helper/utils/generalImports.dart';

enum TransactionState {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

class TransactionProvider extends ChangeNotifier {
  TransactionState itemsState = TransactionState.initial;
  String message = '';
  late Transaction transactionData;
  List<TransactionData> transactions = [];
  bool hasMoreData = false;
  int totalData = 0;
  int offset = 0;

  getTransactionProvider({
    required Map<String, dynamic> params,
    required BuildContext context,
  }) async {
    if (offset == 0) {
      itemsState = TransactionState.loading;
    } else {
      itemsState = TransactionState.loadingMore;
    }
    notifyListeners();

    try {
      params[ApiAndParams.limit] = Constant.defaultDataLoadLimitAtOnce.toString();
      params[ApiAndParams.offset] = offset.toString();

      Map<String, dynamic> getData = (await getTransactionApi(context: context, params: params));

      if (getData[ApiAndParams.status].toString() == "1") {
        totalData = int.parse(getData[ApiAndParams.total].toString());
        List<TransactionData> tempTransactions = (getData['data'] as List).map((e) => TransactionData.fromJson(Map.from(e))).toList();

        transactions.addAll(tempTransactions);
      }

      hasMoreData = totalData > transactions.length;
      if (hasMoreData) {
        offset += Constant.defaultDataLoadLimitAtOnce;
      }

      itemsState = TransactionState.loaded;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      itemsState = TransactionState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }
}

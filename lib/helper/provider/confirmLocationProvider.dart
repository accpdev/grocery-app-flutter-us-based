import 'package:egrocer/helper/utils/generalImports.dart';

enum ConfirmLocationState {
  initial,
  loading,
  loaded,
  error,
}

class ConfirmLocationProvider extends ChangeNotifier {
  ConfirmLocationState mapState = ConfirmLocationState.initial;
  String message = '';

  getProductDetailProvider({required Map<String, dynamic> params, required BuildContext context, String? productId}) async {
    mapState = ConfirmLocationState.loading;
    notifyListeners();

    try {
      mapState = ConfirmLocationState.loaded;

      notifyListeners();
    } catch (e) {
      message = e.toString();
      mapState = ConfirmLocationState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }
}

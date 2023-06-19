import 'package:egrocer/helper/utils/generalImports.dart';

enum PromoCodeState {
  initial,
  loading,
  loaded,
  error,
}

class PromoCodeProvider extends ChangeNotifier {
  PromoCodeState promoCodeState = PromoCodeState.initial;
  String message = '';
  late PromoCode promoCode;

  getPromoCodeProvider({
    required Map<String, dynamic> params,
    required BuildContext context,
  }) async {
    promoCodeState = PromoCodeState.loading;

    notifyListeners();

    try {
      Map<String, dynamic> getData = (await getPromoCodeApi(context: context, params: params));

      if (getData[ApiAndParams.status] == 1) {
        promoCode = PromoCode.fromJson(getData);

        promoCodeState = PromoCodeState.loaded;
      } else {
        promoCodeState = PromoCodeState.error;
      }
      notifyListeners();
    } catch (e) {
      message = e.toString();
      promoCodeState = PromoCodeState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }

  applyPromoCode(PromoCodeData promoCode) {
    Constant.isPromoCodeApplied = true;
    Constant.selectedCoupon = promoCode.promoCode;
    Constant.discountedAmount = double.parse(promoCode.discountedAmount);
    Constant.discount = double.parse(promoCode.discount);
    Constant.selectedPromoCodeId = promoCode.id.toString();
    notifyListeners();
  }

  removePromoCode() {
    Constant.isPromoCodeApplied = false;
    Constant.selectedCoupon = "";
    Constant.discountedAmount = 0.0;
    Constant.discount = 0.0;
    Constant.selectedPromoCodeId = "0";
    notifyListeners();
  }
}

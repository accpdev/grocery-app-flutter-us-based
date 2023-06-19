import 'package:egrocer/helper/utils/generalImports.dart';

enum CartState {
  initial,
  loading,
  loaded,
  error,
}

class CartProvider extends ChangeNotifier {
  CartState cartState = CartState.initial;
  String message = '';
  late CartData cartData;
  late double subTotal = 0.0;
  bool isOneOrMoreItemsOutOfStock = false;

  Future<void> getCartListProvider({required BuildContext context}) async {
    cartState = CartState.loading;
    notifyListeners();

    try {
      Map<String, String> params = await Constant.getProductsDefaultParams();
      Map<String, dynamic> getData = await getCartListApi(context: context, params: params);

      if (getData[ApiAndParams.status].toString() == "1") {
        cartData = CartData.fromJson(getData);
        subTotal = double.parse(cartData.data.subTotal);
        await checkCartItemsStockStatus();
        cartState = CartState.loaded;
        notifyListeners();
      } else {
        cartState = CartState.error;
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      GeneralMethods.showSnackBarMsg(context, message);
      cartState = CartState.error;
      notifyListeners();
    }
  }

  Future setSubTotal(double newSubtotal) async {
    Constant.isPromoCodeApplied = false;
    Constant.selectedCoupon = "";
    Constant.discountedAmount = 0.0;
    Constant.discount = 0.0;
    Constant.selectedPromoCodeId = "0";
    subTotal = newSubtotal;
    notifyListeners();
  }

  Future removeItemFromCartList({required int productId, required int variantId}) async {
    for (int i = 0; i < cartData.data.cart.length; i++) {
      Cart cartItem = cartData.data.cart[i];

      if (cartItem.productId.toString() == productId.toString() && cartItem.productVariantId.toString() == variantId.toString()) {
        cartData.data.cart.remove(cartItem);
        notifyListeners();
      }
    }
  }

  Future checkCartItemsStockStatus() async {
    isOneOrMoreItemsOutOfStock = false;
    for (int i = 0; i < cartData.data.cart.length; i++) {
      if (cartData.data.cart[i].status == "0") {
        isOneOrMoreItemsOutOfStock = true;
      }
    }
  }
}

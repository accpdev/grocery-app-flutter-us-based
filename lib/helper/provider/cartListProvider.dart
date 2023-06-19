import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:vibration/vibration.dart';

enum CartListState { initial, loaded, loading, error }

class CartListProvider extends ChangeNotifier {
  CartListState cartListState = CartListState.initial;
  List<CartList> cartList = [];
  String currentSelectedProduct = "";
  String currentSelectedVariant = "";

  Future<void> addRemoveCartItemFromLocalList({required String productId, required String productVariantId, required String qty}) async {
    if (int.parse(qty) == 0) {
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i].productId == productId && cartList[i].productVariantId == productVariantId) {
          cartList.removeAt(i);
        }
      }
      cartListState = CartListState.loaded;
      notifyListeners();
    } else {
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i].productId == productId && cartList[i].productVariantId == productVariantId) {
          cartList.removeAt(i);
        }
      }
      cartList.add(CartList(productId: productId, productVariantId: productVariantId, qty: qty));
      cartListState = CartListState.loaded;
      notifyListeners();
    }
  }

  getAllCartItems({required BuildContext context}) async {
    if (Constant.session.isUserLoggedIn()) {
      cartList.clear();
      try {
        Map<String, String> params = await Constant.getProductsDefaultParams();
        Map<String, dynamic> getData = await getCartListApi(context: context, params: params);
        if (getData[ApiAndParams.status].toString() == "1") {
          List<Cart> carts = (getData[ApiAndParams.data][ApiAndParams.cart] as List).map((e) => Cart.fromJson(Map.from(e))).toList();

          for (int i = 0; i < carts.length; i++) {
            cartList.add(CartList(productId: carts[i].productId.toString(), productVariantId: carts[i].productVariantId.toString(), qty: (carts[i].qty).toString()));
          }
          notifyListeners();
        }
      } catch (e) {
        String message = e.toString();
        GeneralMethods.showSnackBarMsg(context, message);
      }
    }
  }

  String getItemCartItemQuantity(String productId, String productVariantId) {
    String quantity = "0";
    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i].productId == productId && cartList[i].productVariantId == productVariantId) {
        quantity = cartList[i].qty;
      }
    }
    return quantity;
  }

  Future<void> addRemoveCartItem({
    required BuildContext context,
    required Map<String, String> params,
    required bool isUnlimitedStock,
    required double maximumAllowedQuantity,
    required double availableStock,
    String? from = "",
    String? actionFor = "",
  }) async {
    cartListState = CartListState.loading;
    notifyListeners();

    try {
      Map<String, dynamic> response = {};

      if (int.parse(params[ApiAndParams.qty].toString()) > 0) {
        if (isUnlimitedStock) {
          if (double.parse(params[ApiAndParams.qty].toString()) > maximumAllowedQuantity && actionFor == "add") {
            GeneralMethods.showSnackBarMsg(
              context,
              getTranslatedValue(
                context,
                "lblMaximumProductQuantityLimitReachedMessage",
              ),
            );
            cartListState = CartListState.error;
            notifyListeners();
          } else {
            response = await addItemToCartApi(context: context, params: params);
            try {
              if (response[ApiAndParams.status].toString() == "1") {
                if (from == "cartList") {
                  context.read<CartProvider>().setSubTotal(double.parse(response[ApiAndParams.subTotal].toString()));
                }
                addRemoveCartItemFromLocalList(productId: params[ApiAndParams.productId].toString(), productVariantId: params[ApiAndParams.productVariantId].toString(), qty: params[ApiAndParams.qty].toString());
              } else {
                cartListState = CartListState.error;
                notifyListeners();
              }
            } catch (e) {
              cartListState = CartListState.error;
              notifyListeners();
              GeneralMethods.showSnackBarMsg(
                context,
                getTranslatedValue(
                  context,
                  "lblMaximumProductQuantityLimitReachedMessage",
                ),
              );
            }
          }
        } else {
          if (double.parse(params[ApiAndParams.qty].toString()) > availableStock && actionFor == "add") {
            GeneralMethods.showSnackBarMsg(
              context,
              getTranslatedValue(
                context,
                "lblOutOfStockMessage",
              ),
            );
            cartListState = CartListState.error;
            notifyListeners();
          } else if (double.parse(params[ApiAndParams.qty].toString()) > maximumAllowedQuantity && actionFor == "add") {
            GeneralMethods.showSnackBarMsg(
              context,
              getTranslatedValue(
                context,
                "lblMaximumProductQuantityLimitReachedMessage",
              ),
            );
            cartListState = CartListState.error;
            notifyListeners();
          } else {
            response = await addItemToCartApi(context: context, params: params);

            try {
              if (response[ApiAndParams.status].toString() == "1") {
                if (from == "cartList") {
                  context.read<CartProvider>().setSubTotal(double.parse(response[ApiAndParams.subTotal].toString()));
                }
                addRemoveCartItemFromLocalList(productId: params[ApiAndParams.productId].toString(), productVariantId: params[ApiAndParams.productVariantId].toString(), qty: params[ApiAndParams.qty].toString());
              } else {
                cartListState = CartListState.error;
                notifyListeners();
              }
            } catch (e) {
              cartListState = CartListState.error;
              notifyListeners();
              GeneralMethods.showSnackBarMsg(
                context,
                getTranslatedValue(
                  context,
                  "lblMaximumProductQuantityLimitReachedMessage",
                ),
              );
            }
          }
        }
      } else {
        response = await removeItemFromCartApi(context: context, params: params);
        params[ApiAndParams.qty] = "0";

        if (response[ApiAndParams.status].toString() == "1") {
          addRemoveCartItemFromLocalList(productId: params[ApiAndParams.productId].toString(), productVariantId: params[ApiAndParams.productVariantId].toString(), qty: params[ApiAndParams.qty].toString());
          if (from == "cartList") {
            context.read<CartProvider>().setSubTotal(double.parse(response[ApiAndParams.subTotal].toString()));
            context.read<CartProvider>().removeItemFromCartList(productId: int.parse(params[ApiAndParams.productId].toString()), variantId: int.parse(params[ApiAndParams.productVariantId].toString()));
          }
        } else {
          cartListState = CartListState.error;
          notifyListeners();
        }
      }

      if ((await Vibration.hasVibrator() ?? false)) {
        Vibration.vibrate(duration: 100);
      }
    } catch (e) {
      GeneralMethods.showSnackBarMsg(context, e.toString());
      cartListState = CartListState.error;
      notifyListeners();
    }
  }

  Future clearCart({required BuildContext context}) async {
    cartList.clear();
    notifyListeners();
    await removeItemFromCartApi(context: context, params: {ApiAndParams.removeAllCartItems: "1"});
  }
}

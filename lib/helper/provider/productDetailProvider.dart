import 'package:egrocer/helper/utils/generalImports.dart';

enum ProductDetailState {
  initial,
  loading,
  loaded,
  error,
}

class ProductDetailProvider extends ChangeNotifier {
  ProductDetailState productDetailState = ProductDetailState.initial;
  String message = '';
  var productDetail;
  bool seeMore = false;

  Future<bool> getProductDetailProvider({required Map<String, dynamic> params, required BuildContext context, String? productId}) async {
    productDetailState = ProductDetailState.loading;
    notifyListeners();

    try {
      Map<String, dynamic> data = await getProductDetailApi(context: context, params: params);

      productDetail = ProductDetail.fromJson(data);

      productDetailState = ProductDetailState.loaded;

      notifyListeners();
      return true;
    } catch (e) {
      message = e.toString();
      productDetailState = ProductDetailState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
      return false;
    }
  }

  expandCollapseProductDescriptionView() {
    seeMore = !seeMore;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}

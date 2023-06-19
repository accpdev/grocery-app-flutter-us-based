import 'package:egrocer/helper/utils/generalImports.dart';

enum ProductSearchState {
  initial,
  loaded,
  loading,
  loadingMore,
  error,
}

class ProductSearchProvider extends ChangeNotifier {
  ProductSearchState productSearchState = ProductSearchState.initial;
  String message = '';
  int currentSortByOrderIndex = 0;
  late ProductList productList;
  List<ProductListItem> products = [];
  bool hasMoreData = false;
  int totalData = 0;
  int offset = 0;
  int searchedTextLength = 0;
  bool isSearchingByVoice = false;

  getProductSearchProvider({required Map<String, dynamic> params, required BuildContext context}) async {
    if (offset == 0) {
      productSearchState = ProductSearchState.loading;
    } else {
      productSearchState = ProductSearchState.loadingMore;
    }
    notifyListeners();

    params[ApiAndParams.limit] = Constant.defaultDataLoadLimitAtOnce.toString();
    params[ApiAndParams.offset] = offset.toString();

    try {
      Map<String, dynamic> response = await getProductListApi(context: context, params: params);
      if (response[ApiAndParams.status].toString() == "1") {
        productList = ProductList.fromJson(response);

        totalData = int.parse(productList.total);

        products.addAll(productList.data);

        productSearchState = ProductSearchState.loaded;

        hasMoreData = totalData > products.length;

        if (hasMoreData) {
          offset += Constant.defaultDataLoadLimitAtOnce;
        }
      } else {
        productSearchState = ProductSearchState.error;
      }

      notifyListeners();
    } catch (e) {
      message = e.toString();
      productSearchState = ProductSearchState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }

  changeState(ProductSearchState state) {
    productSearchState = state;
    notifyListeners();
  }

  setSearchLength(String text) {
    searchedTextLength = text.length;
    if (text.isEmpty) {
      products.clear();
    }
    notifyListeners();
  }

  enableDisableSearchByVoice(bool value) {
    isSearchingByVoice = value;
    notifyListeners();
  }
}

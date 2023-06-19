import 'package:egrocer/helper/utils/generalImports.dart';

enum CategoryState {
  initial,
  loading,
  loaded,
  error,
}

class CategoryListProvider extends ChangeNotifier {
  CategoryState categoryState = CategoryState.initial;
  String message = '';
  List<Category> categories = [];
  Map<String, List<Category>> subCategoriesList = {};
  List<String> selectedCategoryIdsList = [];
  List<String> selectedCategoryNamesList = [];
  String currentSelectedCategoryId = "0";

  getCategoryApiProvider({
    required Map<String, String> params,
    required BuildContext context,
  }) async {
    categoryState = CategoryState.loading;
    notifyListeners();
    try {
      categories = (await getCategoryList(context: context, params: params)).cast<Category>();

      categoryState = CategoryState.loaded;

      notifyListeners();
    } catch (e) {
      message = e.toString();
      categoryState = CategoryState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }

  setCategoryData(int index, BuildContext context) {
    currentSelectedCategoryId = selectedCategoryIdsList[index];
    categories = subCategoriesList["$index"] as List<Category>;

    if (index == 0) {
      selectedCategoryIdsList.clear();
      selectedCategoryNamesList.clear();
      selectedCategoryIdsList = ["0"];
      selectedCategoryNamesList = [
        getTranslatedValue(
          context,
          "lblAll",
        )
      ];
      currentSelectedCategoryId = "0";
    } else {
      selectedCategoryIdsList.removeRange(index, selectedCategoryIdsList.length - 1);
      selectedCategoryNamesList.removeRange(index, selectedCategoryNamesList.length - 1);
    }

    notifyListeners();
  }

  removeLastCategoryData() {
    selectedCategoryIdsList.removeLast();
    selectedCategoryNamesList.removeLast();
    categories = subCategoriesList["${selectedCategoryIdsList.last}"] as List<Category>;
    notifyListeners();
  }
}

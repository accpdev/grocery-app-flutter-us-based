import 'package:egrocer/helper/utils/generalImports.dart';

class ProductFilterProvider extends ChangeNotifier {
  RangeValues currentRangeValues = const RangeValues(0, 0);
  List<String> selectedBrands = [];
  List<String> selectedSizes = [];
  int currentSelectedFilterIndex = 0;

  resetAllFilters() {
    //Temp filters will be cleared
    Constant.resetTempFilters();

    selectedBrands = [];
    selectedSizes = [];
    notifyListeners();
  }

  setCurrentIndex(int index) {
    currentSelectedFilterIndex = index;
    notifyListeners();
  }

  setPriceRange(RangeValues value) {
    currentRangeValues = value;
    Constant.currentRangeValues = value;
    notifyListeners();
  }

  addRemoveBrandIds(String id) {
    if (selectedBrands.contains(id)) {
      selectedBrands.remove(id);
      Constant.selectedBrands.remove(id);
    } else {
      selectedBrands.add(id);
      Constant.selectedBrands.add(id);
    }
    notifyListeners();
  }

  addRemoveSizes(String size) {
    if (selectedSizes.contains(size)) {
      selectedSizes.remove(size);
      Constant.selectedSizes.remove(size);
    } else {
      selectedSizes.add(size);
      Constant.selectedSizes.add(size);
    }
    notifyListeners();
  }
}

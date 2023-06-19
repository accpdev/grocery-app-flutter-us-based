import 'package:egrocer/helper/utils/generalImports.dart';

class SliderImagesProvider extends ChangeNotifier {
  int currentSliderImageIndex = 0;

  setSliderCurrentIndexImage(int index) {
    currentSliderImageIndex = index;
    notifyListeners();
  }
}

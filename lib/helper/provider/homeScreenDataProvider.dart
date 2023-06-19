import 'package:egrocer/helper/utils/generalImports.dart';

enum HomeScreenState {
  initial,
  loading,
  loaded,
  error,
}

class HomeScreenProvider extends ChangeNotifier {
  HomeScreenState homeScreenState = HomeScreenState.initial;
  String message = '';
  late HomeScreenData homeScreenData;

  Future getHomeScreenApiProvider({required Map<String, dynamic> params, required BuildContext context}) async {
    homeScreenState = HomeScreenState.loading;
    notifyListeners();

    try {
      homeScreenData = HomeScreenData.fromJson(await getHomeScreenDataApi(context: context, params: params));

      homeScreenState = HomeScreenState.loaded;

      notifyListeners();

      return homeScreenData;
    } catch (e) {
      message = e.toString();
      homeScreenState = HomeScreenState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
      return null;
    }
  }
}

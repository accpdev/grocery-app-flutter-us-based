import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:lottie/lottie.dart';

class AppUpdateScreen extends StatelessWidget {
  final bool canIgnoreUpdate;

  const AppUpdateScreen({Key? key, required this.canIgnoreUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Constant.size10,
          horizontal: Constant.size10,
        ),
        child: Center(
          child: Container(
            decoration: DesignConfig.boxDecoration(Theme.of(context).cardColor, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  Constant.getAssetsPath(
                    3,
                    "app_update",
                  ),
                  width: MediaQuery.of(context).size.width,
                  repeat: true,
                ),
                Widgets.getSizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Constant.size15,
                    horizontal: Constant.size10,
                  ),
                  child: Text(
                    getTranslatedValue(
                      context,
                      "lblTimeToUpdate",
                    ),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: ColorsRes.appColor,
                          fontWeight: FontWeight.w500,
                        ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Constant.size15,
                    horizontal: Constant.size10,
                  ),
                  child: Text(
                    getTranslatedValue(context, "lblAppUpdateDescription"),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Constant.size15,
                    horizontal: Constant.size10,
                  ),
                  child: Widgets.gradientBtnWidget(
                    context,
                    10,
                    isSetShadow: false,
                    title: getTranslatedValue(
                      context,
                      "lblUpdateApp",
                    ),
                    callback: () {
                      if (Platform.isAndroid) {
                        launchUrl(Uri.parse(Constant.playStoreUrl), mode: LaunchMode.externalApplication);
                      } else if (Platform.isIOS) {
                        launchUrl(Uri.parse(Constant.playStoreUrl), mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                ),
                if (canIgnoreUpdate == false)
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Constant.size15,
                        horizontal: Constant.size10,
                      ),
                      child: Text(
                        getTranslatedValue(
                          context,
                          "lblNotNow",
                        ),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w300, color: ColorsRes.subTitleMainTextColor),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

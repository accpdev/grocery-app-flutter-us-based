import 'package:egrocer/helper/utils/generalImports.dart';

quickUseWidget({required BuildContext context}) {
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 10, end: 10, top: 10),
    child: Row(
      children: [
        Expanded(
          child: buttonWidget(
            Container(
              decoration: DesignConfig.boxDecoration(ColorsRes.appColorLightHalfTransparent, 5),
              padding: const EdgeInsets.all(8),
              child: Widgets.defaultImg(image: "orders", iconColor: ColorsRes.appColor, height: 20, width: 20),
            ),
            getTranslatedValue(
              context,
              "lblAllOrders",
            ),
            onClickAction: () {
              Navigator.pushNamed(
                context,
                orderHistoryScreen,
              );
            },
            padding: const EdgeInsetsDirectional.only(
              end: 5,
            ),
          ),
        ),
        Expanded(
          child: buttonWidget(
            Container(
              decoration: DesignConfig.boxDecoration(ColorsRes.appColorLightHalfTransparent, 5),
              padding: const EdgeInsets.all(8),
              child: Widgets.defaultImg(image: "addresses", iconColor: ColorsRes.appColor, height: 20, width: 20),
            ),
            getTranslatedValue(
              context,
              "lblAddress",
            ),
            onClickAction: () => Navigator.pushNamed(
              context,
              addressListScreen,
              arguments: "",
            ),
            padding: const EdgeInsetsDirectional.only(
              start: 5,
              end: 5,
            ),
          ),
        ),
        Expanded(
          child: buttonWidget(
            Container(
              decoration: DesignConfig.boxDecoration(ColorsRes.appColorLightHalfTransparent, 5),
              padding: const EdgeInsets.all(8),
              child: Widgets.defaultImg(image: "cart_icon", iconColor: ColorsRes.appColor, height: 20, width: 20),
            ),
            getTranslatedValue(
              context,
              "lblCart",
            ),
            onClickAction: () {
              if (Constant.session.isUserLoggedIn()) {
                Navigator.pushNamed(context, cartScreen).then((value) {
                  if (value != null) {
                    // if (value == true) {
                    //
                    //   Constant.bottomNavigationKey.currentState?.selectBottomMenu(0);
                    // }
                  }
                });
              } else {
                GeneralMethods.showSnackBarMsg(
                  context,
                  getTranslatedValue(
                    context,
                    "lblRequiredLoginMessageForCartRedirect",
                  ),
                  requiredAction: true,
                  onPressed: () {
                    Navigator.pushNamed(context, loginScreen);
                  },
                );
              }
            },
            padding: const EdgeInsetsDirectional.only(
              start: 5,
            ),
          ),
        ),
      ],
    ),
  );
}

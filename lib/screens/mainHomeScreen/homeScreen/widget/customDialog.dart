import 'package:egrocer/helper/utils/generalImports.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (Constant.popupBannerType == "product") {
                Navigator.pushNamed(context, productDetailScreen, arguments: [Constant.popupBannerTypeId, getTranslatedValue(context, "lblAppName"), null]);
              } else if (Constant.popupBannerType == "category") {
                Navigator.pushNamed(context, productListScreen, arguments: ["category", Constant.popupBannerTypeId, getTranslatedValue(context, "lblAppName")]);
              } else if (Constant.popupBannerType == "popup_url") {
                launchUrl(Uri.parse(Constant.popupBannerUrl), mode: LaunchMode.externalApplication);
              }
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(
                top: 18.0,
              ),
              margin: EdgeInsets.only(top: 13.0, right: 8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: ColorsRes.mainTextColor.withOpacity(0.3),
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Widgets.setNetworkImg(
                        boxFit: BoxFit.fitWidth,
                        image: Constant.popupBannerImageUrl,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            end: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: ColorsRes.appColor,
                  child: Icon(Icons.close, color: ColorsRes.appColorWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

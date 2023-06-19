import 'package:egrocer/helper/utils/generalImports.dart';

Widget buttonWidget(Widget icon, String lbl, {required Function onClickAction, required EdgeInsetsDirectional padding}) {
  return Padding(
    padding: padding,
    child: Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: InkWell(
        splashColor: ColorsRes.appColorLightHalfTransparent,
        highlightColor: Colors.transparent,
        onTap: () {
          onClickAction();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Widgets.getSizedBox(
              height: 8,
            ),
            icon,
            Widgets.getSizedBox(
              height: 8,
            ),
            Text(
              lbl,
            ),
            Widgets.getSizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ),
  );
}

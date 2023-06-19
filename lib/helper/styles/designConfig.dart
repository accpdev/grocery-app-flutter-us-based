import 'package:egrocer/helper/utils/generalImports.dart';

class DesignConfig {
  static RoundedRectangleBorder setRoundedBorder(double borderRadius, {Color? bordercolor, bool isboarder = false}) {
    return RoundedRectangleBorder(side: isboarder ? BorderSide(color: bordercolor!, width: 1.0) : BorderSide.none, borderRadius: BorderRadius.circular(borderRadius));
  }

  static RoundedRectangleBorder setRoundedBorderSpecific(
    double borderRadius, {
    bool isboarder = false,
    Color? bordercolor,
    bool istop = false,
    bool isbtm = false,
  }) {
    return RoundedRectangleBorder(
      side: isboarder ? BorderSide(color: bordercolor!, width: 1.0) : BorderSide.none,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(istop ? borderRadius : 0),
        topRight: Radius.circular(istop ? borderRadius : 0),
        bottomLeft: Radius.circular(isbtm ? borderRadius : 0),
        bottomRight: Radius.circular(isbtm ? borderRadius : 0),
      ),
    );
  }

  static BoxDecoration boxDecorationSpecific(Color? color, double borderRadius, bool istop, bool isbtm) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(istop ? borderRadius : 0),
        topRight: Radius.circular(istop ? borderRadius : 0),
        bottomLeft: Radius.circular(isbtm ? borderRadius : 0),
        bottomRight: Radius.circular(isbtm ? borderRadius : 0),
      ),
    );
  }

  static BoxDecoration boxDecoration(
    Color? color,
    double radius, {
    Color? bordercolor,
    bool isboarder = false,
    double borderwidth = 0.5,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: isboarder ? Border.all(color: bordercolor!, width: borderwidth) : null,
    );
  }

  static BoxDecoration boxGradient(double radius, {Color? color1, Color? color2, bool isSetShadow = false}) {
    color1 ??= ColorsRes.gradient1;
    color2 ??= ColorsRes.gradient2;
    return BoxDecoration(
        gradient: linearGradient(color1, color2),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: isSetShadow
            ? [
                BoxShadow(
                  color: color1.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 15),
                )
              ]
            : null);
  }

  static LinearGradient linearGradient(Color color1, Color color2) {
    return LinearGradient(
      colors: [color1, color2],
      stops: const [0, 1],
      begin: const Alignment(-0.42, -0.91),
      end: const Alignment(0.42, 0.91),
      // angle: 155,
      // scale: undefined,
    );
  }
}

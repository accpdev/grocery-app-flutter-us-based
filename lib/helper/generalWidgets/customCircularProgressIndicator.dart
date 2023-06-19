import 'package:egrocer/helper/utils/generalImports.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? heightAndWidth;

  const CustomCircularProgressIndicator({Key? key, this.color, this.heightAndWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightAndWidth ?? 20,
      width: heightAndWidth ?? 20,
      child: CircularProgressIndicator(
        color: color ?? ColorsRes.appColor,
      ),
    );
  }
}

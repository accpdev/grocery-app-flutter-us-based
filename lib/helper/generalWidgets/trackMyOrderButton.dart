import 'package:egrocer/helper/utils/generalImports.dart';

class TrackMyOrderButton extends StatelessWidget {
  final double width;
  final List<List<dynamic>> status;

  const TrackMyOrderButton({Key? key, required this.status, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
            context: context,
            builder: (context) => OrderTrackingHistoryBottomsheet(
                  listOfStatus: status,
                ));
      },
      child: Container(
        alignment: Alignment.center,
        width: width,
        child: Text(
          getTranslatedValue(
            context,
            "lblTrackMyOrder",
          ),
          softWrap: true,
          style: TextStyle(color: ColorsRes.appColor),
        ),
      ),
    );
  }
}

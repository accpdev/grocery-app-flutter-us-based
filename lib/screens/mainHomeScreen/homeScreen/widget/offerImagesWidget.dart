import 'package:egrocer/helper/utils/generalImports.dart';

getOfferImages(List<String>? offerImages) {
  return Column(
      children: List.generate(
    offerImages!.length,
    (index) {
      return Padding(
        padding: EdgeInsetsDirectional.only(start: Constant.size10, end: Constant.size10, top: Constant.size5, bottom: Constant.size5),
        child: ClipRRect(
          borderRadius: Constant.borderRadius10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Widgets.setNetworkImg(image: offerImages[index], boxFit: BoxFit.fill),
        ),
      );
    },
  ));
}

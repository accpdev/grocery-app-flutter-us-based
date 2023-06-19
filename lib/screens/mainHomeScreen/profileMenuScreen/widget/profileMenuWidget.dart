import 'package:egrocer/helper/utils/generalImports.dart';

profileMenuWidget({required List profileMenus, required BuildContext context, required ScrollController scrollController}) {
  return ListView(
    children: List.generate(
      profileMenus.length,
      (index) => ListTile(
        onTap: () {
          profileMenus[index]['clickFunction'](context);
        },
        contentPadding: EdgeInsets.zero,
        leading: Container(decoration: DesignConfig.boxDecoration(ColorsRes.appColorLightHalfTransparent, 5), padding: const EdgeInsets.all(8), child: Widgets.defaultImg(image: profileMenus[index]['icon'], iconColor: ColorsRes.appColor, height: 20, width: 20)),
        title: Text(
          profileMenus[index]['label'],
          style: Theme.of(context).textTheme.bodyMedium!.merge(const TextStyle(letterSpacing: 0.5)),
        ),
        trailing: const Icon(Icons.navigate_next),
      ),
    ),
  );
}

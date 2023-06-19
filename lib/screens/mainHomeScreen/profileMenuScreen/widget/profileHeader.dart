import 'package:egrocer/helper/utils/generalImports.dart';

profileHeader({required BuildContext context, required bool isUserLogin}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        isUserLogin ? editProfileScreen : loginScreen,
        arguments: "",
      );
    },
    child: Card(
      elevation: 0,
      margin: const EdgeInsetsDirectional.only(
        top: 10,
        start: 10,
        end: 10,
      ),
      child: Stack(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: isUserLogin
                    ? Consumer<UserProfileProvider>(
                        builder: (context, value, child) {
                          return Widgets.setNetworkImg(
                            height: 60,
                            width: 60,
                            boxFit: BoxFit.fill,
                            image: Constant.session.getData(
                              SessionManager.keyUserImage,
                            ),
                          );
                        },
                      )
                    : Widgets.defaultImg(
                        height: 60,
                        width: 60,
                        image: "default_user",
                      ),
              ),
            ),
            Expanded(
                child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Consumer<UserProfileProvider>(
                builder: (context, userProfileProvide, _) => Text(
                  Constant.session.isUserLoggedIn()
                      ? userProfileProvide.getUserDetailBySessionKey(
                          isBool: false,
                          key: SessionManager.keyUserName,
                        )
                      : getTranslatedValue(
                          context,
                          "lblWelcome",
                        ),
                ),
              ),
              subtitle: Text(
                Constant.session.isUserLoggedIn()
                    ? Constant.session.getData(
                        SessionManager.keyPhone,
                      )
                    : getTranslatedValue(
                        context,
                        "lblLogin",
                      ),
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      color: ColorsRes.appColor,
                    ),
              ),
            )),
          ]),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              decoration: DesignConfig.boxGradient(5),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsetsDirectional.only(
                end: 8,
                top: 8,
              ),
              child: Widgets.defaultImg(
                image: "edit_icon",
                iconColor: ColorsRes.mainIconColor,
                height: 20,
                width: 20,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

import 'package:egrocer/helper/utils/generalImports.dart';

class EditProfile extends StatefulWidget {
  final String? from;

  const EditProfile({Key? key, this.from}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController edtUsername = TextEditingController();
  late TextEditingController edtEmail = TextEditingController();
  late TextEditingController edtMobile = TextEditingController();
  bool isLoading = false;
  String tempName = "";
  String tempEmail = "";
  String selectedImagePath = "";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      tempName = context.read<UserProfileProvider>().getUserDetailBySessionKey(isBool: false, key: SessionManager.keyUserName);
      tempEmail = context.read<UserProfileProvider>().getUserDetailBySessionKey(isBool: false, key: SessionManager.keyEmail);

      edtUsername = TextEditingController(text: tempName);
      edtEmail = TextEditingController(text: tempEmail);
      edtMobile = TextEditingController(text: Constant.session.getData(SessionManager.keyPhone));
      selectedImagePath = "";
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context: context,
          title: Text(
            widget.from == "register"
                ? getTranslatedValue(
                    context,
                    "lblRegister",
                  )
                : getTranslatedValue(
                    context,
                    "lblEditProfile",
                  ),
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          showBackButton: widget.from != "register"),
      body: ListView(padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size15), children: [
        imgWidget(),
        Card(
          margin: const EdgeInsets.only(top: 20),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size15),
            child: Column(mainAxisSize: MainAxisSize.min, children: [userInfoWidget(), const SizedBox(height: 50), proceedBtn()]),
          ),
        ),
      ]),
    );
  }

  proceedBtn() {
    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, _) {
        return userProfileProvider.profileState == ProfileState.loading
            ? const Center(child: CircularProgressIndicator())
            : Widgets.gradientBtnWidget(
                context,
                10,
                title: getTranslatedValue(
                  context,
                  "lblUpdate",
                ),
                callback: () {
                  try {
                    if (tempName != edtUsername.text || tempEmail != edtEmail.text || selectedImagePath.isNotEmpty || _formKey.currentState!.validate()) {
                      Map<String, String> params = {};
                      params[ApiAndParams.name] = edtUsername.text.trim();
                      params[ApiAndParams.email] = edtEmail.text.trim();
                      userProfileProvider.updateUserProfile(context: context, selectedImagePath: selectedImagePath, params: params).then(
                        (value) {
                          if (value as bool) {
                            if (Constant.session.getData(SessionManager.keyLatitude) == "0" && Constant.session.getData(SessionManager.keyLongitude) == "0" && Constant.session.getData(SessionManager.keyAddress) == "") {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                getLocationScreen,
                                (Route<dynamic> route) => false,
                                arguments: "location",
                              );
                            } else {
                              if (widget.from == "register") {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  mainHomeScreen,
                                  (Route<dynamic> route) => false,
                                );
                              }else{
                                GeneralMethods.showSnackBarMsg(context, getTranslatedValue(context, "lblProfileUpdatedSuccessfully"));
                              }
                            }
                          } else {
                            GeneralMethods.showSnackBarMsg(context, value.toString());
                          }
                        },
                      );
                    }
                  } catch (e) {
                    GeneralMethods.showSnackBarMsg(context, e.toString());
                  }
                },
              );
      },
    );
  }

  userInfoWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          editBoxWidget(
            context,
            edtUsername,
            GeneralMethods.emptyValidation,
            getTranslatedValue(
              context,
              "lblUserName",
            ),
            getTranslatedValue(
              context,
              "lblEnterUserName",
            ),
            TextInputType.text,
          ),
          SizedBox(height: Constant.size15),
          editBoxWidget(
            context,
            edtEmail,
            GeneralMethods.emailValidation,
            getTranslatedValue(
              context,
              "lblEmail",
            ),
            getTranslatedValue(
              context,
              "lblEnterValidEmail",
            ),
            TextInputType.text,
          ),
          SizedBox(height: Constant.size15),
          editBoxWidget(
            context,
            edtMobile,
            GeneralMethods.emailValidation,
            getTranslatedValue(
              context,
              "lblMobileNumber",
            ),
            getTranslatedValue(
              context,
              "lblEnterValidMobile",
            ),
            TextInputType.text,
            isEditable: false,
          ),
        ],
      ),
    );
  }

  imgWidget() {
    return Center(
      child: Stack(children: [
        Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 15, end: 15),
            child: ClipRRect(
                borderRadius: Constant.borderRadius10,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: selectedImagePath.isEmpty
                    ? Widgets.setNetworkImg(height: 100, width: 100, boxFit: BoxFit.fill, image: Constant.session.getData(SessionManager.keyUserImage))
                    : Image(
                        image: FileImage(File(selectedImagePath)),
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ))),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () async {
              // Single file path
              FilePicker.platform.pickFiles(allowMultiple: false, allowCompression: true, type: FileType.image, lockParentWindow: true).then((value) {
                setState(() {
                  selectedImagePath = value!.paths.first.toString();
                });
              });
            },
            child: Container(
              decoration: DesignConfig.boxGradient(5),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsetsDirectional.only(end: 8, top: 8),
              child: Widgets.defaultImg(image: "edit_icon", iconColor: ColorsRes.mainIconColor, height: 15, width: 15),
            ),
          ),
        )
      ]),
    );
  }
}

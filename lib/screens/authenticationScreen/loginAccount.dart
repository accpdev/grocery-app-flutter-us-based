import 'package:egrocer/helper/utils/generalImports.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({Key? key}) : super(key: key);

  @override
  State<LoginAccount> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccount> {
  CountryCode? selectedCountryCode;
  bool isLoading = false, isAcceptedTerms = false;
  TextEditingController edtPhoneNumber = TextEditingController(text: "9876543210");
  bool isDark = Constant.session.getBoolData(SessionManager.isDarkTheme);
  String otpVerificationId = "";
  String phoneNumber = "";
  int? forceResendingToken;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size20),
              child: Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.width * 0.6),
                child: Widgets.defaultImg(
                  image: "logo",
                ),
              ),
            ),
            Card(
              shape: DesignConfig.setRoundedBorderSpecific(10, istop: true, isbtm: true),
              margin: EdgeInsets.symmetric(horizontal: Constant.size5, vertical: Constant.size5),
              child: loginWidgets(),
            ),
          ],
        ),
      ),
    );
  }

  proceedBtn() {
    return isLoading
        ? Container(
            height: 55,
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(),
          )
        : Widgets.gradientBtnWidget(context, 10,
            isSetShadow: false,
            title: getTranslatedValue(
              context,
              "lblLogin",
            ).toUpperCase(), callback: () {
            loginWithPhoneNumber();
          });
  }

  skipLoginText() {
    return GestureDetector(
      onTap: () async {
        if (isLoading == false) {
          Constant.session.setBoolData(SessionManager.keySkipLogin, true, false);
          await getRedirection();
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          getTranslatedValue(
            context,
            "lblSkipLogin",
          ),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: isLoading == false ? ColorsRes.appColor : ColorsRes.grey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  loginWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constant.size30, horizontal: Constant.size20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            getTranslatedValue(
              context,
              "lblWelcome",
            ),
            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5, fontSize: 30),
          ),
          subtitle: Text(
            getTranslatedValue(
              context,
              "lblLoginEnterNumberMessage",
            ),
            style: TextStyle(color: ColorsRes.grey),
          ),
        ),
        Widgets.getSizedBox(
          height: Constant.size40,
        ),
        Container(decoration: DesignConfig.boxDecoration(Theme.of(context).scaffoldBackgroundColor, 10), child: mobileNoWidget()),
        Widgets.getSizedBox(
          height: Constant.size15,
        ),
        Row(
          children: [
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: isAcceptedTerms,
              activeColor: ColorsRes.appColor,
              onChanged: (bool? val) {
                setState(() {
                  isAcceptedTerms = val!;
                });
              },
            ),
            //padding: const EdgeInsets.only(top: 15.0),
            Expanded(
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleSmall!.merge(const TextStyle(fontWeight: FontWeight.w400)),
                  text: "${getTranslatedValue(
                    context,
                    "lblAgreementMsg1",
                  )}\t",
                  children: <TextSpan>[
                    TextSpan(
                        text: getTranslatedValue(
                          context,
                          "lblTermsOfService",
                        ),
                        style: TextStyle(
                          color: ColorsRes.appColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, webViewScreen,
                                arguments: getTranslatedValue(
                                  context,
                                  "lblTermsAndConditions",
                                ));
                          }),
                    TextSpan(
                        text: "\t${getTranslatedValue(
                      context,
                      "lblAnd",
                    )}\t"),
                    TextSpan(
                        text: getTranslatedValue(
                          context,
                          "lblPrivacyPolicy",
                        ),
                        style: TextStyle(
                          color: ColorsRes.appColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, webViewScreen,
                                arguments: getTranslatedValue(
                                  context,
                                  "lblPrivacyPolicy",
                                ));
                          }),
                  ],
                ),
              ),
            ),
          ],
        ),
        Widgets.getSizedBox(
          height: Constant.size40,
        ),
        proceedBtn(),
        Widgets.getSizedBox(
          height: Constant.size40,
        ),
        skipLoginText(),
      ]),
    );
  }

  mobileNoWidget() {
    return Row(
      children: [
        const SizedBox(width: 5),
        Icon(
          Icons.phone_android,
          color: ColorsRes.mainTextColor,
        ),
        IgnorePointer(
          ignoring: isLoading,
          child: CountryCodePicker(
            onInit: (countryCode) {
              selectedCountryCode = countryCode;
            },
            onChanged: (countryCode) {
              selectedCountryCode = countryCode;
            },
            initialSelection: Constant.initialCountryCode,
            textOverflow: TextOverflow.ellipsis,
            showCountryOnly: false,
            alignLeft: false,
            backgroundColor: Theme.of(context).cardColor,
            textStyle: TextStyle(color: ColorsRes.mainTextColor),
            dialogBackgroundColor: Theme.of(context).cardColor,
            dialogSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.9),
            padding: EdgeInsets.zero,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: ColorsRes.grey,
          size: 15,
        ),
        Widgets.getSizedBox(
          width: Constant.size10,
        ),
        Flexible(
          child: TextField(
            controller: edtPhoneNumber,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              color: ColorsRes.mainTextColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintStyle: TextStyle(color: Colors.grey[300]),
              hintText: "9999999999",
            ),
          ),
        )
      ],
    );
  }

  getRedirection() async {
    if (Constant.session.getBoolData(SessionManager.keySkipLogin) || Constant.session.getBoolData(SessionManager.isUserLogin)) {
      if (Constant.session.getData(SessionManager.keyLatitude) == "0" && Constant.session.getData(SessionManager.keyLongitude) == "0") {
        Navigator.pushReplacementNamed(context, getLocationScreen, arguments: "location");
      } else if (Constant.session.getData(SessionManager.keyUserName).isNotEmpty) {
        Navigator.pushReplacementNamed(
          context,
          mainHomeScreen,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          mainHomeScreen,
          (route) => false,
        );
      }
    }
  }

  Future<String> mobileNumberValidation() async {
    String? mobileValidate = await GeneralMethods.phoneValidation(
        edtPhoneNumber.text,
        getTranslatedValue(
          context,
          "lblEnterValidMobile",
        ));
    if (mobileValidate != null && edtPhoneNumber.text.length > 15) {
      return mobileValidate;
    } else if (!isAcceptedTerms) {
      return getTranslatedValue(
        context,
        "lblAcceptTermsAndCondition",
      );
    } else {
      return "";
    }
  }

  loginWithPhoneNumber() async {
    bool checkInternet = await GeneralMethods.checkInternet();
    String? msg = "";
    String? mobileValidation = await mobileNumberValidation();

    if (checkInternet) {
      if (mobileValidation != "") {
        msg = mobileValidation;
      } else {
        if (isLoading) return;
        setState(() {
          isLoading = true;
        });
        firebaseLoginProcess();
      }
    } else {
      msg = getTranslatedValue(
        context,
        "lblCheckInternet",
      );
    }

    if (msg != "") {
      GeneralMethods.showSnackBarMsg(context, msg);
    }
  }

  firebaseLoginProcess() async {
    if (edtPhoneNumber.text.isNotEmpty) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: Constant.otpTimeOutSecond),
        phoneNumber: '${selectedCountryCode!.dialCode}${edtPhoneNumber.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          GeneralMethods.showSnackBarMsg(context, e.message!);
          setState(() {
            isLoading = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          forceResendingToken = resendToken;
          isLoading = false;
          setState(() {
            phoneNumber = '${selectedCountryCode!.dialCode} - ${edtPhoneNumber.text}';
            otpVerificationId = verificationId;

            List<dynamic> firebaseArguments = [firebaseAuth, otpVerificationId, edtPhoneNumber.text, selectedCountryCode!];
            Navigator.pushNamed(context, otpScreen, arguments: firebaseArguments);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
        forceResendingToken: forceResendingToken,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

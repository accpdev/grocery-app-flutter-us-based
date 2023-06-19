import 'package:egrocer/helper/utils/generalImports.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String otpVerificationId;
  final String phoneNumber;
  final FirebaseAuth firebaseAuth;
  final CountryCode selectedCountryCode;

  const OtpVerificationScreen({Key? key, required this.otpVerificationId, required this.phoneNumber, required this.firebaseAuth, required this.selectedCountryCode}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<OtpVerificationScreen> {
  String editOtp = "";
  bool isDark = Constant.session.getBoolData(SessionManager.isDarkTheme);
  int otpLength = 6;
  int otpResendTime = Constant.otpResendSecond + 1;
  Timer? _timer;
  bool isLoading = false;
  String resendOtpVerificationId = "";
  OtpFieldController otpFieldController = OtpFieldController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      if (mounted) {
        otpFieldController.set(['1', '2', '3', '4', '5', '6']);
      }
    });
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
              child: Widgets.defaultImg(
                image: "logo",
              ),
            ),
            Card(
              shape: DesignConfig.setRoundedBorder(10),
              margin: EdgeInsets.symmetric(horizontal: Constant.size5, vertical: Constant.size5),
              child: otpWidgets(),
            ),
          ],
        ),
      ),
    );
  }

  otpWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constant.size30, horizontal: Constant.size30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        headerWidget(
          getTranslatedValue(
            context,
            "lblEnterVerificationCode",
          ),
          getTranslatedValue(
            context,
            "lblOtpSendMessage",
          ),
        ),
        Text(
          "${widget.selectedCountryCode}-${widget.phoneNumber}",
        ),
        const SizedBox(height: 30),
        otpPinWidget(),
        const SizedBox(height: 30),
        proceedBtn(),
        const SizedBox(height: 30),
        resendOtpWidget(),
      ]),
    );
  }

  resendOtpWidget() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.titleSmall!.merge(const TextStyle(fontWeight: FontWeight.w400)),
          text: "${getTranslatedValue(
            context,
            "lblDidNotGetCode",
          )}\t",
          children: <TextSpan>[
            TextSpan(
                text: _timer != null && _timer!.isActive
                    ? otpResendTime.toString()
                    : getTranslatedValue(
                        context,
                        "lblResendOtp",
                      ),
                style: TextStyle(color: ColorsRes.appColor, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (_timer == null || !_timer!.isActive) {
                      firebaseLoginProcess();
                      startResendTimer();
                    }
                  }),
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
        : Widgets.gradientBtnWidget(
            context,
            10,
            title: getTranslatedValue(
              context,
              "lblVerifyAndProceed",
            ),
            callback: () {
              verifyOtp();
            },
            isSetShadow: false,
          );
  }

  headerWidget(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: ColorsRes.grey),
      ),
    );
  }

  verifyOtp() async {
    String msg = await checkOtpValidation();

    if (msg != "") {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: resendOtpVerificationId.isNotEmpty ? resendOtpVerificationId : widget.otpVerificationId, smsCode: editOtp);

        widget.firebaseAuth.signInWithCredential(credential).then((value) {
          User? user = value.user!;
          backendApiProcess(user);
        }).catchError((e) {
          GeneralMethods.showSnackBarMsg(context, "Please enter valid OTP");
          setState(() {
            isLoading = false;
          });
        });
      });
    }
  }

  backendApiProcess(User user) async {
    Map<String, dynamic> params = {
      ApiAndParams.mobile: widget.phoneNumber,
      // ApiAndParams.authUid: "123456", // Temp used for testing
      ApiAndParams.authUid: user.uid, // In live this will use
      ApiAndParams.countryCode: widget.selectedCountryCode.dialCode?.replaceAll("+", ""),
      // In live this will use
      ApiAndParams.fcmToken: Constant.session.getData(SessionManager.keyFCMToken)
    };

    await getLoginApi(context: context, params: params).then((mainData) async {
      if (mainData[ApiAndParams.status].toString() == "1") {
        setUserDataInSession(user, mainData);
      } else {
        setState(() {
          isLoading = false;
        });
        GeneralMethods.showSnackBarMsg(context, mainData[ApiAndParams.message]);
      }
    });
  }

  setUserDataInSession(User firebaseUser, Map<String, dynamic> mainData) async {
    Map<String, dynamic> data = await mainData[ApiAndParams.data] as Map<String, dynamic>;

    Map<String, dynamic> userData = await data[ApiAndParams.user] as Map<String, dynamic>;

    Constant.session.setBoolData(SessionManager.isUserLogin, true, false);

    Constant.session.setData(SessionManager.keyAuthUid, firebaseUser.uid, false);

    Constant.session
        .setUserData(
          /*firebaseUid: Constant.session.getData(SessionManager.keyFirebaseId),*/
          name: userData[ApiAndParams.name],
          email: userData[ApiAndParams.email],
          profile: userData[ApiAndParams.profile].toString(),
          countryCode: userData[ApiAndParams.countryCode],
          mobile: userData[ApiAndParams.mobile],
          lblReferralCode: userData[ApiAndParams.lblReferralCode],
          status: userData[ApiAndParams.status],
          token: data[ApiAndParams.accessToken], /*balance: userData[ApiAndParams.balance].toString()*/
        )
        .then((value) async => await getRedirection());
  }

  getRedirection() async {
    if (Constant.session.getIntData(SessionManager.keyUserStatus) == 2) {
      Navigator.of(context).pushNamedAndRemoveUntil(editProfileScreen, (Route<dynamic> route) => false, arguments: "register");
    } else {
      if (Constant.session.getBoolData(SessionManager.keySkipLogin) || Constant.session.getBoolData(SessionManager.isUserLogin)) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          mainHomeScreen,
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  Widget otpPinWidget() {
    return OTPTextField(
      length: otpLength,
      controller: otpFieldController,
      fieldWidth: MediaQuery.of(context).size.width * 0.12,
      width: MediaQuery.of(context).size.width,
      textFieldAlignment: MainAxisAlignment.spaceEvenly,
      fieldStyle: FieldStyle.box,
      outlineBorderRadius: 10,
      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      otpFieldStyle: OtpFieldStyle(borderColor: ColorsRes.appColor, enabledBorderColor: ColorsRes.appColor),
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: ColorsRes.appColor,
        fontWeight: FontWeight.bold,
      ),
      onChanged: (value) => () {},
      onCompleted: (value) {
        editOtp = value;
      },
    );
  }

  checkOtpValidation() async {
    bool checkInternet = await GeneralMethods.checkInternet();
    String? msg;

    if (checkInternet) {
      if (editOtp.length < otpLength) {
        msg = getTranslatedValue(
          context,
          "lblEnterOtp",
        );
      } else {
        if (isLoading) return;
        setState(() {
          isLoading = true;
        });
        return "";
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
    if (widget.phoneNumber.isNotEmpty) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: Constant.otpTimeOutSecond),
        phoneNumber: '${widget.selectedCountryCode.dialCode} - ${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (mounted) {
            isLoading = false;
            setState(() {});
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          if (mounted) {
            isLoading = false;
            setState(() {
              resendOtpVerificationId = verificationId;
            });
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (mounted) {
            isLoading = false;
            setState(() {
              // isLoading = false;
            });
          }
        },
      );
    }
  }

  void startResendTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setState(() {
          if (otpResendTime == 0) {
            timer.cancel();
            Constant.otpResendSecond + 1;
          } else {
            otpResendTime--;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }
}

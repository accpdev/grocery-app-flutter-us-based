import 'package:egrocer/helper/utils/generalImports.dart';

class IntroSliderScreen extends StatefulWidget {
  const IntroSliderScreen({Key? key}) : super(key: key);

  @override
  IntroSliderScreenState createState() => IntroSliderScreenState();
}

class IntroSliderScreenState extends State<IntroSliderScreen> {
  final _pageController = PageController();
  int currentPosition = 0;

  /// Intro slider list ...
  /// You can add or remove items from below list as well
  /// Add svg images into asset > svg folder and set name here without any extension and image should not contains space
  static List introSlider = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageView(),
    );
  }

  _buildPageView() {
    introSlider = [
      {
        "image": "location",
        "title": getTranslatedValue(
          context,
          "lblIntroTitle1",
        ),
        "description": getTranslatedValue(
          context,
          "lblIntroDesc1",
        ),
      },
      {
        "image": "order",
        "title": getTranslatedValue(
          context,
          "lblIntroTitle2",
        ),
        "description": getTranslatedValue(
          context,
          "lblIntroDesc2",
        ),
      },
      {
        "image": "delivered",
        "title": getTranslatedValue(
          context,
          "lblIntroTitle3",
        ),
        "description": getTranslatedValue(
          context,
          "lblIntroDesc3",
        ),
      },
    ];

    return Stack(
      children: [
        pageWidget(currentPosition),
        PageView.builder(
          itemCount: introSlider.length,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return Container();
          },
          onPageChanged: (int index) {
            currentPosition = index;
            setState(
              () {},
            );
          },
        ),
        Positioned(
          bottom: 50,
          left: currentPosition == introSlider.length - 1 ? 80 : 0,
          right: currentPosition == introSlider.length - 1 ? 80 : 0,
          child: buttonWidget(currentPosition),
        ),
      ],
    );
  }

  pageWidget(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Widgets.defaultImg(
            padding: EdgeInsetsDirectional.all(Constant.size15),
            image: introSlider[index]["image"],
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                child: infoWidget(index),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
                  bottom: 10,
                ),
                margin: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
                  bottom: 20,
                  top: 50,
                ),
                decoration: DesignConfig.boxDecoration(
                  ColorsRes.appColor,
                  30,
                ),
              ),
              Container(
                width: 100,
                height: 100,
                //child:Image.asset(Constant.getImagePath("intro_logo.png"))),
                decoration: ShapeDecoration(
                  color: ColorsRes.appColor,
                  shape: CircleBorder(
                    side: BorderSide(
                      width: 5,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Center(
                  child: Widgets.defaultImg(
                    image: "splash_logo",
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  infoWidget(int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              introSlider[index]["title"],
              softWrap: true,
              style: Theme.of(context).textTheme.headlineSmall!.merge(
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
          Text(
            introSlider[index]["description"],
            softWrap: true,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.merge(
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
          ),
        ],
      ),
    );
  }

  buttonWidget(int index) {
    return GestureDetector(
      onTap: () {
        if (Constant.session.getBoolData(SessionManager.keySkipLogin) || Constant.session.getBoolData(SessionManager.isUserLogin)) {
          if (Constant.session.getData(SessionManager.keyLatitude) == "0" && Constant.session.getData(SessionManager.keyLongitude) == "0") {
            Navigator.pushReplacementNamed(context, getLocationScreen, arguments: "location");
          } else {
            Navigator.pushReplacementNamed(
              context,
              mainHomeScreen,
            );
          }
        } else {
          Navigator.pushReplacementNamed(context, loginScreen);
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: Constant.size15,
        ),
        margin: const EdgeInsets.only(top: 80),
        decoration: DesignConfig.boxDecoration(index == introSlider.length - 1 ? Colors.white : Colors.transparent, 10),
        child: index == introSlider.length - 1
            ? Text(
                getTranslatedValue(
                  context,
                  "lblGetStarted",
                ),
                softWrap: true,
                style: Theme.of(context).textTheme.headlineSmall!.merge(
                      TextStyle(
                        color: ColorsRes.appColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              )
            : dotWidget(),
      ),
    );
  }

  dotWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(introSlider.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            margin: const EdgeInsetsDirectional.only(end: 10.0),
            width: currentPosition == index ? 30 : 13,
            height: currentPosition == index ? 12 : 13,
            decoration: DesignConfig.boxDecoration(Colors.white, 13),
          );
        }),
      ),
    );
  }
}

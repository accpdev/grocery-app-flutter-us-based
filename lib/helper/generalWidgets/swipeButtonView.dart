import 'package:egrocer/helper/utils/generalImports.dart';

class SwipeButtonView extends StatefulWidget {
  final VoidCallback onFinish;

  /// Event waiting for the process to finish
  final VoidCallback onWaitingProcess;

  /// Animation finish control
  final bool isFinished;

  /// Button is active value default : true
  final bool isActive;

  /// Button active color value
  final Color activeColor;

  /// Button disable color value
  final Color? disableColor;

  /// Swipe button widget
  final Widget buttonWidget;

  /// Button color default : Colors.black
  final Color? buttonColor;

  /// Button center text
  final String buttonText;

  /// Button text style
  final TextStyle buttonTextStyle;

  /// Circle indicator color
  final Animation<Color?> indicatorColor;

  const SwipeButtonView({Key? key, required this.onFinish, required this.onWaitingProcess, required this.activeColor, required this.buttonWidget, required this.buttonText, this.isFinished = false, this.isActive = true, this.disableColor = Colors.grey, this.buttonColor = Colors.white, this.buttonTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), this.indicatorColor = const AlwaysStoppedAnimation<Color>(Colors.white)}) : super(key: key);

  @override
  SwipeButtonViewState createState() => SwipeButtonViewState();
}

class SwipeButtonViewState extends State<SwipeButtonView> with TickerProviderStateMixin {
  bool isAccepted = false;
  double opacity = 1;
  bool isFinishValue = false;
  bool isStartRippleEffect = false;
  late AnimationController _controller;

  bool isScaleFinished = false;

  late AnimationController rippleController;
  late AnimationController scaleController;

  late Animation<double> rippleAnimation;
  late Animation<double> scaleAnimation;

  init() {
    setState(() {
      isAccepted = false;
      opacity = 1;
      isFinishValue = false;
      isStartRippleEffect = false;
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      isFinishValue = widget.isFinished;
    });

    rippleController = AnimationController(vsync: this, duration: Duration.zero);
    scaleController = AnimationController(vsync: this, duration: Duration.zero)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isFinishValue = true;
          });
          widget.onFinish();
        }
      });
    rippleAnimation = Tween<double>(begin: 60.0, end: 90.0).animate(rippleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          rippleController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          rippleController.forward();
        }
      });
    scaleAnimation = Tween<double>(begin: 1.0, end: 30.0).animate(scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isScaleFinished = true;
          });
        }
      });

    //rippleController.forward();

    _controller = AnimationController(vsync: this, duration: Duration.zero)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});
  }

  @override
  void dispose() {
    _controller.dispose();
    rippleController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFinished) {
      setState(() {
        isStartRippleEffect = true;
        isFinishValue = true;
      });
      scaleController.forward();
    } else {
      if (isFinishValue) {
        scaleController.reverse().then((value) {
          init();
        });
      }
    }
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(color: widget.isActive ? widget.activeColor : widget.disableColor, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: Opacity(
              opacity: opacity,
              child: Text(
                widget.buttonText,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  color: widget.isActive ? ColorsRes.appColor : ColorsRes.mainTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          !isAccepted
              ? SwipeWidget(
                  isActive: widget.isActive,
                  height: 60.0,
                  onSwipeValueCallback: (value) {
                    setState(() {
                      opacity = value;
                    });
                  },
                  child: SizedBox(
                    height: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            elevation: 2,
                            shape: const CircleBorder(),
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: widget.buttonColor),
                              child: Center(
                                child: widget.buttonWidget,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onSwipeCallback: () {
                    widget.onWaitingProcess();
                    setState(() {
                      isAccepted = true;
                    });
                    _controller.animateTo(1.0, duration: Duration.zero, curve: Curves.fastOutSlowIn);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(color: ColorsRes.mainTextColor),
                )
        ],
      ),
    );
  }
}

// ===================================

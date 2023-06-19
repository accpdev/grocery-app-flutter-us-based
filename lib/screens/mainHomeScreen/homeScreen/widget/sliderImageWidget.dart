import 'package:egrocer/helper/utils/generalImports.dart';

class SliderImageWidget extends StatefulWidget {
  final List<Sliders> sliders;

  const SliderImageWidget({Key? key, required this.sliders}) : super(key: key);

  @override
  State<SliderImageWidget> createState() => _SliderImageWidgetState();
}

class _SliderImageWidgetState extends State<SliderImageWidget> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Timer.periodic(Duration(seconds: 3), (timer) {
        if (mounted) {
          if (context.read<SliderImagesProvider>().currentSliderImageIndex < (widget.sliders.length - 1)) {
            context.read<SliderImagesProvider>().setSliderCurrentIndexImage((context.read<SliderImagesProvider>().currentSliderImageIndex + 1));
          } else {
            context.read<SliderImagesProvider>().setSliderCurrentIndexImage(0);
          }
          _pageController.animateToPage(context.read<SliderImagesProvider>().currentSliderImageIndex, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SliderImagesProvider>(
      builder: (context, sliderImagesProvider, child) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.sliders.length,
                itemBuilder: (context, index) {
                  Sliders sliderData = widget.sliders[index];
                  return Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        if (mounted) {
                          if (widget.sliders[sliderImagesProvider.currentSliderImageIndex].type == "slider_url") {
                            if (await canLaunchUrl(Uri.parse(widget.sliders[sliderImagesProvider.currentSliderImageIndex].sliderUrl))) {
                              await launchUrl(Uri.parse(widget.sliders[sliderImagesProvider.currentSliderImageIndex].sliderUrl), mode: LaunchMode.externalApplication);
                            } else {
                              throw 'Could not launch ${widget.sliders[sliderImagesProvider.currentSliderImageIndex].sliderUrl}';
                            }
                          } else if (widget.sliders[sliderImagesProvider.currentSliderImageIndex].type == "category") {
                            Navigator.pushNamed(context, productListScreen, arguments: ["category", widget.sliders[sliderImagesProvider.currentSliderImageIndex].typeId.toString(), widget.sliders[sliderImagesProvider.currentSliderImageIndex].typeName]);
                          } else if (widget.sliders[sliderImagesProvider.currentSliderImageIndex].type == "product") {
                            Navigator.pushNamed(context, productDetailScreen, arguments: [widget.sliders[sliderImagesProvider.currentSliderImageIndex].typeId.toString(), widget.sliders[sliderImagesProvider.currentSliderImageIndex].typeName, null]);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: Constant.borderRadius10,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Widgets.setNetworkImg(
                            image: sliderData.imageUrl,
                            boxFit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onPageChanged: (value) {
                  sliderImagesProvider.setSliderCurrentIndexImage(value);
                },
              ),
            ),
            Widgets.getSizedBox(
              height: Constant.size2,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.sliders.length,
                  (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: Constant.size8,
                      width: sliderImagesProvider.currentSliderImageIndex == index ? 20 : 8,
                      margin: EdgeInsets.symmetric(horizontal: Constant.size2),
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: sliderImagesProvider.currentSliderImageIndex == index ? Theme.of(context).primaryColor : ColorsRes.mainTextColor, shape: BoxShape.rectangle),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

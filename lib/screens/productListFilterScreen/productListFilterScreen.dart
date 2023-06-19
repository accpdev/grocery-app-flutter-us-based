import 'package:egrocer/helper/utils/generalImports.dart';

class ProductListFilterScreen extends StatefulWidget {
  final List<Brands> brands;
  final List<Sizes> sizes;
  final double maxPrice;
  final double minPrice;

  const ProductListFilterScreen({
    Key? key,
    required this.brands,
    required this.sizes,
    required this.maxPrice,
    required this.minPrice,
  }) : super(key: key);

  @override
  State<ProductListFilterScreen> createState() => _ProductListFilterScreenState();
}

class _ProductListFilterScreenState extends State<ProductListFilterScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      await setTempValues().then((value) => context.read<ProductFilterProvider>().currentRangeValues = RangeValues(widget.minPrice, widget.maxPrice));
      context.read<ProductFilterProvider>().setCurrentIndex(0);
    });
  }

  Future<bool> setTempValues() async {
    context.read<ProductFilterProvider>().currentRangeValues = Constant.currentRangeValues;
    context.read<ProductFilterProvider>().selectedBrands = Constant.selectedBrands;
    context.read<ProductFilterProvider>().selectedSizes = Constant.selectedSizes;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List lblFilterTypesList = [
      getTranslatedValue(
        context,
        "lblFilterTypesListBrand",
      ),
      getTranslatedValue(
        context,
        "lblFilterTypesListPackSize",
      ),
      getTranslatedValue(
        context,
        "lblFilterTypesListPrice",
      ),
    ];
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Text(
          getTranslatedValue(
            context,
            "lblFilter",
          ),
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return true;
        },
        child: Stack(
          children: [
            //Filter list screen
            PositionedDirectional(
              top: 10,
              bottom: 10,
              start: 10,
              end: (MediaQuery.of(context).size.width * 0.6) - 10,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: List.generate(lblFilterTypesList.length, (index) {
                        return (index == 2 && widget.minPrice == widget.maxPrice)
                            ? const SizedBox.shrink()
                            : ListTile(
                                onTap: () {
                                  context.read<ProductFilterProvider>().setCurrentIndex(index);
                                },
                                selected: context.watch<ProductFilterProvider>().currentSelectedFilterIndex == index,
                                selectedTileColor: Theme.of(context).cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(10),
                                    bottomStart: Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  lblFilterTypesList[index],
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                splashColor: ColorsRes.appColorLight,
                              );
                      }),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<ProductFilterProvider>().resetAllFilters();
                      setState(() {});
                    },
                    child: Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      decoration: DesignConfig.boxGradient(10, color1: Colors.transparent, color2: Colors.transparent),
                      child: Center(
                        child: Text(
                          getTranslatedValue(
                            context,
                            "lblClearAll",
                          ),
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: ColorsRes.subTitleMainTextColor,
                                fontSize: 18,
                              ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Filter list's values screen
            PositionedDirectional(
              top: 0,
              bottom: 0,
              start: MediaQuery.of(context).size.width * 0.4,
              end: 0,
              child: Container(
                decoration: DesignConfig.boxDecoration(Theme.of(context).cardColor, 8),
                margin: EdgeInsetsDirectional.only(start: 5, top: 10, bottom: 10, end: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: context.watch<ProductFilterProvider>().currentSelectedFilterIndex == 0
                          ? getBrandWidget(widget.brands, context)
                          : context.watch<ProductFilterProvider>().currentSelectedFilterIndex == 1
                              ? getSizeWidget(widget.sizes, context)
                              : widget.minPrice != widget.maxPrice
                                  ? getPriceRangeWidget(widget.minPrice, widget.maxPrice, context)
                                  : const SizedBox.shrink(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        decoration: DesignConfig.boxGradient(10),
                        child: Center(
                          child: Text(
                            getTranslatedValue(
                              context,
                              "lblApply",
                            ),
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: ColorsRes.appColorWhite,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

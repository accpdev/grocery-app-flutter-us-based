import 'package:egrocer/helper/utils/generalImports.dart';

class ProductListScreen extends StatefulWidget {
  final String? title;
  final String from;
  final String id;

  const ProductListScreen({Key? key, this.title, required this.from, required this.id}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool isFilterApplied = false;
  ScrollController scrollController = ScrollController();

  scrollListener() {
    // nextPageTrigger will have a value equivalent to 70% of the list size.
    var nextPageTrigger = 0.7 * scrollController.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current position of the user on the screen has surpassed
    if (scrollController.position.pixels > nextPageTrigger) {
      if (mounted) {
        if (context.read<ProductListProvider>().hasMoreData && context.read<ProductListProvider>().productState != ProductState.loadingMore) {
          callApi(isReset: false);
        }
      }
    }
  }

  callApi({required bool isReset}) async {
    if (isReset) {
      context.read<ProductListProvider>().offset = 0;

      context.read<ProductListProvider>().products = [];
    }

    Map<String, String> params = await Constant.getProductsDefaultParams();

    params[ApiAndParams.sort] = ApiAndParams.productListSortTypes[context.read<ProductListProvider>().currentSortByOrderIndex];
    if (widget.from == "category") {
      params[ApiAndParams.categoryId] = widget.id.toString();
    } else {
      params[ApiAndParams.sectionId] = widget.id.toString();
    }

    params = await setFilterParams(params);

    await context.read<ProductListProvider>().getProductListProvider(context: context, params: params);
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);

    //fetch productList from api
    Future.delayed(Duration.zero).then((value) async {
      callApi(isReset: true);
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    Constant.resetTempFilters();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List lblSortingDisplayList = [
      getTranslatedValue(context, "lblSortingDisplayListDefault"),
      getTranslatedValue(context, "lblSortingDisplayListNewestFirst"),
      getTranslatedValue(context, "lblSortingDisplayListOldestFirst"),
      getTranslatedValue(context, "lblSortingDisplayListPriceHighToLow"),
      getTranslatedValue(context, "lblSortingDisplayListPriceLowToHigh"),
      getTranslatedValue(context, "lblSortingDisplayListDiscountHighToLow"),
      getTranslatedValue(context, "lblSortingDisplayListPopularity"),
    ];
    return Scaffold(
      appBar: getAppBar(
          context: context,
          title: Text(
            widget.title ??
                getTranslatedValue(
                  context,
                  "lblProducts",
                ),
            softWrap: true,
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          actions: [setCartCounter(context: context)]),
      body: Column(
        children: [
          getSearchWidget(
            context: context,
          ),
          Widgets.getSizedBox(
            height: Constant.size5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Constant.size5),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(
                        context,
                        productListFilterScreen,
                        arguments: [context.read<ProductListProvider>().productList.brands, double.parse(context.read<ProductListProvider>().productList.maxPrice), double.parse(context.read<ProductListProvider>().productList.minPrice), context.read<ProductListProvider>().productList.sizes],
                      ).then((value) async {
                        if (value == true) {
                          context.read<ProductListProvider>().offset = 0;
                          context.read<ProductListProvider>().products = [];

                          callApi(isReset: true);
                        }
                      });
                    },
                    child: Card(
                        color: Theme.of(context).cardColor,
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Widgets.defaultImg(image: "filter_icon", height: 17, width: 17, padding: const EdgeInsetsDirectional.only(top: 7, bottom: 7, end: 7), iconColor: Theme.of(context).primaryColor),
                            Text(
                              getTranslatedValue(
                                context,
                                "lblFilter",
                              ),
                              softWrap: true,
                            )
                          ],
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        shape: DesignConfig.setRoundedBorderSpecific(20, istop: true),
                        builder: (BuildContext context1) {
                          return Wrap(
                            children: [
                              Container(
                                padding: EdgeInsetsDirectional.only(start: Constant.size15, end: Constant.size15, top: Constant.size15, bottom: Constant.size15),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        PositionedDirectional(
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Widgets.defaultImg(
                                                image: "ic_arrow_back",
                                                iconColor: ColorsRes.mainTextColor,
                                                height: 15,
                                                width: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            getTranslatedValue(
                                              context,
                                              "lblSortBy",
                                            ),
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.titleMedium!.merge(
                                                  const TextStyle(
                                                    letterSpacing: 0.5,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Widgets.getSizedBox(height: 10),
                                    Column(
                                      children: List.generate(
                                        ApiAndParams.productListSortTypes.length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              context.read<ProductListProvider>().products = [];

                                              context.read<ProductListProvider>().offset = 0;

                                              context.read<ProductListProvider>().currentSortByOrderIndex = index;

                                              callApi(isReset: true);
                                            },
                                            child: Container(
                                              padding: EdgeInsetsDirectional.all(10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  context.read<ProductListProvider>().currentSortByOrderIndex == index
                                                      ? Icon(
                                                          Icons.radio_button_checked,
                                                          color: ColorsRes.appColor,
                                                        )
                                                      : Icon(
                                                          Icons.radio_button_off,
                                                          color: ColorsRes.appColor,
                                                        ),
                                                  Widgets.getSizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      lblSortingDisplayList[index],
                                                      softWrap: true,
                                                      style: Theme.of(context).textTheme.titleMedium!.merge(
                                                            const TextStyle(
                                                              letterSpacing: 0.5,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                        color: Theme.of(context).cardColor,
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Widgets.defaultImg(image: "sorting_icon", height: 17, width: 17, padding: const EdgeInsetsDirectional.only(top: 7, bottom: 7, end: 7), iconColor: Theme.of(context).primaryColor),
                            Text(
                              getTranslatedValue(
                                context,
                                "lblSortBy",
                              ),
                              softWrap: true,
                            )
                          ],
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<ProductChangeListingTypeProvider>().changeListingType();
                    },
                    child: Card(
                        color: Theme.of(context).cardColor,
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Widgets.defaultImg(image: context.watch<ProductChangeListingTypeProvider>().getListingType() == false ? "grid_view_icon" : "list_view_icon", height: 17, width: 17, padding: const EdgeInsetsDirectional.only(top: 7, bottom: 7, end: 7), iconColor: Theme.of(context).primaryColor),
                            Text(
                              context.watch<ProductChangeListingTypeProvider>().getListingType() == false
                                  ? getTranslatedValue(
                                      context,
                                      "lblGridView",
                                    )
                                  : getTranslatedValue(
                                      context,
                                      "lblListView",
                                    ),
                              softWrap: true,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: setRefreshIndicator(
                  refreshCallback: () async {
                    context.read<ProductListProvider>().offset = 0;
                    context.read<ProductListProvider>().products = [];

                    callApi(isReset: true);
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: productWidget(),
                  )))
        ],
      ),
    );
  }

  productWidget() {
    return Consumer<ProductListProvider>(
      builder: (context, productListProvider, _) {
        List<ProductListItem> products = productListProvider.products;
        if (productListProvider.productState == ProductState.initial) {
          return getProductListShimmer(context: context, isGrid: context.read<ProductChangeListingTypeProvider>().getListingType());
        } else if (productListProvider.productState == ProductState.loading) {
          return getProductListShimmer(context: context, isGrid: context.read<ProductChangeListingTypeProvider>().getListingType());
        } else if (productListProvider.productState == ProductState.loaded || productListProvider.productState == ProductState.loadingMore) {
          return Column(
            children: [
              context.read<ProductChangeListingTypeProvider>().getListingType() == true
                  ? /* GRID VIEW UI */ GridView.builder(
                      itemCount: products.length,
                      padding: EdgeInsetsDirectional.only(start: Constant.size10, end: Constant.size10, bottom: Constant.size10, top: Constant.size5),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductGridItemContainer(product: products[index]);
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    )
                  : /* LIST VIEW UI */ Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(products.length, (index) {
                        return ProductListItemContainer(product: products[index]);
                      }),
                    ),
              if (productListProvider.productState == ProductState.loadingMore) getProductItemShimmer(context: context, isGrid: context.read<ProductChangeListingTypeProvider>().getListingType()),
            ],
          );
        } else {
          return DefaultBlankItemMessageScreen(
            title: getTranslatedValue(
              context,
              "lblEmptyProductListMessage",
            ),
            description: getTranslatedValue(
              context,
              "lblEmptyProductListDescription",
            ),
            image: "no_product_icon",
          );
        }
      },
    );
  }

  Future<Map<String, String>> setFilterParams(Map<String, String> params) async {
    params[ApiAndParams.maxPrice] = Constant.currentRangeValues.end.toString();
    params[ApiAndParams.minPrice] = Constant.currentRangeValues.start.toString();
    params[ApiAndParams.brandIds] = getFiltersItemsList(Constant.selectedBrands.toSet().toList());

    List<String> sizes = await getSizeListSizesAndIds(Constant.selectedSizes).then((value) => value[0]);
    List<String> unitIds = await getSizeListSizesAndIds(Constant.selectedSizes).then((value) => value[1]);

    params[ApiAndParams.sizes] = getFiltersItemsList(sizes);
    params[ApiAndParams.unitIds] = getFiltersItemsList(unitIds);

    return params;
  }

  Future<List<List<String>>> getSizeListSizesAndIds(List sizeList) async {
    List<String> sizes = [];
    List<String> unitIds = [];

    for (int i = 0; i < sizeList.length; i++) {
      if (i % 2 == 0) {
        sizes.add(sizeList[i].toString().split("-")[0]);
      } else {
        unitIds.add(sizeList[i].toString().split("-")[1]);
      }
    }
    return [sizes, unitIds];
  }

  String getFiltersItemsList(List<String> param) {
    String ids = "";
    for (int i = 0; i < param.length; i++) {
      ids += "${param[i]}${i == (param.length - 1) ? "" : ","}";
    }
    return ids;
  }
}

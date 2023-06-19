import 'package:egrocer/helper/utils/generalImports.dart';

class WishListScreen extends StatefulWidget {
  final ScrollController scrollController;

  const WishListScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<WishListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<WishListScreen> {
  scrollListener() {
    // nextPageTrigger will have a value equivalent to 70% of the list size.
    var nextPageTrigger = 0.7 * widget.scrollController.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current position of the user on the screen has surpassed
    if (widget.scrollController.position.pixels > nextPageTrigger) {
      if (mounted) {
        if (context.read<ProductWishListProvider>().hasMoreData) {
          callApi(isReset: false);
        }
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(() {});
    widget.scrollController.dispose();
    Constant.resetTempFilters();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value) async {
      //fetch productList from api
      widget.scrollController.addListener(scrollListener);

      callApi(isReset: true);
    });
  }

  callApi({required isReset}) async {
    if (isReset) {
      context.read<ProductWishListProvider>().offset = 0;
      context.read<ProductWishListProvider>().wishlistProducts = [];
    }
    Map<String, String> params = await Constant.getProductsDefaultParams();

    await context.read<ProductWishListProvider>().getProductWishListProvider(context: context, params: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Text(
          getTranslatedValue(
            context,
            "lblWishList",
          ),
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
        actions: [setCartCounter(context: context)],
        showBackButton: false,
      ),
      body: Column(
        children: [
          getSearchWidget(
            context: context,
          ),
          Widgets.getSizedBox(
            height: Constant.size10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constant.size10),
            child: GestureDetector(
              onTap: () {
                context.read<ProductChangeListingTypeProvider>().changeListingType();
              },
              child: context.watch<ProductWishListProvider>().wishlistProducts.isNotEmpty
                  ? Card(
                      margin: EdgeInsets.zero,
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
                          )
                        ],
                      ))
                  : const SizedBox.shrink(),
            ),
          ),
          Expanded(
            child: setRefreshIndicator(
              refreshCallback: () async {
                callApi(isReset: true);
              },
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: productWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }

  productWidget() {
    return Consumer<ProductWishListProvider>(
      builder: (context, productWishlistProvider, _) {
        List<ProductListItem> wishlistProducts = productWishlistProvider.wishlistProducts;
        if (productWishlistProvider.productWishListState == ProductWishListState.initial) {
          return getProductListShimmer(context: context, isGrid: context.read<ProductChangeListingTypeProvider>().getListingType());
        } else if (productWishlistProvider.productWishListState == ProductWishListState.loading) {
          return getProductListShimmer(context: context, isGrid: context.read<ProductChangeListingTypeProvider>().getListingType());
        } else if (productWishlistProvider.productWishListState == ProductWishListState.loaded || productWishlistProvider.productWishListState == ProductWishListState.loadingMore) {
          return Column(
            children: [
              context.read<ProductChangeListingTypeProvider>().getListingType() == true
                  ? /* GRID VIEW UI */ GridView.builder(
                      itemCount: wishlistProducts.length,
                      padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductGridItemContainer(product: wishlistProducts[index]);
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    )
                  : /* LIST VIEW UI */ Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(wishlistProducts.length, (index) {
                          return ProductListItemContainer(product: wishlistProducts[index]);
                        }),
                      ),
                    ),
              if (productWishlistProvider.productWishListState == ProductWishListState.loadingMore) getProductItemShimmer(context: context, isGrid: context.read<ProductChangeListingTypeProvider>().getListingType()),
            ],
          );
        } else {
          return DefaultBlankItemMessageScreen(
            title: getTranslatedValue(
              context,
              "lblEmptyWishListMessage",
            ),
            description: getTranslatedValue(
              context,
              "lblEmptyWishListDescription",
            ),
            image: "empty_wishlist_icon",
          );
        }
      },
    );
  }
}

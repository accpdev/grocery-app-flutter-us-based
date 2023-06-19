import 'package:egrocer/helper/utils/generalImports.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? title;
  final String id;
  final ProductListItem? productListItem;

  const ProductDetailScreen({Key? key, this.title, required this.id, this.productListItem}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late int currentImage;
  late List<String> images;

  @override
  void initState() {
    super.initState();
    //fetch productList from api
    Future.delayed(Duration.zero).then((value) async {
      Map<String, String> params = await Constant.getProductsDefaultParams();
      params[ApiAndParams.id] = widget.id;

      await context.read<ProductDetailProvider>().getProductDetailProvider(context: context, params: params).then((value) async {
        if (value) {
          currentImage = 0;
          setOtherImages(currentImage, context.read<ProductDetailProvider>().productDetail!.data);
        }
      });
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Text(
          widget.title ?? getTranslatedValue(context, "lblProducts"),
          softWrap: true,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
      body: Consumer<ProductDetailProvider>(
        builder: (context, productDetailProvider, child) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                productDetailProvider.productDetailState == ProductDetailState.loaded
                    ? ChangeNotifierProvider<SelectedVariantItemProvider>(
                        create: (context) => SelectedVariantItemProvider(),
                        child: productDetailWidget(productDetailProvider.productDetail!.data),
                      )
                    : productDetailProvider.productDetailState == ProductDetailState.loading
                        ? getProductDetailShimmer(context: context)
                        : const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }

  productDetailWidget(ProductData product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Constant.size10, horizontal: Constant.size10),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, fullScreenProductImageScreen, arguments: [currentImage, images]);
            },
            child: Consumer<SelectedVariantItemProvider>(
              builder: (context, selectedVariantItemProvider, child) {
                return Stack(
                  children: [
                    ClipRRect(
                        borderRadius: Constant.borderRadius10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Widgets.setNetworkImg(
                          boxFit: BoxFit.fill,
                          image: images[currentImage],
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                        )),
                    if (product.variants[selectedVariantItemProvider.getSelectedIndex()].status == "0") PositionedDirectional(top: 0, end: 0, start: 0, bottom: 0, child: getOutOfStockWidget(height: MediaQuery.of(context).size.width, width: MediaQuery.of(context).size.width, context: context)),
                    PositionedDirectional(
                        bottom: 5,
                        end: 5,
                        child: Column(
                          children: [
                            if (product.indicator == 1) Widgets.defaultImg(height: 35, width: 35, image: "veg_indicator"),
                            if (product.indicator == 2) Widgets.defaultImg(height: 35, width: 35, image: "non_veg_indicator"),
                          ],
                        )),
                  ],
                );
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(images.length > 1 ? images.length : 0, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentImage = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: getOtherImagesBoxDecoration(isActive: currentImage == index),
                    child: ClipRRect(
                      borderRadius: Constant.borderRadius13,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Widgets.setNetworkImg(
                        height: 60,
                        width: 60,
                        image: images[index],
                        boxFit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Widgets.getSizedBox(
          height: Constant.size5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                      color: Theme.of(context).cardColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProductWishListIcon(
                            product: Constant.session.isUserLoggedIn() ? widget.productListItem : null,
                            isListing: false,
                          ),
                          Text(
                            getTranslatedValue(
                              context,
                              "lblWishList",
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await GeneralMethods.createDynamicLink(context: context, shareUrl: "${Constant.hostUrl}product/${product.id}", imageUrl: product.imageUrl, title: product.name, description: "<h1>${product.name}</h1><br><br><h2>${product.variants[0].measurement} ${product.variants[0].stockUnitName}</h2>").then(
                      (value) async => await Share.share("${product.name}\n\n$value", subject: "Share app"),
                    );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Widgets.defaultImg(image: "share_icon", height: 17, width: 17, padding: const EdgeInsetsDirectional.only(top: 7, bottom: 7, end: 7), iconColor: Theme.of(context).primaryColor),
                        Text(
                          getTranslatedValue(
                            context,
                            "lblShare",
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (Constant.session.isUserLoggedIn()) {
                      Navigator.pushNamed(context, cartScreen);
                    } else {
                      GeneralMethods.showSnackBarMsg(
                        context,
                        getTranslatedValue(
                          context,
                          "lblRequiredLoginMessageForCartRedirect",
                        ),
                        requiredAction: true,
                        onPressed: () {
                          Navigator.pushNamed(context, loginScreen);
                        },
                      );
                    }
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Widgets.defaultImg(
                          image: "cart_icon",
                          height: 17,
                          width: 17,
                          padding: const EdgeInsetsDirectional.only(top: 7, bottom: 7, end: 7),
                          iconColor: Theme.of(context).primaryColor,
                        ),
                        Text(
                          getTranslatedValue(
                            context,
                            "lblGoToCart",
                          ),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Widgets.getSizedBox(
          height: Constant.size5,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size10),
          margin: EdgeInsets.symmetric(horizontal: Constant.size10),
          decoration: DesignConfig.boxDecoration(Theme.of(context).cardColor, 5),
          child: Consumer<SelectedVariantItemProvider>(
            builder: (context, selectedVariantItemProvider, _) {
              return product.variants.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Widgets.getSizedBox(
                          height: Constant.size10,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                double.parse(product.variants[selectedVariantItemProvider.getSelectedIndex()].discountedPrice) != 0 ? GeneralMethods.getCurrencyFormat(double.parse(product.variants[selectedVariantItemProvider.getSelectedIndex()].discountedPrice)) : GeneralMethods.getCurrencyFormat(double.parse(product.variants[selectedVariantItemProvider.getSelectedIndex()].price)),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15, color: ColorsRes.appColor, fontWeight: FontWeight.w500),
                              ),
                              Widgets.getSizedBox(width: 5),
                              RichText(
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                text: TextSpan(children: [
                                  TextSpan(
                                    style: TextStyle(fontSize: 13, color: ColorsRes.mainTextColor, decoration: TextDecoration.lineThrough, decorationThickness: 2),
                                    text: double.parse(product.variants[0].discountedPrice) != 0 ? GeneralMethods.getCurrencyFormat(double.parse(product.variants[0].price)) : "",
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        Widgets.getSizedBox(height: Constant.size10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (product.variants.length > 1) {
                                    {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: DesignConfig.setRoundedBorderSpecific(20, istop: true),
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: EdgeInsetsDirectional.only(start: Constant.size15, end: Constant.size15, top: Constant.size15, bottom: Constant.size15),
                                            child: Wrap(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.only(start: Constant.size15, end: Constant.size15),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(borderRadius: Constant.borderRadius10, clipBehavior: Clip.antiAliasWithSaveLayer, child: Widgets.setNetworkImg(boxFit: BoxFit.fill, image: product.imageUrl, height: 70, width: 70)),
                                                      Widgets.getSizedBox(
                                                        width: Constant.size10,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          product.name,
                                                          softWrap: true,
                                                          style: const TextStyle(fontSize: 20),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsetsDirectional.only(start: Constant.size15, end: Constant.size15, top: Constant.size15, bottom: Constant.size15),
                                                  child: ListView.separated(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: product.variants.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  child: RichText(
                                                                    maxLines: 2,
                                                                    softWrap: true,
                                                                    overflow: TextOverflow.clip,
                                                                    // maxLines: 1,
                                                                    text: TextSpan(children: [
                                                                      TextSpan(
                                                                        style: TextStyle(fontSize: 15, color: ColorsRes.mainTextColor, decorationThickness: 2),
                                                                        text: "${product.variants[index].measurement} ",
                                                                      ),
                                                                      WidgetSpan(
                                                                        child: Text(
                                                                          product.variants[index].stockUnitName,
                                                                          softWrap: true,
                                                                          //superscript is usually smaller in size
                                                                          // textScaleFactor: 0.7,
                                                                          style: const TextStyle(
                                                                            fontSize: 14,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      TextSpan(text: double.parse(product.variants[index].discountedPrice) != 0 ? " | " : "", style: TextStyle(color: ColorsRes.mainTextColor)),
                                                                      TextSpan(
                                                                        style: TextStyle(fontSize: 13, color: ColorsRes.mainTextColor, decoration: TextDecoration.lineThrough, decorationThickness: 2),
                                                                        text: double.parse(product.variants[index].discountedPrice) != 0 ? GeneralMethods.getCurrencyFormat(double.parse(product.variants[index].price)) : "",
                                                                      ),
                                                                    ]),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  double.parse(product.variants[index].discountedPrice) != 0 ? GeneralMethods.getCurrencyFormat(double.parse(product.variants[index].discountedPrice)) : GeneralMethods.getCurrencyFormat(double.parse(product.variants[index].price)),
                                                                  softWrap: true,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(fontSize: 17, color: ColorsRes.appColor, fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          ProductCartButton(
                                                            productId: product.id.toString(),
                                                            productVariantId: product.variants[index].id.toString(),
                                                            count: int.parse(product.variants[index].status) == 0 ? -1 : int.parse(product.variants[index].cartCount),
                                                            isUnlimitedStock: product.isUnlimitedStock == "1",
                                                            maximumAllowedQuantity: double.parse(product.totalAllowedQuantity.toString()),
                                                            availableStock: double.parse(product.variants[index].stock),
                                                            isGrid: false,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                    separatorBuilder: (BuildContext context, int index) {
                                                      return Padding(
                                                        padding: EdgeInsets.symmetric(vertical: Constant.size7),
                                                        child: Divider(
                                                          color: ColorsRes.grey,
                                                          height: 5,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsetsDirectional.only(end: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: Constant.borderRadius5,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  child: Container(
                                    padding: product.variants.length > 1 ? EdgeInsets.zero : EdgeInsets.all(5),
                                    alignment: AlignmentDirectional.center,
                                    height: 35,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Spacer(),
                                        Text(
                                          "${product.variants[0].measurement} ${product.variants[0].stockUnitName}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorsRes.mainTextColor,
                                          ),
                                        ),
                                        Spacer(),
                                        if (product.variants.length > 1)
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(start: 5, end: 5),
                                            child: Widgets.defaultImg(
                                              image: "ic_drop_down",
                                              height: 10,
                                              width: 10,
                                              boxFit: BoxFit.cover,
                                              iconColor: ColorsRes.mainTextColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ProductCartButton(
                                productId: product.id.toString(),
                                productVariantId: product.variants[selectedVariantItemProvider.getSelectedIndex()].id.toString(),
                                count: int.parse(product.variants[selectedVariantItemProvider.getSelectedIndex()].status) == 0 ? -1 : int.parse(product.variants[selectedVariantItemProvider.getSelectedIndex()].cartCount),
                                isUnlimitedStock: product.isUnlimitedStock == "1",
                                maximumAllowedQuantity: double.parse(product.totalAllowedQuantity.toString()),
                                availableStock: double.parse(product.variants[selectedVariantItemProvider.getSelectedIndex()].stock),
                                isGrid: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox.shrink();
            },
          ),
        ),
        Widgets.getSizedBox(
          height: Constant.size5,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
          child: Card(
            child: Container(
              margin: const EdgeInsetsDirectional.all(10),
              child: HtmlWidget(
                product.description,
                enableCaching: true,
                renderMode: RenderMode.column,
                buildAsync: false,
                textStyle: TextStyle(color: ColorsRes.mainTextColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getProductDetailShimmer({required BuildContext context}) {
    return CustomShimmer(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }

  setOtherImages(int currentIndex, ProductData product) {
    currentImage = 0;
    images = [];
    images.add(product.imageUrl);
    if (product.variants[currentIndex].images.isNotEmpty) {
      images.addAll(product.variants[currentIndex].images);
    } else {
      images.addAll(product.images);
    }
    context.read<ProductDetailProvider>().notify();
  }
}

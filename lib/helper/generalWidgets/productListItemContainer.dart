import 'package:egrocer/helper/utils/generalImports.dart';

class ProductListItemContainer extends StatefulWidget {
  final ProductListItem product;

  const ProductListItemContainer({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductListItemContainer> createState() => _State();
}

class _State extends State<ProductListItemContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductListItem product = widget.product;
    List<Variants> variants = product.variants!;
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 5, start: 10, end: 10, top: 5),
      child: variants.length > 0
          ? GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, productDetailScreen, arguments: [product.id.toString(), product.name, product]);
              },
              child: ChangeNotifierProvider<SelectedVariantItemProvider>(
                create: (context) => SelectedVariantItemProvider(),
                child: Container(
                  decoration: DesignConfig.boxDecoration(Theme.of(context).cardColor, 8),
                  child: Stack(
                    children: [
                      Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Consumer<SelectedVariantItemProvider>(
                          builder: (context, selectedVariantItemProvider, child) {
                            return Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: Constant.borderRadius10,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Widgets.setNetworkImg(
                                      boxFit: BoxFit.fill,
                                      image: product.imageUrl.toString(),
                                      height: 125,
                                      width: 125,
                                    )),
                                if (product.variants?[selectedVariantItemProvider.getSelectedIndex()].status.toString() == "0")
                                  PositionedDirectional(
                                    top: 0,
                                    end: 0,
                                    start: 0,
                                    bottom: 0,
                                    child: getOutOfStockWidget(
                                      height: 125,
                                      width: 125,
                                      textSize: 15,
                                      context: context,
                                    ),
                                  ),
                                PositionedDirectional(
                                    bottom: 5,
                                    end: 5,
                                    child: Column(
                                      children: [
                                        if (product.indicator == 1) Widgets.defaultImg(height: 24, width: 24, image: "veg_indicator"),
                                        if (product.indicator == 2) Widgets.defaultImg(height: 24, width: 24, image: "non_veg_indicator"),
                                      ],
                                    )),
                              ],
                            );
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: Constant.size10, horizontal: Constant.size10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Widgets.getSizedBox(
                                  height: Constant.size10,
                                ),
                                Text(
                                  product.name.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                                Widgets.getSizedBox(
                                  height: Constant.size10,
                                ),
                                ProductVariantDropDownMenuList(
                                  variants: variants,
                                  from: "",
                                  product: product,
                                  isGrid: false,
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                      PositionedDirectional(
                        end: 5,
                        top: 5,
                        child: ProductWishListIcon(
                          product: product,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}

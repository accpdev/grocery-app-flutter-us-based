import 'package:egrocer/helper/utils/generalImports.dart';

class HomeScreenProductListItem extends StatefulWidget {
  final ProductListItem product;
  final int position;

  const HomeScreenProductListItem({Key? key, required this.product, required this.position}) : super(key: key);

  @override
  State<HomeScreenProductListItem> createState() => _State();
}

class _State extends State<HomeScreenProductListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductListItem product = widget.product;
    List<Variants>? variants = product.variants;
    return variants!.isNotEmpty
        ? Consumer<ProductListProvider>(
            builder: (context, productListProvider, _) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, productDetailScreen, arguments: [product.id.toString(), product.name, product]);
                },
                child: ChangeNotifierProvider<SelectedVariantItemProvider>(
                  create: (context) => SelectedVariantItemProvider(),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: DesignConfig.boxDecoration(Theme.of(context).cardColor, 8),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Consumer<SelectedVariantItemProvider>(
                                builder: (context, selectedVariantItemProvider, child) {
                                  return Stack(
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius: Constant.borderRadius10,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          child: Widgets.setNetworkImg(
                                            boxFit: BoxFit.fitHeight,
                                            image: product.imageUrl??"",
                                            height: MediaQuery.of(context).size.width,
                                            width: MediaQuery.of(context).size.width,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorsRes.appColorWhite,
                                          borderRadius: BorderRadiusDirectional.all(
                                            Radius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (product.variants?[selectedVariantItemProvider.getSelectedIndex()].status == "0")
                                        PositionedDirectional(
                                          top: 0,
                                          end: 0,
                                          start: 0,
                                          bottom: 0,
                                          child: getOutOfStockWidget(
                                            height: MediaQuery.of(context).size.width,
                                            width: MediaQuery.of(context).size.width,
                                            context: context,
                                          ),
                                        ),
                                      PositionedDirectional(
                                        bottom: 5,
                                        end: 5,
                                        child: Column(
                                          children: [
                                            if (product.indicator == 1)
                                              Widgets.defaultImg(
                                                height: 24,
                                                width: 24,
                                                image: "veg_indicator",
                                                boxFit: BoxFit.cover,
                                              ),
                                            if (product.indicator == 2) Widgets.defaultImg(height: 24, width: 24, image: "non_veg_indicator", boxFit: BoxFit.cover),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 5, bottom: 10, top: 10),
                                  child: Text(
                                    product.name??"",
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ProductVariantDropDownMenuGrid(
                                  variants: variants,
                                  from: "",
                                  product: product,
                                  isGrid: true,
                                ),
                              ],
                            )
                          ],
                        ),
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
              );
            },
          )
        : const SizedBox.shrink();
  }
}

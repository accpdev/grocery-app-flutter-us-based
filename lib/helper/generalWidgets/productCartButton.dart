import 'package:egrocer/helper/utils/generalImports.dart';

class ProductCartButton extends StatefulWidget {
  final int count;
  final String productId;
  final String productVariantId;
  final bool isUnlimitedStock;
  final double maximumAllowedQuantity;
  final double availableStock;
  final String? from;
  final bool isGrid;

  const ProductCartButton({
    Key? key,
    required this.count,
    required this.productId,
    required this.productVariantId,
    required this.isUnlimitedStock,
    required this.maximumAllowedQuantity,
    required this.availableStock,
    required this.isGrid,
    this.from,
  }) : super(key: key);

  @override
  State<ProductCartButton> createState() => _ProductCartButtonState();
}

class _ProductCartButtonState extends State<ProductCartButton> /*with TickerProviderStateMixin*/ {
  late AnimationController animationController;
  late Animation animation;
  int currentState = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartListProvider>(
      builder: (context, cartListProvider, child) {
        return (int.parse(cartListProvider.getItemCartItemQuantity(widget.productId, widget.productVariantId)) == 0 && widget.count != -1)
            ? GestureDetector(
                onTap: () async {
                  if (Constant.session.isUserLoggedIn()) {
                    cartListProvider.currentSelectedProduct = widget.productId;
                    cartListProvider.currentSelectedVariant = widget.productVariantId;

                    Map<String, String> params = {};
                    params[ApiAndParams.productId] = widget.productId;
                    params[ApiAndParams.productVariantId] = widget.productVariantId;
                    params[ApiAndParams.qty] = (int.parse(cartListProvider.getItemCartItemQuantity(widget.productId, widget.productVariantId)) + 1).toString();
                    await cartListProvider.addRemoveCartItem(context: context, params: params, isUnlimitedStock: widget.isUnlimitedStock, maximumAllowedQuantity: widget.maximumAllowedQuantity, availableStock: widget.availableStock, actionFor: "add", from: widget.from);
                  } else {
                    GeneralMethods.showSnackBarMsg(
                      context,
                      getTranslatedValue(
                        context,
                        "lblRequiredLoginMessageForCart",
                      ),
                      requiredAction: true,
                      onPressed: () {
                        Navigator.pushNamed(context, loginScreen);
                      },
                    );
                  }
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.symmetric(horizontal: Constant.size10),
                  decoration: widget.isGrid
                      ? BoxDecoration(
                          color: Colors.transparent,
                        )
                      : BoxDecoration(
                          color: Colors.transparent,
                          border: Border.symmetric(
                            vertical: BorderSide(
                              color: ColorsRes.subTitleMainTextColor,
                            ),
                            horizontal: BorderSide(
                              color: ColorsRes.subTitleMainTextColor,
                            ),
                          ),
                          borderRadius: BorderRadiusDirectional.all(
                            Radius.circular(5),
                          ),
                        ),
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: (cartListProvider.cartListState == CartListState.loading && cartListProvider.currentSelectedProduct == widget.productId && cartListProvider.currentSelectedVariant == widget.productVariantId)
                      ? Container(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              color: ColorsRes.appColor,
                            ),
                          ),
                        )
                      : Text(
                          getTranslatedValue(context, "lblAddToCart"),
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: ColorsRes.subTitleMainTextColor,
                              ),
                        ),
                ),
              )
            : (int.parse(cartListProvider.getItemCartItemQuantity(widget.productId, widget.productVariantId)) != 0 && widget.count != -1)
                ? Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      gradient: DesignConfig.linearGradient(ColorsRes.appColor, ColorsRes.appColor),
                      borderRadius: widget.isGrid
                          ? BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(10),
                              bottomEnd: Radius.circular(10),
                            )
                          : BorderRadiusDirectional.all(
                              Radius.circular(5),
                            ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 5),
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: Widgets.gradientBtnWidget(
                              context,
                              50,
                              color1: ColorsRes.appColorWhite,
                              color2: ColorsRes.appColorWhite,
                              callback: () async {
                                cartListProvider.currentSelectedProduct = widget.productId;
                                cartListProvider.currentSelectedVariant = widget.productVariantId;

                                Map<String, String> params = {};
                                params[ApiAndParams.productId] = widget.productId;
                                params[ApiAndParams.productVariantId] = widget.productVariantId;
                                params[ApiAndParams.qty] = (int.parse(cartListProvider.getItemCartItemQuantity(widget.productId, widget.productVariantId)) - 1).toString();

                                await cartListProvider.addRemoveCartItem(context: context, params: params, isUnlimitedStock: widget.isUnlimitedStock, maximumAllowedQuantity: widget.maximumAllowedQuantity, availableStock: widget.availableStock, from: widget.from);
                              },
                              otherWidgets: int.parse(cartListProvider.getItemCartItemQuantity(widget.productId, widget.productVariantId)) == 1
                                  ? Widgets.defaultImg(
                                      image: "cart_delete",
                                      width: 20,
                                      height: 20,
                                      padding: const EdgeInsetsDirectional.all(5),
                                      iconColor: ColorsRes.appColor,
                                    )
                                  : Widgets.defaultImg(
                                      image: "cart_remove",
                                      width: 20,
                                      height: 20,
                                      padding: const EdgeInsetsDirectional.all(5),
                                      iconColor: ColorsRes.appColor,
                                    ),
                              height: 35,
                              isSetShadow: false,
                            ),
                          ),
                        ),
                        Expanded(
                          child: (cartListProvider.cartListState == CartListState.loading && cartListProvider.currentSelectedProduct == widget.productId && cartListProvider.currentSelectedVariant == widget.productVariantId)
                              ? Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: ColorsRes.appColorWhite,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: AlignmentDirectional.center,
                                  width: 35,
                                  height: 35,
                                  child: Text(
                                    cartListProvider.getItemCartItemQuantity(widget.productId, widget.productVariantId),
                                    softWrap: true,
                                    style: TextStyle(color: ColorsRes.appColorWhite),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: 5),
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Widgets.gradientBtnWidget(
                              context,
                              50,
                              color1: ColorsRes.appColorWhite,
                              color2: ColorsRes.appColorWhite,
                              callback: () async {
                                cartListProvider.currentSelectedProduct = widget.productId;
                                cartListProvider.currentSelectedVariant = widget.productVariantId;
                                Map<String, String> params = {};
                                params[ApiAndParams.productId] = widget.productId;
                                params[ApiAndParams.productVariantId] = widget.productVariantId;
                                params[ApiAndParams.qty] = (int.parse(cartListProvider.getItemCartItemQuantity(widget.productId, widget.productVariantId)) + 1).toString();

                                await cartListProvider.addRemoveCartItem(context: context, params: params, isUnlimitedStock: widget.isUnlimitedStock, maximumAllowedQuantity: widget.maximumAllowedQuantity, availableStock: widget.availableStock, actionFor: "add", from: widget.from);
                              },
                              otherWidgets: Widgets.defaultImg(
                                image: "cart_add",
                                width: 20,
                                height: 20,
                                padding: const EdgeInsetsDirectional.all(5),
                                iconColor: ColorsRes.appColor,
                              ),
                              height: 30,
                              isSetShadow: false,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink();
      },
    );
  }
}

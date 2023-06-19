import 'package:egrocer/helper/generalWidgets/productCartButton.dart';
import 'package:egrocer/helper/provider/selectedVariantItemProvider.dart';
import 'package:egrocer/helper/styles/colorsRes.dart';
import 'package:egrocer/helper/styles/designConfig.dart';
import 'package:egrocer/helper/utils/constant.dart';
import 'package:egrocer/helper/utils/generalMethods.dart';
import 'package:egrocer/models/productListItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets.dart';

class ProductVariantDropDownMenuList extends StatefulWidget {
  final List<Variants> variants;
  final String from;
  final ProductListItem product;
  final bool isGrid;

  const ProductVariantDropDownMenuList({
    Key? key,
    required this.variants,
    required this.from,
    required this.product,
    required this.isGrid,
  }) : super(key: key);

  @override
  State<ProductVariantDropDownMenuList> createState() => _ProductVariantDropDownMenuListState();
}

class _ProductVariantDropDownMenuListState extends State<ProductVariantDropDownMenuList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedVariantItemProvider>(
      builder: (context, selectedVariantItemProvider, _) {
        return widget.variants.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          double.parse(widget.variants[selectedVariantItemProvider.getSelectedIndex()].discountedPrice.toString()) != 0 ? GeneralMethods.getCurrencyFormat(double.parse(widget.variants[selectedVariantItemProvider.getSelectedIndex()].discountedPrice.toString())) : GeneralMethods.getCurrencyFormat(double.parse(widget.variants[selectedVariantItemProvider.getSelectedIndex()].price.toString())),
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
                              text: double.parse(widget.variants[0].discountedPrice.toString()) != 0 ? GeneralMethods.getCurrencyFormat(double.parse(widget.variants[0].price.toString())) : "",
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
                            if (widget.variants.length > 1) {
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
                                                ClipRRect(borderRadius: Constant.borderRadius10, clipBehavior: Clip.antiAliasWithSaveLayer, child: Widgets.setNetworkImg(boxFit: BoxFit.fill, image: widget.product.imageUrl.toString(), height: 70, width: 70)),
                                                Widgets.getSizedBox(
                                                  width: Constant.size10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    widget.product.name.toString(),
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
                                              itemCount: widget.variants.length,
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
                                                                  text: "${widget.variants[index].measurement} ",
                                                                ),
                                                                WidgetSpan(
                                                                  child: Text(
                                                                    widget.variants[index].stockUnitName.toString(),
                                                                    softWrap: true,
                                                                    //superscript is usually smaller in size
                                                                    // textScaleFactor: 0.7,
                                                                    style: const TextStyle(
                                                                      fontSize: 14,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextSpan(text: double.parse(widget.variants[index].discountedPrice.toString()) != 0 ? " | " : "", style: TextStyle(color: ColorsRes.mainTextColor)),
                                                                TextSpan(
                                                                  style: TextStyle(fontSize: 13, color: ColorsRes.mainTextColor, decoration: TextDecoration.lineThrough, decorationThickness: 2),
                                                                  text: double.parse(widget.variants[index].discountedPrice.toString()) != 0 ? GeneralMethods.getCurrencyFormat(double.parse(widget.variants[index].price.toString())) : "",
                                                                ),
                                                              ]),
                                                            ),
                                                          ),
                                                          Text(
                                                            double.parse(widget.variants[index].discountedPrice.toString()) != 0 ? GeneralMethods.getCurrencyFormat(double.parse(widget.variants[index].discountedPrice.toString())) : GeneralMethods.getCurrencyFormat(double.parse(widget.variants[index].price.toString())),
                                                            softWrap: true,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(fontSize: 17, color: ColorsRes.appColor, fontWeight: FontWeight.w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ProductCartButton(
                                                      productId: widget.product.id.toString(),
                                                      productVariantId: widget.variants[index].id.toString(),
                                                      count: int.parse(widget.variants[index].status.toString()) == 0 ? -1 : int.parse(widget.variants[index].cartCount.toString()),
                                                      isUnlimitedStock: widget.product.isUnlimitedStock == "1",
                                                      maximumAllowedQuantity: double.parse(widget.product.totalAllowedQuantity.toString()),
                                                      availableStock: double.parse(widget.variants[index].stock.toString()),
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
                            margin: widget.isGrid ? EdgeInsets.zero : EdgeInsetsDirectional.only(end: 10),
                            decoration: BoxDecoration(
                              borderRadius: Constant.borderRadius5,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: Container(
                              padding: widget.variants.length > 1 ? EdgeInsets.zero : EdgeInsets.all(5),
                              alignment: AlignmentDirectional.center,
                              height: 35,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Spacer(),
                                  Text(
                                    "${widget.variants[0].measurement} ${widget.variants[0].stockUnitName}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorsRes.mainTextColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if (widget.variants.length > 1)
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
                          productId: widget.product.id.toString(),
                          productVariantId: widget.variants[selectedVariantItemProvider.getSelectedIndex()].id.toString(),
                          count: int.parse(widget.variants[selectedVariantItemProvider.getSelectedIndex()].status.toString()) == 0 ? -1 : int.parse(widget.variants[selectedVariantItemProvider.getSelectedIndex()].cartCount.toString()),
                          isUnlimitedStock: widget.product.isUnlimitedStock == "1",
                          maximumAllowedQuantity: double.parse(widget.product.totalAllowedQuantity.toString()),
                          availableStock: double.parse(widget.variants[selectedVariantItemProvider.getSelectedIndex()].stock.toString()),
                          isGrid: widget.isGrid,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}

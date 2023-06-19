import 'package:egrocer/helper/utils/generalImports.dart';

class PromoCodeListScreen extends StatefulWidget {
  final double amount;

  const PromoCodeListScreen({Key? key, required this.amount}) : super(key: key);

  @override
  State<PromoCodeListScreen> createState() => _PromoCodeListScreenState();
}

class _PromoCodeListScreenState extends State<PromoCodeListScreen> {
  @override
  void initState() {
    super.initState();

    //fetch PromoCodeList from api
    Future.delayed(Duration.zero).then((value) async {
      await context.read<PromoCodeProvider>().getPromoCodeProvider(
        params: {ApiAndParams.amount: widget.amount.toString()},
        context: context,
      );
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
          getTranslatedValue(
            context,
            "lblPromoCodes",
          ),
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return true;
        },
        child: setRefreshIndicator(
          refreshCallback: () async {
            await context.read<PromoCodeProvider>().getPromoCodeProvider(
              params: {ApiAndParams.amount: widget.amount.toString()},
              context: context,
            );
          },
          child: SingleChildScrollView(
            child: Consumer<PromoCodeProvider>(
              builder: (context, promoCodeProvider, _) {
                return promoCodeProvider.promoCodeState == PromoCodeState.loading
                    ? promoCodeListShimmer()
                    : promoCodeProvider.promoCodeState == PromoCodeState.loaded
                        ? Column(
                            children: List.generate(
                              promoCodeProvider.promoCode.data.length,
                              (index) => promoCodeItemWidget(
                                promoCodeProvider.promoCode.data[index],
                              ),
                            ),
                          )
                        : DefaultBlankItemMessageScreen(
                            image: "blank_promo_code",
                            title: "No Coupon Available",
                            description: "There is no coupon code to show you right now.",
                            btntext: "Go Back",
                            callback: () {
                              Navigator.pop(context);
                            },
                          );
              },
            ),
          ),
        ),
      ),
    );
  }

  promoCodeItemWidget(PromoCodeData promoCode) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsetsDirectional.all(Constant.size10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: Constant.borderRadius10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Widgets.setNetworkImg(
                boxFit: BoxFit.fill,
                image: promoCode.imageUrl,
                height: 50,
                width: 50,
              ),
            ),
            Widgets.getSizedBox(
              height: Constant.size7,
            ),
            Text(
              promoCode.promoCodeMessage,
              softWrap: true,
              style: const TextStyle(fontSize: 16),
            ),
            Widgets.getSizedBox(
              height: Constant.size7,
            ),
            Text(
              promoCode.isApplicable == "0"
                  ? promoCode.message
                  : "You will save ${GeneralMethods.getCurrencyFormat(
                      double.parse(
                        promoCode.discount,
                      ),
                    )} on this coupon",
              softWrap: true,
              style: TextStyle(
                color: promoCode.isApplicable == "0" ? ColorsRes.appColorRed : ColorsRes.subTitleMainTextColor,
              ),
            ),
            Widgets.getSizedBox(height: Constant.size7),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: Constant.size12,
                    ),
                    child: promoCodeWidget(
                      promoCode.promoCode,
                      promoCode.isApplicable == "0" ? ColorsRes.grey : ColorsRes.appColor,
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      if (promoCode.isApplicable == "1" && Constant.selectedCoupon != promoCode.promoCode) {
                        context.read<PromoCodeProvider>().applyPromoCode(promoCode);
                        Navigator.pop(context, true);
                      } else {
                        context.read<PromoCodeProvider>().removePromoCode();
                      }
                    },
                    child: Constant.selectedCoupon != promoCode.promoCode
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: Constant.size5,
                              horizontal: Constant.size7,
                            ),
                            decoration: DesignConfig.boxDecoration(
                              promoCode.isApplicable == "0" ? ColorsRes.grey.withOpacity(0.2) : ColorsRes.appColorLightHalfTransparent,
                              5,
                              bordercolor: promoCode.isApplicable == "0" ? ColorsRes.grey : ColorsRes.appColor,
                              isboarder: true,
                              borderwidth: 1,
                            ),
                            child: Center(
                              child: Text(
                                getTranslatedValue(
                                  context,
                                  "lblApply",
                                ),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: promoCode.isApplicable == "0" ? ColorsRes.grey : ColorsRes.appColor,
                                    ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              getTranslatedValue(
                                context,
                                "lblApplied",
                              ),
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontSize: 13,
                                    color: ColorsRes.appColor,
                                  ),
                            ),
                          ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  promoCodeWidget(String promoCode, Color color) {
    return Consumer<PromoCodeProvider>(
      builder: (context, promoCodeProvider, child) {
        return GestureDetector(
          onTap: () {
            //
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: 30,
                decoration: DesignConfig.boxDecoration(color.withOpacity(0.2), 7),
                child: DashedRect(
                  color: color,
                  strokeWidth: 1.0,
                  gap: 10,
                ),
              ),
              Center(
                child: Text(promoCode),
              )
            ],
          ),
        );
      },
    );
  }

  promoCodeListShimmer() {
    return Column(
      children: List.generate(10, (index) {
        return const CustomShimmer(
          height: 150,
          width: double.maxFinite,
          borderRadius: 10,
          margin: EdgeInsetsDirectional.all(5),
        );
      }),
    );
  }
}

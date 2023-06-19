import 'package:egrocer/helper/utils/generalImports.dart';

class AddressListScreen extends StatefulWidget {
  final String? from;

  const AddressListScreen({Key? key, this.from = ""}) : super(key: key);

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  ScrollController scrollController = ScrollController();

  scrollListener() {
    // nextPageTrigger will have a value equivalent to 70% of the list size.
    var nextPageTrigger = 0.7 * scrollController.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current position of the user on the screen has surpassed
    if (scrollController.position.pixels > nextPageTrigger) {
      if (mounted) {
        if (context.read<AddressProvider>().hasMoreData) {
          context.read<AddressProvider>().getAddressProvider(context: context);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //fetch cartList from api
    Future.delayed(Duration.zero).then((value) async {
      await context.read<AddressProvider>().getAddressProvider(context: context);

      scrollController.addListener(scrollListener);
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
    return WillPopScope(
      onWillPop: () {
        if (widget.from == "checkout" && context.read<AddressProvider>().addresses.isEmpty) {
          Navigator.pop(context, null);
        } else if (widget.from == "checkout" && context.read<AddressProvider>().addresses.length == 1) {
          Navigator.pop(context, context.read<AddressProvider>().addresses[0]);
        } else {
          Navigator.pop(context, "");
        }

        return Future.value(true);
      },
      child: Scaffold(
        appBar: getAppBar(
          context: context,
          title: Text(
            getTranslatedValue(
              context,
              "lblAddress",
            ),
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          onTap: () {
            if (widget.from == "checkout" && context.read<AddressProvider>().addresses.isEmpty) {
              Navigator.pop(context, null);
            } else if (widget.from == "checkout" && context.read<AddressProvider>().addresses.length == 1) {
              Navigator.pop(context, context.read<AddressProvider>().addresses[0]);
            } else {
              Navigator.pop(context, "");
            }
          },
        ),
        body: Consumer<AddressProvider>(
          builder: (context, addressProvider, child) {
            return Stack(
              children: [
                setRefreshIndicator(
                    refreshCallback: () async {
                      context.read<AddressProvider>().offset = 0;
                      context.read<AddressProvider>().addresses = [];
                      await context.read<AddressProvider>().getAddressProvider(context: context);
                    },
                    child: Column(
                      children: [
                        Expanded(
                            child: (addressProvider.addressState == AddressState.loaded || addressProvider.addressState == AddressState.editing)
                                ? ListView(
                                    controller: scrollController,
                                    children: [
                                      Column(
                                        children: List.generate(addressProvider.addresses.length, (index) {
                                          AddressData address = addressProvider.addresses[index];
                                          return GestureDetector(
                                            onTap: () {
                                              if (widget.from == "checkout") {
                                                Navigator.pop(context, address);
                                              } else {
                                                addressProvider.setSelectedAddress(int.parse(address.id.toString()));
                                              }
                                            },
                                            child: Card(
                                              color: Theme.of(context).cardColor,
                                              child: Padding(
                                                padding: EdgeInsets.all(Constant.size10),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      addressProvider.selectedAddressId == int.parse(address.id.toString()) ? Icons.radio_button_on_outlined : Icons.radio_button_off_rounded,
                                                      color: addressProvider.selectedAddressId == int.parse(address.id.toString()) ? ColorsRes.appColor : ColorsRes.grey,
                                                    ),
                                                    Widgets.getSizedBox(
                                                      width: Constant.size5,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                address.name ?? "",
                                                                softWrap: true,
                                                                style: const TextStyle(fontSize: 18),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushNamed(context, addressDetailScreen, arguments: [address, context]);
                                                                },
                                                                child: Container(
                                                                  height: 25,
                                                                  width: 25,
                                                                  decoration: DesignConfig.boxGradient(5),
                                                                  padding: const EdgeInsets.all(5),
                                                                  margin: EdgeInsets.zero,
                                                                  child: Widgets.defaultImg(
                                                                    image: "edit_icon",
                                                                    iconColor: ColorsRes.mainIconColor,
                                                                    height: 20,
                                                                    width: 20,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Widgets.getSizedBox(
                                                            height: Constant.size7,
                                                          ),
                                                          Text(
                                                            "${address.area},${address.landmark}, ${address.address}, ${address.state}, ${address.city}, ${address.country} - ${address.pincode} ",
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                /*fontSize: 18,*/
                                                                color: ColorsRes.subTitleMainTextColor),
                                                          ),
                                                          Widgets.getSizedBox(
                                                            height: Constant.size7,
                                                          ),
                                                          Text(
                                                            address.mobile ?? "",
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                /*fontSize: 18,*/
                                                                color: ColorsRes.subTitleMainTextColor),
                                                          ),
                                                          Widgets.getSizedBox(
                                                            height: Constant.size7,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              context.read<AddressProvider>().deleteAddress(address: address, context: context);
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(vertical: Constant.size5, horizontal: Constant.size7),
                                                              decoration: DesignConfig.boxDecoration(
                                                                ColorsRes.appColorRed,
                                                                5,
                                                                isboarder: false,
                                                              ),
                                                              child: Text(
                                                                  getTranslatedValue(
                                                                    context,
                                                                    "lblDeleteAddress",
                                                                  ),
                                                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorsRes.appColorWhite)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      if (addressProvider.addressState == AddressState.loadingMore) getAddressShimmer(),
                                    ],
                                  )
                                : addressProvider.addressState == AddressState.loading
                                    ? getAddressListShimmer()
                                    : addressProvider.addressState == AddressState.error
                                        ? DefaultBlankItemMessageScreen(
                                            image: "no_address_icon",
                                            title: getTranslatedValue(
                                              context,
                                              "lblNoAddressFoundTitle",
                                            ),
                                            description: getTranslatedValue(
                                              context,
                                              "lblNoAddressFoundDescription",
                                            ),
                                          )
                                        : const SizedBox.shrink()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size10),
                          child: Widgets.gradientBtnWidget(
                            context,
                            10,
                            isSetShadow: false,
                            callback: () {
                              Navigator.pushNamed(context, addressDetailScreen, arguments: [null, context]);
                            },
                            title: getTranslatedValue(
                              context,
                              "lblAddNewAddress",
                            ),
                          ),
                        ),
                      ],
                    )),
                if (addressProvider.addressState == AddressState.editing)
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    start: 0,
                    bottom: 0,
                    child: Container(color: Colors.black.withOpacity(0.2), child: const Center(child: CircularProgressIndicator())),
                  )
              ],
            );
          },
        ),
      ),
    );
  }

  getAddressShimmer() {
    return CustomShimmer(
      borderRadius: Constant.size10,
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.all(Constant.size5),
    );
  }

  getAddressListShimmer() {
    return ListView(
      children: List.generate(10, (index) => getAddressShimmer()),
    );
  }
}

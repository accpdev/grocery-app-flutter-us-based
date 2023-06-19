import 'package:egrocer/helper/repositories/userDetailApi.dart';
import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:egrocer/screens/mainHomeScreen/homeScreen/widget/homeScreenProductListItem.dart';
import 'package:egrocer/screens/mainHomeScreen/homeScreen/widget/sliderImageWidget.dart';

import 'widget/offerImagesWidget.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;

  const HomeScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<String>> map = {};

  @override
  void initState() {
    super.initState();
    //fetch productList from api
    Future.delayed(Duration.zero).then(
      (value) async {
        try {
          FirebaseMessaging.instance.getToken().then((token) {
            if (Constant.session.getData(SessionManager.keyFCMToken).isEmpty) {
              Constant.session.setData(SessionManager.keyFCMToken, token!, false);
              registerFcmKey(context: context, fcmToken: token);
            }
          });
        } catch (ignore) {}

        await getAppSettings(context: context);

        Map<String, String> params = await Constant.getProductsDefaultParams();
        await context.read<HomeScreenProvider>().getHomeScreenApiProvider(context: context, params: params).then((homeScreenData) async {
          if (homeScreenData != null) {
            HomeScreenData homeData = homeScreenData;
            map = await getSliderImages(homeData);
          }
        });

        if (Constant.session.getBoolData(SessionManager.isUserLogin)) {
          await context.read<CartListProvider>().getAllCartItems(context: context);

          await getUserDetail(context: context).then(
            (value) {
              if (value[ApiAndParams.status].toString() == "1") {
                context.read<UserProfileProvider>().updateUserDataInSession(value);
              }
            },
          );
        }
        final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

        if (initialLink != null) {
          final Uri deepLink = initialLink.link;
          if (deepLink.path.split("/")[1] == "product") {
            Navigator.pushNamed(
              context,
              productDetailScreen,
              arguments: [
                deepLink.path.split("/")[2].toString(),
                getTranslatedValue(
                  context,
                  "lblProductDetail",
                ),
                null
              ],
            );
          }
        }

        FirebaseDynamicLinks.instance.onLink.listen(
          (dynamicLinkData) {
            if (dynamicLinkData.link.path.split("/")[1] == "product") {
              Navigator.pushNamed(
                context,
                productDetailScreen,
                arguments: [
                  dynamicLinkData.link.path.split("/")[2].toString(),
                  getTranslatedValue(
                    context,
                    "lblProductDetail",
                  ),
                  null
                ],
              );
            }
          },
        );
      },
    );
  }

  Future<Map<String, List<String>>> getSliderImages(HomeScreenData homeScreenData) async {
    Map<String, List<String>> map = {};

    for (int i = 0; i < homeScreenData.offers.length; i++) {
      Offers offerImage = homeScreenData.offers[i];
      if (offerImage.position == "top") {
        addOfferImagesIntoMap(map, "top", offerImage.imageUrl);
      } else if (offerImage.position == "below_category") {
        addOfferImagesIntoMap(map, "below_category", offerImage.imageUrl);
      } else if (offerImage.position == "below_slider") {
        addOfferImagesIntoMap(map, "below_slider", offerImage.imageUrl);
      } else if (offerImage.position == "below_section") {
        addOfferImagesIntoMap(map, "below_section-${offerImage.sectionPosition}", offerImage.imageUrl);
      }
    }
    return map;
  }

  Map<String, List<String>> addOfferImagesIntoMap(Map<String, List<String>> map, String key, String imageUrl) {
    if (map.containsKey(key)) {
      map[key]?.add(imageUrl);
    } else {
      map[key] = [];
      map[key]?.add(imageUrl);
    }
    return map;
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
        title: deliverAddressWidget(),
        centerTitle: false,
        actions: [setCartCounter(context: context)],
        showBackButton: false,
      ),
      body: Column(
        children: [
          getSearchWidget(
            context: context,
          ),
          Expanded(
            child: setRefreshIndicator(
              refreshCallback: () async {
                Map<String, String> params = await Constant.getProductsDefaultParams();
                return await context.read<HomeScreenProvider>().getHomeScreenApiProvider(context: context, params: params).then((homeScreenData) async {
                  map = await getSliderImages(homeScreenData);
                });
              },
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Consumer<HomeScreenProvider>(
                  builder: (context, homeScreenProvider, _) {
                    return homeScreenProvider.homeScreenState == HomeScreenState.loaded
                        ? Column(
                            children: [
                              //top offer images
                              if (map.containsKey("top")) getOfferImages(map["top"]!.toList()),
                              ChangeNotifierProvider<SliderImagesProvider>(
                                create: (context) => SliderImagesProvider(),
                                child: SliderImageWidget(
                                  sliders: homeScreenProvider.homeScreenData.sliders,
                                ),
                              ),
                              //below slider offer images
                              if (map.containsKey("below_slider")) getOfferImages(map["below_slider"]!.toList()),
                              // CategoryListScreen(scrollController: ScrollController()),
                              categoryWidget(homeScreenProvider.homeScreenData.category),
                              // Container(
                              //   child: CategoryListWidget(
                              //     scrollController: widget.scrollController,
                              //   ),
                              //   constraints: BoxConstraints(maxHeight: 450),
                              // ),
                              //below category offer images
                              if (map.containsKey("below_category")) getOfferImages(map["below_category"]!.toList()),
                              sectionWidget(homeScreenProvider.homeScreenData.sections)
                            ],
                          )
                        : (homeScreenProvider.homeScreenState == HomeScreenState.loading || homeScreenProvider.homeScreenState == HomeScreenState.initial)
                            ? getHomeScreenShimmer()
                            : Container();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

// APP BAR UI STARTS
  deliverAddressWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, getLocationScreen, arguments: "location").then((value) async {
          if (value == null) {
            Map<String, String> params = await Constant.getProductsDefaultParams();
            return await context.read<HomeScreenProvider>().getHomeScreenApiProvider(context: context, params: params).then((homeScreenData) async {
              map = await getSliderImages(homeScreenData);
              setState(() {});
            });
          }
        });
      },
      child: ListTile(
        contentPadding: EdgeInsetsDirectional.zero,
        horizontalTitleGap: 0,
        leading: Widgets.getDarkLightIcon(image: "home_map", height: 35, width: 35, padding: EdgeInsetsDirectional.only(top: Constant.size10, bottom: Constant.size10, end: Constant.size10)),
        title: Text(
          getTranslatedValue(
            context,
            "lblDeliverTo",
          ),
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, color: ColorsRes.mainTextColor, fontWeight: FontWeight.w500),
        ),
        subtitle: Constant.session.getData(SessionManager.keyAddress).isNotEmpty
            ? Text(
                Constant.session.getData(SessionManager.keyAddress),
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: ColorsRes.subTitleMainTextColor),
              )
            : Text(
                getTranslatedValue(
                  context,
                  "lblAddNewAddress",
                ),
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: ColorsRes.subTitleMainTextColor),
              ),
      ),
    );
  }

// APP BAR UI ENDS

// HOME PAGE UI STARTS

//categoryList ui
  categoryWidget(List<Category> categories) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
            color: Theme.of(context).cardColor,
            elevation: 0,
            margin: EdgeInsetsDirectional.only(start: Constant.size10, end: Constant.size10, top: Constant.size10, bottom: Constant.size5),
            child: GridView.builder(
              itemCount: Constant.homeCategoryMaxLength == 0
                  ? categories.length
                  : categories.length >= Constant.homeCategoryMaxLength
                      ? Constant.homeCategoryMaxLength
                      : categories.length,
              padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                Category category = categories[index];
                return CategoryItemContainer(
                    category: category,
                    voidCallBack: () {
                      Navigator.pushNamed(context, productListScreen, arguments: ["category", category.id.toString(), category.name]);
                    });
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.8, crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
            ))
      ],
    );
  }

//sectionList ui
  sectionWidget(List<Sections>? sections) {
    return Column(
      children: List.generate(sections!.length, (index) {
        Sections section = sections[index];
        return section.products.isNotEmpty
            ? Column(
                children: [
                  Card(
                    color: Theme.of(context).cardColor,
                    elevation: 0,
                    margin: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Constant.size5, vertical: Constant.size5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  section.title,
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 15, color: ColorsRes.appColor, fontWeight: FontWeight.w500),
                                ),
                                Widgets.getSizedBox(
                                  height: Constant.size5,
                                ),
                                Text(
                                  section.shortDescription,
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12, color: ColorsRes.subTitleMainTextColor),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, productListScreen, arguments: ["sections", section.id.toString(), section.title]);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: DesignConfig.boxDecoration(
                                ColorsRes.appColorLightHalfTransparent,
                                5,
                                bordercolor: ColorsRes.appColor,
                                isboarder: true,
                                borderwidth: 1,
                              ),
                              child: Text(
                                getTranslatedValue(
                                  context,
                                  "lblSeeAll",
                                ),
                                softWrap: true,
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: ColorsRes.appColor,
                                    ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 5),
                      child: Row(
                        children: List.generate(section.products.length, (index) {
                          ProductListItem product = section.products[index];
                          return HomeScreenProductListItem(
                            product: product,
                            position: index,
                          );
                        }),
                      ),
                    ),
                  ),
                  //below section offer images
                  if (map.containsKey("below_section-${section.id}")) getOfferImages(map["below_section-${section.id}"]?.toList()),
                ],
              )
            : Container();
      }),
    );
  }

  Widget getHomeScreenShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constant.size10, horizontal: Constant.size10),
      child: Column(
        children: [
          CustomShimmer(
            height: MediaQuery.of(context).size.height * 0.26,
            width: MediaQuery.of(context).size.width,
          ),
          Widgets.getSizedBox(
            height: Constant.size10,
          ),
          CustomShimmer(
            height: Constant.size10,
            width: MediaQuery.of(context).size.width,
          ),
          Widgets.getSizedBox(
            height: Constant.size10,
          ),
          getCategoryShimmer(context: context, count: 6, padding: EdgeInsets.zero),
          Widgets.getSizedBox(
            height: Constant.size10,
          ),
          Column(
            children: List.generate(5, (index) {
              return Column(
                children: [
                  const CustomShimmer(height: 50),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: Constant.size10, horizontal: Constant.size5),
                          child: CustomShimmer(
                            height: 210,
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        );
                      }),
                    ),
                  )
                ],
              );
            }),
          )
        ],
      ),
    );
  }

// HOME PAGE UI ENDS
}

import 'package:egrocer/helper/utils/generalImports.dart';
import 'package:egrocer/screens/mainHomeScreen/homeScreen/widget/customDialog.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => HomeMainScreenState();
}

class HomeMainScreenState extends State<HomeMainScreen> {
  NetworkStatus networkStatus = NetworkStatus.online;
  int currentPage = 0;

  List<ScrollController> scrollController = [ScrollController(), ScrollController(), ScrollController(), ScrollController()];

  //total pageListing
  List<Widget> pages = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    pages = [
      ChangeNotifierProvider<ProductListProvider>(
        create: (context) {
          return ProductListProvider();
        },
        child: HomeScreen(
          scrollController: scrollController[0],
        ),
      ),
      CategoryListScreen(
        scrollController: scrollController[1],
      ),
      WishListScreen(
        scrollController: scrollController[2],
      ),
      ProfileScreen(
        scrollController: scrollController[3],
      )
    ];

    Future.delayed(
      Duration.zero,
      () async {
        if (Constant.session.getData(SessionManager.keyLatitude) == "0" && Constant.session.getData(SessionManager.keyLongitude) == "0") {
          Navigator.pushNamed(context, getLocationScreen, arguments: "location");
        } else {
          if (currentPage == 0) {
            if (Constant.session.getBoolData(SessionManager.keyPopupOfferEnabled)) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog();
                },
              );
            }
          }

          if (Constant.session.isUserLoggedIn()) {
            await getAppNotificationSettingsRepository(params: {}, context: context).then(
              (value) async {
                if (value[ApiAndParams.status].toString() == "1") {
                  late AppNotificationSettings notificationSettings = AppNotificationSettings.fromJson(value);
                  if (notificationSettings.data!.isEmpty) {
                    await updateAppNotificationSettingsRepository(params: {ApiAndParams.statusIds: "1,2,3,4,5,6,7,8", ApiAndParams.mobileStatuses: "1,1,1,1,1,1,1,1", ApiAndParams.mailStatuses: "1,1,1,1,1,1,1,1"}, context: context);
                  }
                }
              },
            );
          }
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: homeBottomNavigation(currentPage, selectBottomMenu, pages.length, context),
      body: networkStatus == NetworkStatus.online
          ? WillPopScope(
              onWillPop: () {
                if (currentPage == 0) {
                  return Future.value(true);
                } else {
                  if (mounted) {
                    if (currentPage == 1) {
                      if (mounted) {
                        if (context.read<CategoryListProvider>().selectedCategoryIdsList.length > 1) {
                          context.read<CategoryListProvider>().removeLastCategoryData();
                        } else {
                          setState(
                            () {
                              currentPage = 0;
                            },
                          );
                        }
                      }
                    } else {
                      setState(
                        () {
                          currentPage = 0;
                        },
                      );
                    }
                  }
                  return Future.value(false);
                }
              },
              child: IndexedStack(
                index: currentPage,
                children: pages,
              ),
            )
          : Center(
              child: Text(
                getTranslatedValue(
                  context,
                  "lblCheckInternet",
                ),
              ),
            ),
    );
  }

  homeBottomNavigation(int selectedIndex, Function selectBottomMenu, int totalPage, BuildContext context) {
    List lblHomeBottomMenu = [
      getTranslatedValue(
        context,
        "lblHomeBottomMenuHome",
      ),
      getTranslatedValue(
        context,
        "lblHomeBottomMenuCategory",
      ),
      getTranslatedValue(
        context,
        "lblHomeBottomMenuWishlist",
      ),
      getTranslatedValue(
        context,
        "lblHomeBottomMenuProfile",
      ),
    ];
    return BottomNavigationBar(
        items: List.generate(
          totalPage,
          (index) => BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: Widgets.getHomeBottomNavigationBarIcons(isActive: selectedIndex == index)[index],
            label: lblHomeBottomMenu[index],
          ),
        ),
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        selectedItemColor: ColorsRes.mainTextColor,
        unselectedItemColor: Colors.transparent,
        onTap: (int ind) {
          selectBottomMenu(ind);
        },
        elevation: 5);
  }

  //change current screen based on bottom menu selection
  selectBottomMenu(int index) {
    if (mounted) {
      setState(
        () {
          try {
            if (index == currentPage) {
              scrollController[currentPage].animateTo(0, duration: const Duration(milliseconds: 400), curve: Curves.linear);
            }

            currentPage = index;
          } catch (_) {}
        },
      );
    }
  }
}

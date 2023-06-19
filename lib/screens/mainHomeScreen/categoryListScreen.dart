import 'package:egrocer/helper/utils/generalImports.dart';

class CategoryListScreen extends StatefulWidget {
  final ScrollController scrollController;

  const CategoryListScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    //fetch categoryList from api
    Future.delayed(Duration.zero).then((value) {
      context.read<CategoryListProvider>().selectedCategoryIdsList = ["0"];
      context.read<CategoryListProvider>().selectedCategoryNamesList = [
        getTranslatedValue(
          context,
          "lblAll",
        )
      ];

      Map<String, String> params = {};
      params[ApiAndParams.categoryId] = context.read<CategoryListProvider>().selectedCategoryIdsList[context.read<CategoryListProvider>().selectedCategoryIdsList.length - 1];

      context.read<CategoryListProvider>().getCategoryApiProvider(context: context, params: params);
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
              "lblCategories",
            ),
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          actions: [
            setCartCounter(context: context),
          ],
          showBackButton: false),
      body: Column(
        children: [
          getSearchWidget(
            context: context,
          ),
          Expanded(
            child: setRefreshIndicator(
              refreshCallback: () {
                Map<String, String> params = {};
                params[ApiAndParams.categoryId] = context.read<CategoryListProvider>().selectedCategoryIdsList[context.read<CategoryListProvider>().selectedCategoryIdsList.length - 1];

                return context.read<CategoryListProvider>().getCategoryApiProvider(context: context, params: params);
              },
              child: ListView(
                children: [subCategorySequenceWidget(), categoryWidget()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //categoryList ui
  categoryWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<CategoryListProvider>(
          builder: (context, categoryListProvider, _) {
            return categoryListProvider.categoryState == CategoryState.loaded
                ? Card(
                    color: Theme.of(context).cardColor,
                    elevation: 0,
                    margin: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (categoryListProvider.selectedCategoryIdsList.length > 1)
                          GestureDetector(
                            onTap: () {
                              categoryListProvider.removeLastCategoryData();
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: 15,
                                start: 15,
                                bottom: 5,
                              ),
                              child: SizedBox(
                                child: Widgets.defaultImg(
                                  image: "ic_arrow_back",
                                  iconColor: ColorsRes.mainTextColor,
                                ),
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                        GridView.builder(
                          itemCount: categoryListProvider.categories.length,
                          padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            Category category = categoryListProvider.categories[index];

                            categoryListProvider.subCategoriesList[categoryListProvider.selectedCategoryIdsList[categoryListProvider.selectedCategoryIdsList.length - 1]] = categoryListProvider.categories;
                            return CategoryItemContainer(
                              category: category,
                              voidCallBack: () {
                                if (category.hasChild) {
                                  addItemsInCategorySequenceList(category).then((value) {
                                    Map<String, String> params = {};
                                    params[ApiAndParams.categoryId] = category.id.toString();

                                    context.read<CategoryListProvider>().getCategoryApiProvider(context: context, params: params);
                                  });
                                } else {
                                  Navigator.pushNamed(context, productListScreen, arguments: ["category", category.id.toString(), category.name]);
                                }
                              },
                            );
                          },
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.8, crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                        ),
                      ],
                    ),
                  )
                : categoryListProvider.categoryState == CategoryState.loading
                    ? getCategoryShimmer(context: context, count: 9)
                    : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  //category index widget
  subCategorySequenceWidget() {
    return Consumer<CategoryListProvider>(
      builder: (context, categoryListProvider, _) {
        return categoryListProvider.selectedCategoryIdsList.length > 1
            ? Container(
                margin: EdgeInsets.all(Constant.size10),
                padding: EdgeInsets.all(Constant.size10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 5,
                  spacing: 5,
                  children: List.generate(
                    categoryListProvider.selectedCategoryIdsList.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          if (categoryListProvider.selectedCategoryIdsList.length != index) {
                            categoryListProvider.setCategoryData(index, context);
                          }
                        },
                        child: Text("${categoryListProvider.selectedCategoryNamesList[index]}${categoryListProvider.selectedCategoryNamesList.length == (index + 1) ? "" : " > "}"),
                      );
                    },
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Future addItemsInCategorySequenceList(Category category) async {
    if (context.read<CategoryListProvider>().selectedCategoryIdsList.length <= 0) {
      context.read<CategoryListProvider>().selectedCategoryIdsList.add("0");
      context.read<CategoryListProvider>().selectedCategoryNamesList.add(getTranslatedValue(context, "lblAll"));

      context.read<CategoryListProvider>().selectedCategoryIdsList.add(category.id.toString());
      context.read<CategoryListProvider>().selectedCategoryNamesList.add(category.name);
    } else {
      context.read<CategoryListProvider>().selectedCategoryIdsList.add(category.id.toString());
      context.read<CategoryListProvider>().selectedCategoryNamesList.add(category.name);
    }
  }
}

import 'package:egrocer/helper/utils/generalImports.dart';

class FaqListScreen extends StatefulWidget {
  const FaqListScreen({Key? key}) : super(key: key);

  @override
  State<FaqListScreen> createState() => _FaqListScreenState();
}

class _FaqListScreenState extends State<FaqListScreen> {
  ScrollController scrollController = ScrollController();

  scrollListener() {
    // nextPageTrigger will have a value equivalent to 70% of the list size.
    var nextPageTrigger = 0.7 * scrollController.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current position of the user on the screen has surpassed
    if (scrollController.position.pixels > nextPageTrigger) {
      if (mounted) {
        if (context.read<FaqProvider>().hasMoreData) {
          context.read<FaqProvider>().getFaqProvider(params: {}, context: context);
        }
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      context.read<FaqProvider>().getFaqProvider(params: {}, context: context);
    });

    scrollController.addListener(scrollListener);

    super.initState();
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
    return Scaffold(
      appBar: getAppBar(
          context: context,
          title: Text(
            getTranslatedValue(
              context,
              "lblFAQ",
            ),
            style: TextStyle(color: ColorsRes.mainTextColor),
          )),
      body: setRefreshIndicator(
          refreshCallback: () {
            context.read<FaqProvider>().offset = 0;
            context.read<FaqProvider>().faqs = [];
            return context.read<FaqProvider>().getFaqProvider(params: {}, context: context);
          },
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            child: Consumer<FaqProvider>(builder: (context, faqProvider, _) {
              List<FAQ> faqs = faqProvider.faqs;
              if (faqProvider.itemsState == FaqState.initial || faqProvider.itemsState == FaqState.loading) {
                return getFaqListShimmer();
              } else if (faqProvider.itemsState == FaqState.loaded || faqProvider.itemsState == FaqState.loadingMore) {
                return Column(
                  children: List.generate(faqs.length, (index) {
                    return getFaqExpandableItem(faqs[index]);
                  }),
                );
              } else {
                return DefaultBlankItemMessageScreen(
                  image: "no_faq_icon",
                  title: getTranslatedValue(
                    context,
                    "lblNoFaqFoundTitle",
                  ),
                  description: getTranslatedValue(
                    context,
                    "lblNoFaqFoundMessage",
                  ),
                );
              }
            }),
          )),
    );
  }

  getFaqExpandableItem(FAQ faq) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: DesignConfig.boxDecoration(
          Theme.of(context).cardColor,
          10,
        ),
        child: ExpansionTile(
          initiallyExpanded: faq.isExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() => faq.isExpanded = expanded);
          },
          title: Text(
            faq.question,
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          trailing: Icon(
            faq.isExpanded ? Icons.remove : Icons.add,
          ),
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: Constant.size30, top: Constant.size5, bottom: Constant.size10, end: Constant.size10),
              child: Text(faq.answer),
            )
          ],
        ));
  }

  getFaqListShimmer() {
    return Column(
      children: List.generate(20, (index) => faqItemShimmer()),
    );
  }

  faqItemShimmer() {
    return CustomShimmer(
      margin: EdgeInsets.symmetric(vertical: Constant.size5, horizontal: Constant.size10),
      height: 50,
      width: MediaQuery.of(context).size.width,
    );
  }
}

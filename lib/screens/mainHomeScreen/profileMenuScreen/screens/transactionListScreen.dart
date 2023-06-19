import 'package:egrocer/helper/utils/generalImports.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({Key? key}) : super(key: key);

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  ScrollController scrollController = ScrollController();

  scrollListener() {
    // nextPageTrigger will have a value equivalent to 70% of the list size.
    var nextPageTrigger = 0.7 * scrollController.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current position of the user on the screen has surpassed
    if (scrollController.position.pixels > nextPageTrigger) {
      if (mounted) {
        if (context.read<TransactionProvider>().hasMoreData) {
          context.read<TransactionProvider>().getTransactionProvider(params: {}, context: context);
        }
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    Constant.resetTempFilters();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      context.read<TransactionProvider>().getTransactionProvider(params: {}, context: context);
    });

    scrollController.addListener(scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context: context,
          title: Text(
            getTranslatedValue(
              context,
              "lblTransactions",
            ),
            style: TextStyle(color: ColorsRes.mainTextColor),
          )),
      body: setRefreshIndicator(
          refreshCallback: () {
            context.read<TransactionProvider>().offset = 0;
            context.read<TransactionProvider>().transactions = [];
            return context.read<TransactionProvider>().getTransactionProvider(params: {}, context: context);
          },
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            child: Consumer<TransactionProvider>(builder: (context, transactionProvider, _) {
              List<TransactionData> transactions = transactionProvider.transactions;
              if (transactionProvider.itemsState == TransactionState.initial || transactionProvider.itemsState == TransactionState.loading) {
                return getTransactionListShimmer();
              } else if (transactionProvider.itemsState == TransactionState.loaded || transactionProvider.itemsState == TransactionState.loadingMore) {
                return Column(
                  children: List.generate(transactions.length, (index) {
                    return getTransactionItemWidget(transactions[index]);
                  }),
                );
              } else {
                return Container();
              }
            }),
          )),
    );
  }

  getTransactionItemWidget(TransactionData transaction) {
    return Container(
        padding: EdgeInsets.all(Constant.size10),
        margin: EdgeInsets.symmetric(vertical: Constant.size5, horizontal: Constant.size10),
        decoration: DesignConfig.boxDecoration(
          Theme.of(context).cardColor,
          10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "ID #${transaction.txnId}",
                    softWrap: true,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Widgets.getSizedBox(width: Constant.size10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: Constant.size5, horizontal: Constant.size7),
                  decoration: DesignConfig.boxDecoration(transaction.status.toLowerCase() == "success" ? ColorsRes.appColorGreen.withOpacity(0.1) : ColorsRes.appColorRed.withOpacity(0.1), 5, bordercolor: transaction.status.toLowerCase() == "success" ? ColorsRes.appColorGreen : ColorsRes.appColorRed, isboarder: true, borderwidth: 1),
                  child: Text(GeneralMethods.setFirstLetterUppercase(transaction.status),
                      style: TextStyle(
                        color: transaction.status.toLowerCase() == "success" ? ColorsRes.appColorGreen : ColorsRes.appColorRed,
                      )),
                ),
              ],
            ),
            Widgets.getSizedBox(height: Constant.size10),
            Divider(height: 1, color: ColorsRes.grey, thickness: 0),
            Widgets.getSizedBox(height: Constant.size10),
            Text(
              getTranslatedValue(
                context,
                "lblPaymentMethod",
              ),
              style: TextStyle(fontSize: 14, color: ColorsRes.grey),
              softWrap: true,
            ),
            Widgets.getSizedBox(height: Constant.size2),
            Text(
              transaction.type,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              softWrap: true,
            ),
            Widgets.getSizedBox(height: Constant.size20),
            Text(
              getTranslatedValue(
                context,
                "lblDateAndTime",
              ),
              style: TextStyle(fontSize: 14, color: ColorsRes.grey),
              softWrap: true,
            ),
            Widgets.getSizedBox(height: Constant.size2),
            Text(
              transaction.createdAt,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              softWrap: true,
            ),
            Widgets.getSizedBox(height: Constant.size10),
            Divider(height: 1, color: ColorsRes.grey, thickness: 0),
            Widgets.getSizedBox(height: Constant.size10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getTranslatedValue(
                    context,
                    "lblAmount",
                  ),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                Text(
                  GeneralMethods.getCurrencyFormat(double.parse(transaction.amount)),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorsRes.appColor),
                  softWrap: true,
                ),
              ],
            )
          ],
        ));
  }

  getTransactionListShimmer() {
    return Column(
      children: List.generate(20, (index) => faqItemShimmer()),
    );
  }

  faqItemShimmer() {
    return CustomShimmer(
      margin: EdgeInsets.symmetric(vertical: Constant.size5, horizontal: Constant.size10),
      height: 180,
      width: MediaQuery.of(context).size.width,
    );
  }
}

import 'package:egrocer/helper/utils/generalImports.dart';

class ReturnProductDialog extends StatelessWidget {
  final String orderId;
  final String orderItemId;

  const ReturnProductDialog({
    required this.orderId,
    required this.orderItemId,
    Key? key,
  }) : super(key: key);

  void onReturnProductSuccess(BuildContext context) {
    //Need to pass true so we can update order item status
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (context.read<UpdateOrderStatusProvider>().getUpdateOrderStatus() == UpdateOrderStatus.inProgress) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: AlertDialog(
        title: Text(
          getTranslatedValue(
            context,
            "lblSureToReturnProduct",
          ),
          softWrap: true,
        ),
        actions: [
          Consumer<UpdateOrderStatusProvider>(builder: (context, provider, _) {
            if (provider.getUpdateOrderStatus() == UpdateOrderStatus.inProgress) {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    getTranslatedValue(
                      context,
                      "lblNo",
                    ),
                    softWrap: true,
                    style: TextStyle(color: ColorsRes.mainTextColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<UpdateOrderStatusProvider>().updateStatus(orderId: orderId, orderItemId: orderItemId, status: Constant.orderStatusCode[7], context: context);
                  },
                  child: Text(
                    getTranslatedValue(
                      context,
                      "lblYes",
                    ),
                    softWrap: true,
                    style: TextStyle(color: ColorsRes.appColor),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

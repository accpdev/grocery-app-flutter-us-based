import 'package:egrocer/helper/utils/generalImports.dart';

class CancelProductDialog extends StatelessWidget {
  final String orderId;
  final String orderItemId;

  const CancelProductDialog({Key? key, required this.orderId, required this.orderItemId}) : super(key: key);

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
        title: Text(getTranslatedValue(
          context,
          "lblSureToCancelProduct",
        )),
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
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    getTranslatedValue(
                      context,
                      "lblNo",
                    ),
                    style: TextStyle(color: ColorsRes.mainTextColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<UpdateOrderStatusProvider>().updateStatus(orderId: orderId, orderItemId: orderItemId, status: Constant.orderStatusCode[6], context: context);
                  },
                  child: Text(
                    getTranslatedValue(
                      context,
                      "lblYes",
                    ),
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

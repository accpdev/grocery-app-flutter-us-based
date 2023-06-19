import 'package:egrocer/helper/utils/generalImports.dart';

class CurrentOrderProvider extends ChangeNotifier {
  Order? order;

  updateOrderItem({required String orderItemId, required String activeStatus}) {
    if (order != null) {
      List<OrderItem> orderItems = order!.items;
      for (var i = 0; i < order!.items.length; i++) {
        if (orderItems[i].id == orderItemId.toString()) {
          orderItems[i] = order!.items[i].updateStatus(activeStatus); //Returned
        }
      }
    }
    notifyListeners();
  }
}

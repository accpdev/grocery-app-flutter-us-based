/*
      1 -> Payment pending
      2 -> Received
      3 -> Processed
      4 -> Shipped
      5 -> Out For Delivery
      6 -> Delivered
      7 -> Cancelled
      8 -> Returned
*/

import 'package:egrocer/helper/utils/generalImports.dart';

class OrderTrackingHistoryBottomsheet extends StatelessWidget {
  final List<List> listOfStatus;

  const OrderTrackingHistoryBottomsheet({Key? key, required this.listOfStatus}) : super(key: key);

  bool isStatusSelected(int currentStatus) {
    if (listOfStatus.isNotEmpty) {
      final statusValue = listOfStatus.where((element) => element.first.toString() == currentStatus.toString());

      return statusValue.isNotEmpty;
    }
    return false;
  }

  String getStatusCompleteDate(int currentStatus) {
    if (listOfStatus.isNotEmpty) {
      final statusValue = listOfStatus.where((element) {
        return element.first.toString() == currentStatus.toString();
      }).toList();

      if (statusValue.isNotEmpty) {
        //[2, 04-10-2022 06:13:45am] so fetching last value
        return statusValue.first.last;
      }
    }
    return "";
  }

  Widget _buildDottedLineContainer({required bool isSelected}) {
    return Transform.translate(
      offset: const Offset(5.0, -20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: !isSelected ? ColorsRes.subTitleMainTextColor : ColorsRes.appColor,
            width: 3.5,
            height: 12,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: !isSelected ? ColorsRes.subTitleMainTextColor : ColorsRes.appColor,
            width: 3.5,
            height: 12,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: !isSelected ? ColorsRes.subTitleMainTextColor : ColorsRes.appColor,
            width: 3.5,
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator({required String statusValue, required bool isSelected, required String date}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 7.5,
          backgroundColor: isSelected ? ColorsRes.appColor : ColorsRes.subTitleMainTextColor,
        ),
        SizedBox(
          width: Constant.size10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statusValue,
              softWrap: true,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              date,
              softWrap: true,
              style: TextStyle(color: ColorsRes.subTitleMainTextColor),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * (0.75),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            getTranslatedValue(
              context,
              "lblOrderTracking",
            ),
            softWrap: true,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                _buildStatusIndicator(
                  isSelected: isStatusSelected(3),
                  date: getStatusCompleteDate(3),
                  statusValue: getTranslatedValue(
                    context,
                    "lblOrderConfirmed",
                  ),
                ),

                //Order shipped status is 4
                _buildDottedLineContainer(isSelected: isStatusSelected(4)),
                _buildStatusIndicator(
                  isSelected: isStatusSelected(4),
                  date: getStatusCompleteDate(4),
                  statusValue: getTranslatedValue(
                    context,
                    "lblOrderShipped",
                  ),
                ),

                //5 status is for out for delivery
                _buildDottedLineContainer(isSelected: isStatusSelected(5)),
                _buildStatusIndicator(
                  isSelected: isStatusSelected(5),
                  date: getStatusCompleteDate(5),
                  statusValue: getTranslatedValue(
                    context,
                    "lblOrderOutForDelivery",
                  ),
                ),

                //6 status is for delivered
                _buildDottedLineContainer(isSelected: isStatusSelected(6)),
                _buildStatusIndicator(
                  isSelected: isStatusSelected(6),
                  date: getStatusCompleteDate(6),
                  statusValue: getTranslatedValue(
                    context,
                    "lblOrderDelivered",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

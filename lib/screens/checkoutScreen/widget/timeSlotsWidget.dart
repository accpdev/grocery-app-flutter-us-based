import 'package:egrocer/helper/utils/generalImports.dart';

getTimeSlots(TimeSlotsData? timeSlotsData, BuildContext context) {
  List lblMonthsNames = [
    getTranslatedValue(
      context,
      "lblMonthsNamesJanuary",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesFebruary",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesMarch",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesApril",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesMay",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesJune",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesJuly",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesAugust",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesSeptember",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesOctober",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesNovember",
    ),
    getTranslatedValue(
      context,
      "lblMonthsNamesDecember",
    ),
  ];

  List lblWeekDaysNames = [
    getTranslatedValue(
      context,
      "lblWeekDaysNamesSunday",
    ),
    getTranslatedValue(
      context,
      "lblWeekDaysNamesMonday",
    ),
    getTranslatedValue(
      context,
      "lblWeekDaysNamesTuesday",
    ),
    getTranslatedValue(
      context,
      "lblWeekDaysNamesWednesday",
    ),
    getTranslatedValue(
      context,
      "lblWeekDaysNamesThursday",
    ),
    getTranslatedValue(
      context,
      "lblWeekDaysNamesFriday",
    ),
    getTranslatedValue(
      context,
      "lblWeekDaysNamesSaturday",
    ),
  ];
  return timeSlotsData?.timeSlotsIsEnabled == "true"
      ? Card(
          color: Theme.of(context).cardColor,
          elevation: 0,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: Constant.size10, top: Constant.size10, end: Constant.size10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    getTranslatedValue(
                      context,
                      "lblPreferredDeliveryTime",
                    ),
                    softWrap: true,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ColorsRes.mainTextColor)),
                Widgets.getSizedBox(
                  height: Constant.size5,
                ),
                Divider(color: ColorsRes.grey, height: 1, thickness: 0.1),
                Widgets.getSizedBox(
                  height: Constant.size5,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      int.parse(timeSlotsData?.timeSlotsAllowedDays ?? "0"),
                      (index) {
                        late DateTime dateTime;
                        if (int.parse(timeSlotsData?.timeSlotsDeliveryStartsFrom.toString() ?? "") == 1) {
                          dateTime = DateTime.now();
                        } else {
                          dateTime = DateTime.now().add(Duration(days: int.parse(timeSlotsData?.timeSlotsAllowedDays ?? "")));
                        }
                        return GestureDetector(
                          onTap: () {
                            context.read<CheckoutProvider>().setSelectedDate(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            margin: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 5),
                            decoration: BoxDecoration(
                                color: context.read<CheckoutProvider>().selectedDate == index
                                    ? Constant.session.getBoolData(SessionManager.isDarkTheme)
                                        ? ColorsRes.appColorBlack.withOpacity(0.2)
                                        : ColorsRes.appColorWhite.withOpacity(0.2)
                                    : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                                borderRadius: Constant.borderRadius7,
                                border: Border.all(
                                  width: context.read<CheckoutProvider>().selectedDate == index ? 1 : 0.3,
                                  color: context.read<CheckoutProvider>().selectedDate == index ? ColorsRes.appColor : ColorsRes.grey,
                                )),
                            child: Column(
                              children: [
                                Text(
                                  lblWeekDaysNames[dateTime.add(Duration(days: index)).weekday - 1],
                                  style: TextStyle(color: context.read<CheckoutProvider>().selectedDate == index ? ColorsRes.mainTextColor : ColorsRes.grey),
                                ),
                                Text(dateTime.add(Duration(days: index)).day.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: context.read<CheckoutProvider>().selectedDate == index ? ColorsRes.mainTextColor : ColorsRes.grey)),
                                Text(
                                  lblMonthsNames[dateTime.add(Duration(days: index)).month - 1],
                                  style: TextStyle(color: context.read<CheckoutProvider>().selectedDate == index ? ColorsRes.mainTextColor : ColorsRes.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Widgets.getSizedBox(
                  height: Constant.size5,
                ),
                Column(
                  children: List.generate(timeSlotsData?.timeSlots.length ?? 0, (index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<CheckoutProvider>().setSelectedTime(index);
                      },
                      child: Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          border: BorderDirectional(
                            bottom: BorderSide(
                              width: 1,
                              color: timeSlotsData?.timeSlots.length == index + 1 ? Colors.transparent : ColorsRes.grey.withOpacity(0.1),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: Constant.size10),
                              child: Text(
                                timeSlotsData?.timeSlots[index].title ?? "",
                              ),
                            ),
                            const Spacer(),
                            Radio(
                              value: context.read<CheckoutProvider>().selectedTime,
                              groupValue: index,
                              activeColor: ColorsRes.appColor,
                              onChanged: (value) {
                                context.read<CheckoutProvider>().setSelectedTime(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Widgets.getSizedBox(
                  height: Constant.size10,
                ),
              ],
            ),
          ),
        )
      : const SizedBox.shrink();
}

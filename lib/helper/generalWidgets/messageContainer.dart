// ignore_for_file: non_constant_identifier_names

import 'package:egrocer/helper/utils/generalImports.dart';

Widget MessageContainer({
  required BuildContext context,
  required String text,
  required MessageType type,
}) {
  return Material(
    child: ToastAnimation(
      delay: Constant.messageDisplayDuration,
      child: Row(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  // using gradient to apply one side dark color in container
                  gradient: LinearGradient(stops: const [
                    0.02,
                    0.02
                  ], colors: [
                    messageColors[type]!,
                    messageColors[type]!.withOpacity(0.1),
                  ]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: messageColors[type]!.withOpacity(0.5),
                  )),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    start: 10,
                    child: Container(
                      height: 30,
                      width: 30,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: messageColors[type],
                      ),
                      child: Icon(
                        messageIcon[type],
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    start: 40,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(text, softWrap: true, maxLines: 5, overflow: TextOverflow.ellipsis, style: TextStyle(color: messageColors[type], fontWeight: FontWeight.w600, fontSize: 12, letterSpacing: 1.2)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

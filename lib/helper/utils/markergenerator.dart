import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MarkerGenerator {
  final Function(List<Uint8List>) callback;
  final Widget markerWidgets;

  MarkerGenerator(this.markerWidgets, this.callback);

  void generate(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) {
    addOverlay(context);
  }

  void addOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);

    OverlayEntry entry = OverlayEntry(
        builder: (context) {
          return MarkerHelper(
            markerWidgets: markerWidgets,
            callback: callback,
          );
        },
        maintainState: true);

    overlayState.insert(entry);
  }
}

class MarkerHelper extends StatefulWidget {
  final Widget markerWidgets;
  final Function(List<Uint8List>) callback;

  const MarkerHelper({Key? key, required this.markerWidgets, required this.callback}) : super(key: key);

  @override
  MarkerHelperState createState() => MarkerHelperState();
}

class MarkerHelperState extends State<MarkerHelper> with AfterLayoutMixin {
  List<GlobalKey> globalKeys = [];
  late GlobalKey markerKey;

  @override
  void initState() {
    super.initState();
    markerKey = GlobalKey();
    globalKeys.add(markerKey);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _getBitmaps(context).then((list) {
      widget.callback(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(MediaQuery.of(context).size.width, 0),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(children: [
          RepaintBoundary(
            key: markerKey,
            child: widget.markerWidgets,
          )
        ]),
        /*child: Stack(
          children: widget.markerWidgets.map((i) {
            final markerKey = GlobalKey();
            globalKeys.add(markerKey);
            return RepaintBoundary(
              key: markerKey,
              child: i,
            );
          }).toList(),
        ),*/
      ),
    );
  }

  Future<List<Uint8List>> _getBitmaps(BuildContext context) async {
    var futures = globalKeys.map((key) => _getUint8List(key));
    return Future.wait(futures);
  }

  Future<Uint8List> _getUint8List(GlobalKey markerKey) async {
    RenderRepaintBoundary boundary = markerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}

/// AfterLayoutMixin
mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}

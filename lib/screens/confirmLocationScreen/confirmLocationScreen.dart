import 'package:egrocer/helper/utils/generalImports.dart';

class ConfirmLocation extends StatefulWidget {
  final GeoAddress address;
  final String from;

  const ConfirmLocation({Key? key, required this.address, required this.from}) : super(key: key);

  @override
  State<ConfirmLocation> createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  late GoogleMapController controller;
  late CameraPosition kGooglePlex;
  late LatLng kMapCenter;

  List<Marker> customMarkers = [];

  @override
  void initState() {
    kMapCenter = LatLng(double.parse(widget.address.lattitud!), double.parse(widget.address.longitude!));
    setMarkerIcon();
    kGooglePlex = CameraPosition(
      target: kMapCenter,
      zoom: 14.4746,
    );
    super.initState();
  }

  updateMap(double latitude, double longitude) {
    kMapCenter = LatLng(latitude, longitude);
    setMarkerIcon();
    kGooglePlex = CameraPosition(
      target: kMapCenter,
      zoom: 14.4746,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
  }

  setMarkerIcon() async {
    MarkerGenerator(const MapDeliveredMarker(), (bitmaps) {
      setState(() {
        bitmaps.asMap().forEach((i, bmp) {
          customMarkers.add(Marker(
            markerId: MarkerId("$i"),
            position: kMapCenter,
            icon: BitmapDescriptor.fromBytes(bmp),
          ));
        });
      });
    }).generate(context);

    Constant.cityAddressMap = await GeneralMethods.getCityNameAndAddress(kMapCenter, context);

    if (widget.from == "location") {
      Map<String, dynamic> params = {};
      // params[ApiAndParams.cityName] = Constant.cityAddressMap["city"];

      params[ApiAndParams.longitude] = kMapCenter.longitude.toString();
      params[ApiAndParams.latitude] = kMapCenter.latitude.toString();

      await context.read<CityByLatLongProvider>().getCityByLatLongApiProvider(context: context, params: params);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(
            context: context,
            title: Text(
              getTranslatedValue(
                context,
                "lblConfirmLocation",
              ),
              style: TextStyle(color: ColorsRes.mainTextColor),
            )),
        body: WillPopScope(
          onWillPop: () async {
            return Future.delayed(const Duration(milliseconds: 500)).then((value) => true);
          },
          child: Column(children: [
            Expanded(
              child: mapWidget(),
            ),
            confirmBtnWidget(),
          ]),
        ));
  }

  mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: kGooglePlex,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      onTap: (argument) async {
        updateMap(argument.latitude, argument.longitude);
      },
      onMapCreated: _onMapCreated,
      markers: customMarkers.toSet(),

      // markers: markers,
    );
  }

  Future<void> _onMapCreated(GoogleMapController controllerParam) async {
    controller = controllerParam;
    if (Constant.session.getBoolData(SessionManager.isDarkTheme)) {
      controllerParam.setMapStyle(await rootBundle.loadString('assets/mapTheme/nightMode.json'));
    }
  }

  confirmBtnWidget() {
    return Card(
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constant.size10, vertical: Constant.size10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslatedValue(
                      context,
                      "lblSelectYourLocation",
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                      onPressed: () {
                        GeneralMethods.determinePosition().then((value) {
                          updateMap(value.latitude, value.longitude);
                        });
                      },
                      icon: Icon(
                        Icons.my_location_rounded,
                        color: ColorsRes.appColor,
                      ))
                ],
              ),
            ),
            const Divider(
              indent: 8,
              endIndent: 8,
            ),
            ListTile(
              leading: Padding(padding: const EdgeInsets.all(8), child: Widgets.defaultImg(image: "address_icon", iconColor: ColorsRes.appColor)),
              title: (widget.from == "location" && !context.read<CityByLatLongProvider>().isDeliverable)
                  ? Text(
                      getTranslatedValue(
                        context,
                        "lblDoesNotDeliveryLongMessage",
                      ),
                      style: Theme.of(context).textTheme.bodySmall!.apply(color: ColorsRes.appColorRed))
                  : const SizedBox.shrink(),
              subtitle: Text(Constant.cityAddressMap["address"] ?? ""),
              trailing: GestureDetector(
                onTap: (() async {
                  Navigator.of(context).pop();
                  await context.read<CartListProvider>().getAllCartItems(context: context);
                }),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Constant.size8, vertical: Constant.size5),
                  decoration: DesignConfig.boxDecoration(ColorsRes.appColorLightHalfTransparent, 5, isboarder: true, bordercolor: ColorsRes.appColor),
                  child: Text(
                    getTranslatedValue(
                      context,
                      "lblChange",
                    ),
                    style: Theme.of(context).textTheme.bodySmall!.apply(color: ColorsRes.appColor),
                  ),
                ),
              ),
            ),
            if ((widget.from == "location" && context.read<CityByLatLongProvider>().isDeliverable) || widget.from == "address")
              ConfirmButtonWidget(voidCallback: () {
                if (widget.from == "location" && context.read<CityByLatLongProvider>().isDeliverable) {
                  context.read<CartListProvider>().getAllCartItems(context: context);
                  Constant.session.setData(SessionManager.keyAddress, Constant.cityAddressMap["address"], true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    mainHomeScreen,
                    (Route<dynamic> route) => false,
                  );
                } else if (widget.from == "address") {
                  Future.delayed(const Duration(milliseconds: 500)).then((value) {
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                  });
                }
              })
          ],
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/common/utils.dart';
import 'package:new_ank_customer/pages/add_stop1.dart';
import 'package:new_ank_customer/pages/add_stop2.dart';
import 'package:new_ank_customer/pages/add_stop3.dart';
import 'package:new_ank_customer/pages/bookPage/book_vehicle.dart';
import 'package:new_ank_customer/pages/common_provider.dart';
import 'package:provider/provider.dart';

class AddStop3PinMapLocation extends StatefulWidget {
  AddStop3PinMapLocation(
      {Key? key,
      required this.fromAddress,
      required this.toAddress,
      required this.stop1Address,
      this.stop2Address,
      this.stop3Address,
      required this.fromLat,
      required this.fromLong,
      required this.toLatitude,
      required this.toLongitude,
      required this.stop1Lat,
      required this.stop1Long,
      this.stop2Lat,
      this.stop2Long,
      this.stop3Lat,
      this.stop3Long,
      required this.toState,
      required this.pickUpContactName,
      required this.pickUpContactNumber})
      : super(key: key);
  final String fromAddress,
      toAddress,
      toState,
      pickUpContactName,
      stop1Address,
      pickUpContactNumber;
  String? stop2Address, stop3Address;
  final double fromLat, fromLong, toLatitude, toLongitude, stop1Lat, stop1Long;

  double? stop2Lat, stop2Long, stop3Lat, stop3Long;
  @override
  State<AddStop3PinMapLocation> createState() => _AddStop3PinMapLocationState();
}

class _AddStop3PinMapLocationState extends State<AddStop3PinMapLocation> {
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  late BitmapDescriptor myLocation;
  late BitmapDescriptor endLocation;
  late BitmapDescriptor stopLocation;
  final Set<Marker> _markers = <Marker>{};

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};

  List<LatLng> latlng = [];
  addLocation() {
    latlng.add(LatLng(widget.fromLat, widget.fromLong));
    latlng.add(LatLng(widget.toLatitude, widget.toLongitude));
    if (widget.stop1Lat != null)
      latlng.add(LatLng(widget.stop1Lat, widget.stop1Long));
    if (widget.stop2Lat != null)
      latlng.add(LatLng(widget.stop2Lat!, widget.stop2Long!));
    if (widget.stop3Lat != null)
      latlng.add(LatLng(widget.stop3Lat!, widget.stop3Long!));
    print("Latlong Length" + latlng.length.toString());
  }

  List<String> addAddressList = [];

  addingAddressList() {
    addAddressList.add(widget.fromAddress);
    addAddressList.add(widget.toAddress);
    if (widget.stop1Address != null && widget.stop1Address.isNotEmpty)
      addAddressList.add(widget.stop1Address);
    if (widget.stop2Address != null && widget.stop2Address!.isNotEmpty)
      addAddressList.add(widget.stop2Address!);
    if (widget.stop3Address != null && widget.stop3Address!.isNotEmpty)
      addAddressList.add(widget.stop3Address!);

    print("Address Data ---------" + addAddressList.length.toString());
  }

  _addPolyLine() {
    setState(() {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline(
          polylineId: id,
          visible: true,
          width: 2,
          color: Colors.blue,
          points: latlng,
          startCap: Cap.squareCap,
          jointType: JointType.round);

      polylines[id] = polyline;
    });
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    getJsonFile("assets/mapStyle.json")
        .then((value) => _cntlr.setMapStyle(value));
    setState(() {
      getNearDriver();
    });

    homePageProvider.googleMapController = _cntlr;

    homePageProvider.getDistance(widget.toLatitude, widget.toLongitude);
  }

  getNearDriver() {
    print("2 ----------- " + latlng.length.toString());

    if (latlng.length == 2) {
      var myLocationPostition =
          LatLng(latlng.first.latitude, latlng.first.longitude);

      print(
          "-------------------${LatLng(latlng.first.latitude, latlng.first.longitude)}");
      _markers.add(Marker(
          markerId: const MarkerId("MyPosition"),
          position: myLocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: myLocation));

      print(
          "---End LatLong----------------${LatLng(latlng.last.latitude, latlng.last.longitude)}");
      var endLocationPostition =
          LatLng(latlng.last.latitude, latlng.last.longitude);
      _markers.add(Marker(
          markerId: const MarkerId("EndPosition"),
          position: endLocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: endLocation));
      getMarkerIcon();
    } else if (latlng.length == 3) {
      print("3 ----------- " + latlng.length.toString());

      var myLocationPostition =
          LatLng(latlng.first.latitude, latlng.first.longitude);

      print(
          "-------------------${LatLng(latlng.first.latitude, latlng.first.longitude)}");
      _markers.add(Marker(
          markerId: const MarkerId("MyPosition"),
          position: myLocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: myLocation));

      print(
          "---End LatLong----------------${LatLng(latlng.last.latitude, latlng.last.longitude)}");
      var endLocationPostition =
          LatLng(latlng.last.latitude, latlng.last.longitude);
      _markers.add(Marker(
          markerId: const MarkerId("EndPosition"),
          position: endLocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: endLocation));

      if (latlng[1] != null)
        _markers.add(Marker(
            markerId: const MarkerId("stopPosition"),
            position: LatLng(latlng[1].latitude, latlng[1].longitude),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: const Offset(0.5, 0.5),
            icon: stopLocation));
    } else if (latlng.length == 4) {
      print("4 ----------- " + latlng.length.toString());

      var myLocationPostition =
          LatLng(latlng.first.latitude, latlng.first.longitude);

      print(
          "-------------------${LatLng(latlng.first.latitude, latlng.first.longitude)}");
      _markers.add(Marker(
          markerId: const MarkerId("MyPosition"),
          position: myLocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: myLocation));

      print(
          "---End LatLong----------------${LatLng(latlng.last.latitude, latlng.last.longitude)}");
      var endLocationPostition =
          LatLng(latlng.last.latitude, latlng.last.longitude);
      _markers.add(Marker(
          markerId: const MarkerId("EndPosition"),
          position: endLocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: endLocation));

      if (latlng[1] != null)
        _markers.add(Marker(
            markerId: const MarkerId("stopPosition"),
            position: LatLng(latlng[1].latitude, latlng[1].longitude),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: const Offset(0.5, 0.5),
            icon: stopLocation));

      if (latlng[2] != null)
        _markers.add(Marker(
            markerId: const MarkerId("stop2Position"),
            position: LatLng(latlng[2].latitude, latlng[2].longitude),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: const Offset(0.5, 0.5),
            icon: stopLocation));
    } else if (latlng.length == 5) {
      print("5 ----------- " + latlng.length.toString());

      var myLocationPostition =
          LatLng(latlng.first.latitude, latlng.first.longitude);

      print(
          "-------------------${LatLng(latlng.first.latitude, latlng.first.longitude)}");
      _markers.add(Marker(
          markerId: const MarkerId("MyPosition"),
          position: myLocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: myLocation));

      print(
          "---End LatLong----------------${LatLng(latlng.last.latitude, latlng.last.longitude)}");
      var endLocationPostition =
          LatLng(latlng.last.latitude, latlng.last.longitude);
      _markers.add(Marker(
          markerId: const MarkerId("EndPosition"),
          position: endLocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: endLocation));

      if (latlng[1] != null)
        _markers.add(Marker(
            markerId: const MarkerId("stopPosition"),
            position: LatLng(latlng[1].latitude, latlng[1].longitude),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: const Offset(0.5, 0.5),
            icon: stopLocation));

      if (latlng[2] != null)
        _markers.add(Marker(
            markerId: const MarkerId("stop2Position"),
            position: LatLng(latlng[2].latitude, latlng[2].longitude),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: const Offset(0.5, 0.5),
            icon: stopLocation));

      if (latlng[3] != null)
        _markers.add(Marker(
            markerId: const MarkerId("stop3Position"),
            position: LatLng(latlng[3].latitude, latlng[3].longitude),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: const Offset(0.5, 0.5),
            icon: stopLocation));
    }

    setState(() {});
  }

  getMarkerIcon() async {
    if (latlng.length == 2) {
      myLocation = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5),
          'assets/images/srtLoc.png');

      endLocation = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5),
          'assets/images/endLoc.png');
    } else if (latlng.length >= 3) {
      myLocation = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5),
          'assets/images/srtLoc.png');

      endLocation = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5),
          'assets/images/endLoc.png');
      if (latlng.length != 2)
        stopLocation = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/stopLoc.png');
    }
  }

  @override
  void initState() {
    addLocation();

    addingAddressList();
    _addPolyLine();
    getMarkerIcon();

    print("Locatio Data ---------" + latlng.length.toString());

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    getMarkerIcon();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildMap()),
      bottomSheet: Container(
          height: deviceHeight(context) * 0.65,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Review Location",
                    style: CommonStyles.blue18900(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ReorderableListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    primary: true,
                    itemCount: latlng.length,
                    itemBuilder: (context, index) {
                      final productName = latlng[index];
                      return Container(
                        height: 100,
                        key: ValueKey(productName),
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: ListTile(
                                    contentPadding: const EdgeInsets.all(8),
                                    leading: Container(
                                      //  padding: EdgeInsets.all(8),
                                      /* decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.green, width: 2)),*/
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            addAddressList[index] ==
                                                    addAddressList[0]
                                                ? "PickUp"
                                                : "Drop ${index}",
                                            style: addAddressList[index] ==
                                                    addAddressList[0]
                                                ? CommonStyles.green9()
                                                : CommonStyles.red9(),
                                          ),
                                          /*Icon(
                                            Icons.my_location_outlined,
                                            size: 25,
                                          )*/
                                        ],
                                      ),
                                    ),
                                    /* trailing: TextButton(
                                      onPressed: () {},
                                      child: Image.asset(
                                        "assets/images/dragDrop1.png",
                                        height: 70,
                                        width: 70,
                                      ),
                                    ),*/
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          CupertinoIcons.arrow_up_arrow_down,
                                        )),
                                    title: TextButton(
                                      onPressed: () {},
                                      child: Text(addAddressList[index],
                                          style: CommonStyles.black12reg(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis),
                                    )),
                              ),
                              Expanded(
                                  child: Visibility(
                                visible: latlng.length != 2,
                                child: IconButton(
                                  onPressed: () async {
                                    print("latLong Delete Length ----------" +
                                        latlng.length.toString());
                                    print(
                                        "addAddress Delete Length ----------" +
                                            addAddressList.length.toString());

                                    await latlng.removeAt(index);

                                    await addAddressList.removeAt(index);

                                    setState(() {
                                      getNearDriver();
                                      getMarkerIcon();
                                    });

                                    setState(() {
                                      latlng;
                                      print("After remove --------" +
                                          latlng.length.toString());
                                      addAddressList;
                                      print("After remove --------" +
                                          addAddressList.length.toString());
                                      getNearDriver();
                                      getMarkerIcon();
                                    });
                                  },
                                  icon: Icon(Icons.cancel_outlined),
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    },
                    /* onReorderStart: (context) {
                      setState(() {
                        latlng;
                        addAddressList;
                      });
                    },*/
                    onReorder: orderRearrange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (latlng.length != 5)
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.blue[900],
                            height: 40,
                            onPressed: () {
                              print("latLong Add Stop Length -----------" +
                                  latlng.length.toString());
                              if (latlng.length == 2) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddStop1(
                                          pickupLoction: addAddressList.first,
                                          dropLocation: addAddressList.last,
                                          toLong: latlng.last.longitude,
                                          toLat: latlng.last.latitude,
                                        )));
                              } else if (latlng.length == 3) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddStop2(
                                          fromLat: latlng.first.latitude,
                                          fromLong: latlng.first.longitude,
                                          pickupLoction: addAddressList.first,
                                          dropLocation: addAddressList.last,
                                          stop1Location: addAddressList[1],
                                          toLong: latlng.last.longitude,
                                          toLat: latlng.last.latitude,
                                          stop1Lat: latlng[1].latitude,
                                          stop1Long: latlng[1].longitude,
                                        )));
                              } else if (latlng.length == 4) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddStop3(
                                          fromLat: latlng.first.latitude,
                                          fromLong: latlng.first.longitude,
                                          dropLocation: addAddressList.last,
                                          pickupLoction: addAddressList.first,
                                          stop1Location: addAddressList[1],
                                          stop2Location: addAddressList[2],
                                          toLong: latlng.last.longitude,
                                          toLat: latlng.last.latitude,
                                          stop1Lat: latlng[1].latitude,
                                          stop1Long: latlng[1].longitude,
                                          stop2Lat: latlng[2].latitude,
                                          stop2Long: latlng[2].longitude,
                                        )));
                              }
                            },
                            child: Center(
                              child: Text(
                                "Add Stop",
                                style: CommonStyles.whiteText12BoldW500(),
                              ),
                            )),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Colors.blue[900],
                          height: 40,
                          onPressed: () {
                            setState(() {
                              if (latlng.length == 2) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => BookVehiclePage(
                                              fromLat: latlng.first.latitude,
                                              fromLong: latlng.first.longitude,
                                              fromAddress: addAddressList.first,
                                              toLatitude: latlng.last.latitude,
                                              toLongitude:
                                                  latlng.last.longitude,
                                              toAddress: addAddressList.last,
                                              toState: widget.toState,
                                              pickupContactName:
                                                  widget.pickUpContactName,
                                              pickupContactPhone:
                                                  widget.pickUpContactNumber,
                                            )));
                              } else if (latlng.length == 3) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => BookVehiclePage(
                                              fromLat: latlng.first.latitude,
                                              fromLong: latlng.first.longitude,
                                              fromAddress: addAddressList.first,
                                              toLatitude: latlng.last.latitude,
                                              toLongitude:
                                                  latlng.last.longitude,
                                              toAddress: addAddressList.last,
                                              toState: widget.toState,
                                              pickupContactName:
                                                  widget.pickUpContactName,
                                              pickupContactPhone:
                                                  widget.pickUpContactNumber,
                                              stop1: addAddressList[1],
                                              stop1lat: latlng[1].latitude,
                                              stop1long: latlng[1].longitude,
                                            )));
                              } else if (latlng.length == 4) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => BookVehiclePage(
                                              fromLat: latlng.first.latitude,
                                              fromLong: latlng.first.longitude,
                                              fromAddress: addAddressList.first,
                                              toLatitude: latlng.last.latitude,
                                              toLongitude:
                                                  latlng.last.longitude,
                                              toAddress: addAddressList.last,
                                              toState: widget.toState,
                                              pickupContactName:
                                                  widget.pickUpContactName,
                                              pickupContactPhone:
                                                  widget.pickUpContactNumber,
                                              stop1: addAddressList[1],
                                              stop1lat: latlng[1].latitude,
                                              stop1long: latlng[1].longitude,
                                              stop2: addAddressList[2],
                                              stop2Lat: latlng[2].latitude,
                                              stop2Long: latlng[2].longitude,
                                            )));
                              } else if (latlng.length == 5) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => BookVehiclePage(
                                              fromLat: latlng.first.latitude,
                                              fromLong: latlng.first.longitude,
                                              fromAddress: addAddressList.first,
                                              toLatitude: latlng.last.latitude,
                                              toLongitude:
                                                  latlng.last.longitude,
                                              toAddress: addAddressList.last,
                                              toState: widget.toState,
                                              pickupContactName:
                                                  widget.pickUpContactName,
                                              pickupContactPhone:
                                                  widget.pickUpContactNumber,
                                              stop1: addAddressList[1],
                                              stop1lat: latlng[1].latitude,
                                              stop1long: latlng[1].longitude,
                                              stop2: addAddressList[2],
                                              stop2Lat: latlng[2].latitude,
                                              stop2Long: latlng[2].longitude,
                                              stop3: addAddressList[3],
                                              stop3Lat: latlng[3].latitude,
                                              stop3Long: latlng[3].longitude,
                                            )));
                              }
                            });
                          },
                          child: Center(
                            child: Text(
                              "Confirm Location",
                              style: CommonStyles.whiteText12BoldW500(),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  void orderRearrange(oldIndex, newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex = newIndex - 1;
      }
      final latLngOrder = latlng.removeAt(oldIndex);
      latlng.insert(newIndex, latLngOrder);
      final element = addAddressList.removeAt(oldIndex);
      addAddressList.insert(newIndex, element);
      getNearDriver();
      getMarkerIcon();
      _addPolyLine();
    });
  }

  buildMap() {
    return SizedBox(
      height: deviceHeight(context) * 0.5,
      child: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.normal,

        polylines: Set<Polyline>.of(polylines.values),
        //polylines: Set<Polyline>.of(homePageProvider.polylines.values),
        onMapCreated: _onMapCreated,
        markers: _markers,
        // markers: Set<Marker>.of(homePageProvider.markerSet),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
      ),
    );
  }
}

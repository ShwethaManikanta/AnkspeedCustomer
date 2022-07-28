import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:new_ank_customer/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/common/utils.dart';
import 'package:new_ank_customer/pages/search_page.dart';

class MultiStopScreen extends StatefulWidget {
  final String pickUpLocation;
  final String dropLocation;
  double toLat;
  double toLong;
  final String toState;
  final String pickUpContactName;
  final String pickUpContactNumber;
  MultiStopScreen(
      {Key? key,
      required this.pickUpLocation,
      required this.dropLocation,
      required this.toLat,
      required this.toLong,
      required this.pickUpContactName,
      required this.pickUpContactNumber,
      required this.toState})
      : super(key: key);

  @override
  State<MultiStopScreen> createState() => _MultiStopScreenState();
}

class _MultiStopScreenState extends State<MultiStopScreen> {
  List<Widget> _children = [];
  TextEditingController _bookingfromDate = TextEditingController();
  TextEditingController _bookingfromTime = TextEditingController();

  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  List<LatLng> latlng = [];

  String? fromLat,
      fromLng,
      toLat1,
      toLng1,
      toLat2,
      toLng2,
      toLat3,
      toLng3,
      toLat4,
      toLng4;

  GoogleMapController? mapController;
  int index = 0;
  int index1 = 0;
  double? t2;
  bool isCalculateDistanceEnable = true;
  bool isConfirmBookingEnable = true;
  bool isSelected = false;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBI5cpNYrsaytpcOHr85QWb9wRv0ZnOKew";
  dynamic? clickMe, clickMeId, clickMeAmount;

  int? radioValue;

  String? vehicleAmount;
  bool pressGeoON = false;
  bool cmbscritta = false;
  double? totalKm;
  bool changeAddress = false;
  bool confirmLocation = false;
  BitmapDescriptor? myIcon;
  BitmapDescriptor? myDestIcon;
  BitmapDescriptor? addStopIcon;

  dynamic pickupLatLng, dropLatLng, addStop1LatLng, addStop2LatLng;

  @override
  void initState() {
    super.initState();

    //  initializeDateFormatting();

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(2, 2)), 'assets/locImg.png')
        .then((onValue) {
      myIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(2, 2)), 'assets/loc_pin.png')
        .then((onValue) {
      myDestIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(2, 2)), 'assets/loc_pin.png')
        .then((onValue) {
      addStopIcon = onValue;
    });

    _addPolyLine();
    // _destMarkertrail(widget.toLat, widget.toLong);
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

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: myIcon!,
      position: position,
    );
    markers[markerId] = marker;
  }

  _addDestinationMarker(
      LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: myDestIcon!,
      position: position,
    );
    markers[markerId] = marker;
  }

  _addStopMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: addStopIcon!,
      position: position,
    );
    markers[markerId] = marker;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    if (toLat1 != null) {
      print("tolat1");
    }

    toLat1 != null
        ? print("hey1")
        : toLat2 != null
            ? print("hey2")
            : toLat3 != null
                ? print("hey3")
                : print("none");

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    SharedPreference.latitude!, SharedPreference.longitude!),
                zoom: 12,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: Set<Marker>.of(markers.values),
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              // circles: circles,
              onCameraIdle: () {
                print("mytaps");
              },
              onMapCreated: (controller) {
                setState(() {
                  _addMarker(
                    LatLng(SharedPreference.latitude!,
                        SharedPreference.longitude!),
                    "origin",
                    BitmapDescriptor.defaultMarker,
                  );
                  latlng.add(LatLng(
                      SharedPreference.latitude!, SharedPreference.longitude!));
                });
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.fiber_manual_record,
                                size: 12,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: Text(widget.pickUpLocation,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: CommonStyles.green15())),
                            ],
                          ),
                        )),
                    dropLocationAutoCompleteTextField(context),
                    Column(
                      children: _children,
                    )
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_history,
                                size: 20,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.79,
                                  child: Text(widget.pickUpLocation,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: CommonStyles.green15())),
                            ],
                          ),
                        )),
                    Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_history,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.79,
                                  child: Text(widget.dropLocation,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: CommonStyles.red15())),
                            ],
                          ),
                        )),
                    dropLocationAutoCompleteTextField(context),
                    Column(
                      children: _children,
                    )
                  ],
                )),
            toLat1 != null && toLng1 != null
                ? Positioned(
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: SizedBox(
                      height: 50,
                      child: TextButton(
                        child: const Text(
                          "Confirm your route",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFFFFFFFF),
                            fontSize: 19,
                            // height: 19/19,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                builder: (context) {
                                  print(controller.text);
                                  return VerifyAddressBottomSheet(
                                      toLatitude: widget.toLat,
                                      toLongitude: widget.toLong,
                                      toState: widget.toState,
                                      pickUpContactNumber:
                                          widget.pickUpContactNumber,
                                      pickUpContactName:
                                          widget.pickUpContactName,
                                      toAddress: widget.dropLocation,
                                   /*   stop1: controller2.text,
                                      stop2: controller3.text,
                                      stop3: controller4.text*/);
                                });

                            /*      confirmLocation = true;
                            ownBottomSheet(context, StatefulBuilder(
                                builder: (BuildContext context, setState) {
                              return Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Stack(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.fiber_manual_record,
                                                      size: 12,
                                                      color: Colors.green,
                                                    ),
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            widget
                                                                .pickUpLocation,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: CommonStyles
                                                                .green12(),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.fiber_manual_record,
                                                      size: 12,
                                                      color: Colors.red,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          addStop2LatLng != null
                                                              ? addStop2LatLng
                                                              : addStop1LatLng !=
                                                                      null
                                                                  ? addStop1LatLng
                                                                  : dropLatLng,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: CommonStyles
                                                              .blue13(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 20,
                                          top: 15,
                                          child: InkWell(
                                              child: cmbscritta
                                                  ? Card(
                                                      elevation: 5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .access_alarm,
                                                              size: 15,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Later",
                                                              style:
                                                                  CommonStyles
                                                                      .blue13(),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Card(
                                                      elevation: 5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .access_alarm,
                                                              size: 15,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "Now",
                                                              style:
                                                                  CommonStyles
                                                                      .blue13(),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                              //    style: TextStyle(fontSize: 14)
                                              onTap: () {
                                                setState(() {
                                                  pressGeoON = !pressGeoON;
                                                  cmbscritta = !cmbscritta;
                                                });
                                              }),
                                        ),
                                      ],
                                    ),

                                    */ /*   cmbscritta
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      FormBuilderDateTimePicker(
                                                    name: 'from_booking_date',
                                                    controller:
                                                        _bookingfromDate,
                                                    // onChanged: _onChanged,
                                                    inputType: InputType.date,
                                                    decoration: InputDecoration(
                                                      // border: OutlineInputBorder(),
                                                      labelText: "Book Date",
                                                      hintText: "Book Date",
                                                    ),

                                                    initialTime: TimeOfDay(
                                                        hour: 8, minute: 0),
                                                    // initialValue: DateTime.now(),
                                                    // enabled: true,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      FormBuilderDateTimePicker(
                                                    autovalidateMode:
                                                        AutovalidateMode.always,
                                                    name: 'from_booking_time',
                                                    controller:
                                                        _bookingfromTime,
                                                    // onChanged: _onChanged,
                                                    inputType: InputType.time,
                                                    decoration: InputDecoration(
                                                      // border: OutlineInputBorder(),
                                                      labelText: "Book Time",
                                                      hintText: "Book Time",
                                                    ),
                                                    initialTime: TimeOfDay(
                                                        hour: 8, minute: 0),
                                                    // initialValue: DateTime.now(),
                                                    // enabled: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),*/ /*

                                    */ /*  fromLat != null && fromLng != null ||
                                            toLat1 != null && toLng1 != null
                                        ? FutureBuilder<CommonPickerModel?>(
                                            future: ambulanceProvider
                                                .ambulancelistApi(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SpaceBetween.spaceh10,
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          "Recommend for you"),
                                                    ),
                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            ScrollPhysics(),
                                                        itemCount: snapshot
                                                            .data!
                                                            .ambulance_list!
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                clickMe = index;
                                                                clickMeId = snapshot
                                                                    .data!
                                                                    .ambulance_list![
                                                                        clickMe!]
                                                                    .id!;
                                                                clickMeAmount = snapshot
                                                                    .data!
                                                                    .ambulance_list![
                                                                        clickMe!]
                                                                    .amount!;
                                                              });
                                                            },
                                                            child: Card(
                                                              color: index ==
                                                                      clickMe
                                                                  ? Colors.green
                                                                      .shade100
                                                                  : Colors
                                                                      .white,
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      ListTile(
                                                                    leading: Image
                                                                        .asset(
                                                                      "assets/images/ambulancenew.png",
                                                                      height:
                                                                          40,
                                                                    ),
                                                                    title: Text(
                                                                      snapshot
                                                                          .data!
                                                                          .ambulance_list![
                                                                              index]
                                                                          .vehicle_name!,
                                                                      style: TextOwnStyle
                                                                          .TextStylesT13,
                                                                    ),
                                                                    subtitle:
                                                                        Text(
                                                                      "Get ambulance at your doorstep",
                                                                      style: TextOwnStyle
                                                                          .TextStylesWB12,
                                                                    ),
                                                                    trailing:
                                                                        Text(
                                                                      "Rs. " +
                                                                          snapshot
                                                                              .data!
                                                                              .ambulance_list![index]
                                                                              .amount!,
                                                                      style: TextOwnStyle
                                                                          .TextStylesB15,
                                                                    ),
                                                                  )),
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                );
                                              }
                                              return Container();
                                            })
                                        : Container(),*/ /*
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {
                                            String toaddress =
                                                '${controller2.text},${controller3.text}${controller4.text}';

                                            String tolatitude =
                                                '$toLat1,$toLat2,$toLat3';
                                            String tolongitude =
                                                '$toLng1,$toLng2,$toLng3';
                                            var param = {
                                              "type": "1",
                                              "user_id": ApiServices.userId,
                                              "vehicle_id":
                                                  clickMeId.toString(),
                                              "from_address":
                                                  widget.pickUpLocation,
                                              "from_lat":
                                                  "widget.pickUplat.toString()",
                                              "from_long":
                                                  "widget.pickUplng.toString()",
                                              "to_address": toaddress,
                                              "to_lat": tolatitude,
                                              "to_long": tolongitude,
                                              "vehicle_price":
                                                  clickMeAmount.toString(),
                                              "from_booking_date":
                                                  _bookingfromDate.text,
                                              "from_booking_time":
                                                  _bookingfromTime.text,
                                              "book_type": "1"
                                            };
                                            print("ambulanceparam +${param}");

                                            */ /*  ambulanceProvider
                                                .ambulanceaddTripApi(param)
                                                .then((value) {
                                              print(value!.cart_id);
                                              if (value.status == "1") {
                                                print(value.cart_id);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReviewBookingScreen(
                                                              cartId:
                                                                  value.cart_id,
                                                            )));
                                              }
                                            });*/ /*
                                          },
                                          child: ownContainer(
                                              Text(
                                                "Review",
                                                style: CommonStyles.black13(),
                                              ),
                                              borderEnable: false,
                                              color: Colors.deepOrange)),
                                    ),
                                    // isCalculateDistanceEnable
                                    //     ? Padding(
                                    //         padding: const EdgeInsets.all(8.0),
                                    //         child: InkWell(
                                    //             onTap: () {
                                    //               ambulanceProvider.getDistanceFromGPSPointsInRoute([
                                    //                 LatLng(double.parse(fromLat!), double.parse(fromLng!)),
                                    //                 LatLng(double.parse(toLat1!), double.parse(toLng1!)),
                                    //                  LatLng(double.parse(toLat2 != '' ? toLat2! : ''),
                                    //                     double.parse(toLng2 != '' ? toLng2! : '')) ,
                                    //                 LatLng(double.parse(toLat3!), double.parse(toLng3!))
                                    //                 ,
                                    //               ]);
                                    //             },
                                    //             child: ownContainer(
                                    //                 Text(
                                    //                   "Calculate distance",
                                    //                   style: TextOwnStyle.TextStylesW15,
                                    //                 ),
                                    //                 borderEnable: false,
                                    //                 color: Colors.green)),
                                    //       )
                                    //     : Padding(
                                    //         padding: const EdgeInsets.all(8.0),
                                    //         child: InkWell(
                                    //             onTap: () {
                                    //               String toaddress = '${controller2.text},${controller3.text}${controller4.text}';
                                    //
                                    //               String tolatitude = '$toLat1,$toLat2,$toLat3';
                                    //               String tolongitude = '$toLng1,$toLng2,$toLng3';
                                    //               var param = {
                                    //                 "type": "1",
                                    //                 "user_id": SharedPreference.userIds,
                                    //                 "vehicle_type": clickMeId,
                                    //                 "from_address": controller.text,
                                    //                 "from_lat": fromLat,
                                    //                 "from_long": fromLng,
                                    //                 "to_address": toaddress,
                                    //                 "to_lat": tolatitude,
                                    //                 "to_long": tolongitude,
                                    //                 "total": clickMeAmount,
                                    //                 "from_booking_date": _bookingfromDate.text,
                                    //                 "from_booking_time": _bookingfromTime.text,
                                    //
                                    //               };
                                    //
                                    //               ambulanceProvider.ambulanceaddTripApi(param).then((value) {
                                    //                 if (value!.status == "1") {
                                    //
                                    //                 }
                                    //               });
                                    //             },
                                    //             child: ownContainer(
                                    //                 Text(
                                    //                   "Review Booking",
                                    //                   style: TextOwnStyle.TextStylesW15,
                                    //                 ),
                                    //                 borderEnable: false,
                                    //                 color: Colors.deepOrange)),
                                    //       ),
                                  ],
                                ),
                              );
                            }));*/
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  dropLocationAutoCompleteTextField(BuildContext context) {
    return Card(
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller2,
          googleAPIKey: "AIzaSyBI5cpNYrsaytpcOHr85QWb9wRv0ZnOKew",
          inputDecoration: InputDecoration(
              hintText: "Enter Stop location",
              border: InputBorder.none,
              hintStyle: CommonStyles.black13(),
              prefixIcon: Icon(
                Icons.location_history,
                size: 20,
                color: Colors.amber,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  index = index + 1;
                  if (index <= 2) {
                    if (index == 1) {
                      print("index1 +${index}");
                      setState(() {
                        _children.add(addControl3TextField(context, index));
                      });
                    } else if (index == 2) {
                      setState(() {
                        _children.add(addControl4TextField(context, index));
                      });
                    }
                  } else {}
                },
                child: Icon(
                  Icons.add,
                  size: 13,
                  color: Colors.green,
                ),
              )),
          debounceTime: 800,
          countries: ["in"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) async {
            toLat1 = prediction.lat!;
            toLng1 = prediction.lng!;

            print("toLat2 +${toLat2}");
            //    _destMarkertrail(widget.toLat, widget.toLong);
            //   _destMarkertrail(widget.toLat, widget.toLong);

            _destMarkertrail(toLat1, toLng1);

            // latlng.add(LatLng(double.parse(toLat1!), double.parse(toLng1!)));
          },
          itmClick: (Prediction prediction) {
            controller2.text = prediction.description!;
            dropLatLng = controller2.text;

            controller2.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
            print("controller.selection +${controller2.selection}");
          }
          // default 600 ms ,
          ),
    );
  }

  addControl3TextField(BuildContext context, int index) {
    return Card(
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller3,
          googleAPIKey: "AIzaSyBI5cpNYrsaytpcOHr85QWb9wRv0ZnOKew",
          inputDecoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Add a Stop".toUpperCase(),
              hintStyle: CommonStyles.black13(),
              prefixIcon: Icon(
                Icons.fiber_manual_record,
                size: 13,
                color: Colors.red,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _children.removeAt(0);
                  });
                },
                child: Icon(
                  Icons.clear,
                  size: 15,
                  color: Colors.red,
                ),
              )),
          debounceTime: 800,
          countries: ["in"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) async {
            toLat2 = prediction.lat!;
            toLng2 = prediction.lng!;
            setState(() {
              _destMarkertrail(toLat2, toLng2);
              // _addDestinationMarker(
              //   LatLng(double.parse(toLat2!), double.parse(toLng2!)),
              //   "destination1",
              //   BitmapDescriptor.defaultMarker,
              // );
              // latlng.add(LatLng(double.parse(toLat2!), double.parse(toLng2!)));
            });
          },
          itmClick: (Prediction prediction) {
            controller3.text = prediction.description!;
            addStop1LatLng = controller3.text;

            controller3.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
            print("controller.selection +${controller3.selection}");
          }
          // default 600 ms ,
          ),
    );
  }

  addControl4TextField(BuildContext context, int index) {
    return Card(
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller4,
          googleAPIKey: "AIzaSyBI5cpNYrsaytpcOHr85QWb9wRv0ZnOKew",
          inputDecoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Add a Stop".toUpperCase(),
              hintStyle: CommonStyles.black13(),
              prefixIcon: Icon(
                Icons.fiber_manual_record,
                size: 13,
                color: Colors.red,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  print("remove1 ${index}");
                  setState(() {
                    _children.removeAt(1);
                  });
                },
                child: Icon(
                  Icons.clear,
                  size: 15,
                  color: Colors.red,
                ),
              )),
          debounceTime: 800,
          countries: ["in"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) async {
            toLat3 = prediction.lat!;
            toLng3 = prediction.lng!;
            setState(() {
              _destMarkertrail(toLat3, toLng3);
              // _addDestinationMarker(
              //   LatLng(double.parse(toLat3!), double.parse(toLng3!)),
              //   "destination2",
              //   BitmapDescriptor.defaultMarker,
              // );
            });
          },
          itmClick: (Prediction prediction) {
            controller4.text = prediction.description!;
            addStop2LatLng = controller4.text;

            controller4.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
            print("controller.selection +${controller4.selection}");
          }
          // default 600 ms ,
          ),
    );
  }

  /* void _destMarker() {
    if (toLat1 != null && (toLat2 == null && toLat3 == null)) {
      _addDestinationMarker(
        LatLng(double.parse(toLat1!), double.parse(toLng1!)),
        "Destination",
        BitmapDescriptor.defaultMarker,
      );
    } else if (toLat2 != null) {
      if (toLat1 != null && toLat3 == null) {
        _addDestinationMarker(
          LatLng(double.parse(toLat2!), double.parse(toLng2!)),
          "Destination1",
          BitmapDescriptor.defaultMarker,
        );
      } else {
        _addStopMarker(
          LatLng(double.parse(toLat2!), double.parse(toLng2!)),
          "Stop1",
          BitmapDescriptor.defaultMarker,
        );
      }
    } else if (toLat3 != null) {
      if (toLat1 != null && toLat2 != null) {
        _addDestinationMarker(
          LatLng(double.parse(toLat3!), double.parse(toLng3!)),
          "Destination2",
          BitmapDescriptor.defaultMarker,
        );
      } else {
        _addStopMarker(
          LatLng(double.parse(toLat3!), double.parse(toLng3!)),
          "Stop2",
          BitmapDescriptor.defaultMarker,
        );
      }
    } else {
      print("stophere");
      _addStopMarker(
        LatLng(double.parse(toLat1!), double.parse(toLng1!)),
        "Stop",
        BitmapDescriptor.defaultMarker,
      );
    }
  }*/

  void _destMarkertrail(latitude, longitude) {
    //   print("-------- " + widget.toLat.toString() + widget.toLong.toString());
    /* if (SharedPreference.latitude != null &&
        (widget.toLat != null && widget.toLong != null)) {
      print("destination Drop");
      _addDestinationMarker(
        LatLng(latitude, longitude),
        "Destination",
        BitmapDescriptor.defaultMarker,
      );
      latlng.add(LatLng(latitude, longitude));
    } else*/
    if (widget.toLong != null && (toLat2 == null && toLat3 == null)) {
      print("destination1");
      _addDestinationMarker(
        LatLng(double.parse(latitude!), double.parse(longitude!)),
        "Destination",
        BitmapDescriptor.defaultMarker,
      );
      latlng.add(LatLng(double.parse(latitude), double.parse(longitude)));
    } else if (toLat2 != null && (toLat1 != null && toLat3 == null)) {
      print("destination2");
      _addDestinationMarker(
        LatLng(double.parse(latitude!), double.parse(longitude!)),
        "Destination",
        BitmapDescriptor.defaultMarker,
      );
      _addStopMarker(
        LatLng(double.parse(toLat1!), double.parse(toLng1!)),
        "Stop1",
        BitmapDescriptor.defaultMarker,
      );
      latlng.add(LatLng(double.parse(latitude), double.parse(longitude)));
    } else if (toLat3 != null && (toLat1 != null && toLat2 != null)) {
      print("destination3");
      _addDestinationMarker(
        LatLng(double.parse(latitude!), double.parse(longitude!)),
        "Destination",
        BitmapDescriptor.defaultMarker,
      );
      _addStopMarker(
        LatLng(double.parse(toLat2!), double.parse(toLng2!)),
        "Stop2",
        BitmapDescriptor.defaultMarker,
      );
      latlng.add(LatLng(double.parse(latitude), double.parse(longitude)));
    }
  }
}

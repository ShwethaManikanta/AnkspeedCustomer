import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../Services/apiProvider/vehicle_categories_api_provider.dart';
import '../../Services/location_services.dart/loaction_shared_preference.dart';
import '../../common/common_styles.dart';
import '../../common/utils.dart';
import '../common_provider.dart';

class SuccessfulBookingScreen extends StatefulWidget {
  const SuccessfulBookingScreen(
      {Key? key, required this.driverLatitude, required this.driverLongitude})
      : super(key: key);
  final double driverLatitude, driverLongitude;

  @override
  _SuccessfulBookingScreenState createState() =>
      _SuccessfulBookingScreenState();
}

class _SuccessfulBookingScreenState extends State<SuccessfulBookingScreen> {
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  // GoogleMapController? _controller;
  final Location _location = Location();

  @override
  void initState() {
    if (context.read<HomePageProvider>().markerSet.isNotEmpty) {
      context.read<HomePageProvider>().clearMarkers();
    }
    // initialize();
    super.initState();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    getJsonFile("assets/mapStyle.json")
        .then((value) => _cntlr.setMapStyle(value));

    // _controller = _cntlr;
    // _location.onLocationChanged.listen((l) {
    //   _controller!.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
    //     ),
    //   );
    // });

    homePageProvider.googleMapController = _cntlr;
    // homePageProvider.addMarkers(
    //     markerId: "Destination Marker",
    //     latitude: widget.toLatitude,
    //     longitude: widget.toLongitude);
    homePageProvider.getDistance(widget.driverLatitude, widget.driverLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        body: buildBody(),
        // bottomNavigationBar: buildBNB(),
      ),
    );
  }

  buildBody() {
    return Stack(
      children: [
        buildMap(),
        Align(
          alignment: Alignment.bottomCenter,
          child: DraggableScrollableSheet(
              minChildSize: 0.1,
              initialChildSize: 0.2,
              maxChildSize: 0.3,
              expand: false,
              builder: (context, draggableController) {
                return SingleChildScrollView(
                  controller: draggableController,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  child: buildvehicalType(),
                );
              }),
        )
      ],
    );
  }

  buildMap() {
    final homePageProvider = Provider.of<HomePageProvider>(context);
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _initialcameraposition),
      mapType: MapType.normal,
      polylines: Set<Polyline>.of(homePageProvider.polylines.values),
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(homePageProvider.markerSet),
      myLocationEnabled: true,
      mapToolbarEnabled: true,
    );
  }

  buildvehicalType() {
    return Container(
      width: double.maxFinite,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 3, bottom: 3),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30),
            //       color: Colors.blueGrey[200],
            //     ),
            //     height: 5,
            //     width: 50,
            //   ),
            // ),
            // Container(
            //   color: Colors.amber[100],
            //   child: const Padding(
            //     padding: EdgeInsets.all(5.0),
            //     child: Text(
            //       'You\'r pickup driver is on way please wait!!!',
            //       style: TextStyle(
            //         fontSize: 10,
            //         fontWeight: FontWeight.w600,
            //         letterSpacing: 0.3,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Expanded(
            //   child: Padding(
            //       padding: const EdgeInsets.all(3.0),
            //       child: instantBookVehicle()

            //       // InstantBookVehicleListWidget(
            //       //   toLat: widget.toLatitude,
            //       //   toLong: widget.toLongitude,
            //       // ),
            //       ),
            // ),
            // const VehicleRideDetails(),

            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('You\'r pickup driver is on way please wait!!!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3)),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.white,
              child: const CircularProgressIndicator(),
            ),
            Container(
              height: 3,
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  buildBNB() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.4),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(
              5.0,
              5.0,
            ),
          )
        ],
      ),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                buildPay();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _selectedPaymentMethod == 0
                          ? const Icon(
                              Icons.account_balance_wallet,
                              color: Color.fromARGB(255, 88, 26, 22),
                            )
                          : const Icon(
                              Icons.money_rounded,
                              color: Color.fromARGB(255, 88, 26, 22),
                            ),
                      _selectedPaymentMethod == 0
                          ? const Text('Online Payment',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 88, 26, 22),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3))
                          : const Text('Cash Payment',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 88, 26, 22),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3)),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  _selectedPaymentMethod == 0
                      ? const Text(' Online Payment Applied',
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0))
                      : const Text(' 30% Payment Applied',
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0))
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  final vehicleCategoriesAPIProvider =
                      Provider.of<VehicleCategoriesAPIProvider>(context,
                          listen: false);
                },
                child: checkInitializationVehicleCategory()),
          ],
        ),
      ),
    );
  }

  checkInitializationVehicleCategory() {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);
    if (vehicleCategoriesAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (vehicleCategoriesAPIProvider.error) {
      print("------error ----------------");
      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    } else if (vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel ==
            null ||
        vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.status! ==
            "0") {
      print("------error2 ----------------");

      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    } else {
      return Container(
        alignment: Alignment.center,
        width: 150,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 88, 26, 22),
            borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Book ' +
                vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!
                    .vehicleList![selectedIndex].wheeler!,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0),
          ),
        ),
      );
    }
  }

  int _selectedPaymentMethod = 0;

  buildPay() {
    return showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Dialog(
                insetPadding: EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  // height: 320,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Select Payment',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: Colors.green.shade800,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('ONLINE PAYMENT',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0)),
                              ],
                            ),
                            Radio(
                              value: 0,
                              groupValue: _selectedPaymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentMethod =
                                      int.parse(value.toString());
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 3,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.money_rounded,
                                    color: Colors.green.shade800,
                                  ),
                                  Text('CASH',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0)),
                                ],
                              ),
                              Radio(
                                value: 1,
                                groupValue: _selectedPaymentMethod,
                                onChanged: (value) {
                                  // setState(() {
                                  //   _selectedPaymentMethod =
                                  //       int.parse(value.toString());
                                  // });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 380,
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  int selectedIndex = 0;

  instantBookVehicle() {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);

    if (vehicleCategoriesAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (vehicleCategoriesAPIProvider.error) {
      print("------error ----------------");
      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    } else if (vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel ==
            null ||
        vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.status! ==
            "0") {
      print("------error2 ----------------");

      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    } else {
      final _vehicleCategoryList = vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.vehicleList;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 140,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              primary: false,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _vehicleCategoryList!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    // Utils.showLoaderDialog(context);
                    // final result = await databaseService.futureVehicleList(
                    //     vehicleCategory: _vehicleCategoryList![index].name);

                    // for (var element in result) {
                    //   print("element name  -- - - - - - - -" + element.name);
                    //   homePageProvider.addMarkers(
                    //       markerId: element.documentID,
                    //       latitude: double.parse(element.latitude),
                    //       longitude: double.parse(element.longitude));
                    // }
                    // Navigator.of(context).pop();

                    // homePageProvider.getDistance(
                    //     double.parse(_list![index].lat),
                    //     double.parse(_list![index].lang));
                    setState(() {
                      selectedIndex = index;
                    });
                    // _vehicleCategoryList![index].name;
                  },
                  child: SizedBox(
                    width: 100,
                    // color: Colors.blueGrey[100],
                    child: Column(
                      children: [
                        Text(
                          _vehicleCategoryList[index].wheeler!,
                          style: TextStyle(
                              color: Colors.blueGrey[500],
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      vehicleCategoriesAPIProvider
                                              .vehicleCategoriesResponseModel!
                                              .vehicleBaseurl! +
                                          _vehicleCategoryList[index].image!))),
                        ),
                        Utils.getSizedBox(height: 5),
                        Text(
                          _vehicleCategoryList[index].time!,
                          style: CommonStyles.black12(),
                        ),
                        Utils.getSizedBox(height: 5),
                        Text(
                          "₹" + _vehicleCategoryList[index].totalPrice!,
                          style: CommonStyles.black12(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Utils.getSizedBox(height: 10),
          Utils.dividerThin(),
          Utils.getSizedBox(height: 10),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/boxpacking.jpg'))),
            ),
            Utils.getSizedBox(width: 15),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                      text: "Helper",
                      style: CommonStyles.black1254thin(),
                      children: <TextSpan>[
                        TextSpan(
                            text: _vehicleCategoryList[selectedIndex].labour ==
                                    "0"
                                ? " is not "
                                : " is ",
                            style: CommonStyles.black12(),
                            children: [
                              TextSpan(
                                  text: "available for " +
                                      _vehicleCategoryList[selectedIndex]
                                          .wheeler!
                                          .toString(),
                                  style: CommonStyles.black1254thin())
                            ])
                      ]),
                ),
              ],
            )
          ]),

          // VehicleRideDetails(
          //   vehicleCategories: _vehicleCategories![selectedIndex],
          // ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   primary: false,
          //   itemBuilder: ((context, index) {
          //     return VehicleRideDetails(
          //         price: _vehicleCategoryList![selectedIndex].price[index],
          //         range: _vehicleCategoryList![selectedIndex].range[index],
          //         unit: _vehicleCategoryList![selectedIndex].unit);
          //     // Container(
          //     //   color: Colors.white,
          //     //   child: Padding(
          //     //     padding: const EdgeInsets.all(8.0),
          //     //     child: Row(
          //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     //       children: [
          //     //         Row(
          //     //           children: [
          //     //             const SizedBox(
          //     //               width: 5,
          //     //             ),
          //     //             Text(
          //     //                 '2 Hrs,' +
          //     //                     widget.vehicleCategories.range[index],
          //     //                 style: const TextStyle(
          //     //                     color: Colors.black,
          //     //                     fontSize: 12,
          //     //                     fontWeight: FontWeight.w800,
          //     //                     letterSpacing: 0)),
          //     //           ],
          //     //         ),
          //     //         Row(
          //     //           children: [
          //     //             Text(
          //     //                 '₹ ' +
          //     //                     widget.vehicleCategories.range[index],
          //     //                 style: const TextStyle(
          //     //                     color: Colors.black,
          //     //                     fontSize: 12,
          //     //                     fontWeight: FontWeight.w800,
          //     //                     letterSpacing: 0)),
          //     //             Radio(
          //     //               value: 0,
          //     //               groupValue: selectedRadioValue,
          //     //               onChanged: null,
          //     //             ),
          //     //           ],
          //     //         ),
          //     //       ],
          //     //     ),
          //     //   ),
          //     // );

          //     // return Row(
          //     //   children: [
          //     //     const SizedBox(
          //     //       width: 5,
          //     //     ),
          //     //     Text(
          //     //         widget.vehicleCategories.price[index] +
          //     //             " Hrs" +
          //     //             "," +
          //     //             widget.vehicleCategories.range[index] +
          //     //             widget.vehicleCategories.unit,
          //     //         style: const TextStyle(
          //     //             color: Colors.black,
          //     //             fontSize: 12,
          //     //             fontWeight: FontWeight.w800,
          //     //             letterSpacing: 0)),
          //     //   ],
          //     // );
          //   }),
          //   itemCount: _vehicleCategoryList![selectedIndex].price.length,
          // ),
        ],
      );
      // List<VehicleCategories>? _vehicleCategories;
      // return FutureBuilder<List<VehicleCategories>>(
      //     future: databaseService.futureVehicleCategories(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {

      //       }

      //       _vehicleCategories = snapshot.data;

      //       return
      //     });
    }
  }
}

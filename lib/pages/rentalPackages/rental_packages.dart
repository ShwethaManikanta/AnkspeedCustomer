import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_ank_customer/Models/vehicle_categories.dart';
import 'package:new_ank_customer/common/utils.dart';
import 'package:new_ank_customer/pages/common_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../Models/location_details.dart';
import '../../Services/apiProvider/vehicle_categories_api_provider.dart';
import '../../backend/service/databaseService.dart';

class RentelPackages extends StatefulWidget {
  const RentelPackages(
      {Key? key, required this.toLatitude, required this.toLongitude})
      : super(key: key);
  final double toLatitude, toLongitude;
  @override
  _RentelPackagesState createState() => _RentelPackagesState();
}

class _RentelPackagesState extends State<RentelPackages> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  Location _location = Location();

  @override
  void initState() {
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
    _controller = _cntlr;
    // _location.onLocationChanged.listen((l) {
    //   _controller!.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
    //     ),
    //   );
    // });
    homePageProvider.googleMapController = _cntlr;
    homePageProvider.getDistance(widget.toLatitude, widget.toLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      // buildBody(),
      bottomNavigationBar: buildBNB(),
    );
  }

  buildBody() {
    return Stack(
      children: [
        buildMap(),
        DraggableScrollableSheet(
          initialChildSize: 0.30,
          minChildSize: 0.15,
          builder: (BuildContext context, ScrollController scrollController) {
            // return ListView(
            //   children: [buildvehicalType(),
            // );
            return SingleChildScrollView(
              controller: scrollController,
              primary: false,
              physics: const BouncingScrollPhysics(),
              child: buildvehicalType(),
            );
          },
        )
        // SingleChildScrollView(
        //   primary: false,
        //   physics: const BouncingScrollPhysics(),
        //   child: Container(
        //     margin:
        //         EdgeInsets.only(top: MediaQuery.of(context).size.height - 250),
        //     child: buildvehicalType(),
        //   ),
        // )
      ],
    );
  }

  buildMap() {
    final homePageProvider = Provider.of<HomePageProvider>(context);

    // if (_list == null ||
    //     homePageProvider.state == HomePageProviderState.Uninitialized) {
    //   return const Center(
    //     child: SizedBox(
    //       height: 25,
    //       width: 25,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 1,
    //       ),
    //     ),
    //   );
    // }

    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _initialcameraposition),
      mapType: MapType.normal,
      polylines: Set<Polyline>.of(homePageProvider.polylines.values),
      onMapCreated: _onMapCreated,
      gestureRecognizers: Set()
        ..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()))
        ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
        ..add(Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer())),
      markers: Set<Marker>.of(homePageProvider.markerSet),
      myLocationEnabled: true,
      mapToolbarEnabled: true,
    );
  }

  buildvehicalType() {
    return Container(
      width: double.maxFinite,
      height: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueGrey[200],
                ),
                height: 5,
                width: 50,
              ),
            ),
            Container(
              color: Colors.amber[100],
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Drop Should be within city Boundary',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: VehicleCategoriesListWidget(),
            ),
            // const VehicleRideDetails(),

            // Container(
            //   color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.all(12.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: const [
            //         Text('Pickup Contact',
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w600,
            //                 letterSpacing: 0.3)),
            //         Text('7848026262 Arun G',
            //             style: TextStyle(
            //                 color: Color.fromARGB(255, 88, 26, 22),
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w700,
            //                 letterSpacing: 0)),
            //       ],
            //     ),
            //   ),
            // ),
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
                    children: const [
                      Icon(
                        Icons.money_rounded,
                        color: Color.fromARGB(255, 88, 26, 22),
                      ),
                      Text('Online Payment',
                          style: TextStyle(
                              color: Color.fromARGB(255, 88, 26, 22),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3)),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  const Text(' Online Payment Applied',
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0))
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 150,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 88, 26, 22),
                  borderRadius: BorderRadius.circular(50)),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Book Tata Ace',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                                  const Text('CASH',
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
}

class VehicleCategoriesListWidget extends StatefulWidget {
  const VehicleCategoriesListWidget({Key? key}) : super(key: key);

  @override
  _VehicleCategoriesState createState() => _VehicleCategoriesState();
}

class _VehicleCategoriesState extends State<VehicleCategoriesListWidget> {
  List<LocationDetailsCopy>? _list;

  List<VehicleCategories>? _vehicleCategoryList;

  @override
  void initState() {
    // if (context
    //         .read<VehicleCategoriesAPIProvider>()
    //         .vehicleCategoriesResponseModel ==
    //     null) {
    //   context.read<VehicleCategoriesAPIProvider>().fetchData();
    // }
    initialize();
    super.initState();
  }

  initialize() async {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    await databaseService.futureLocation().then((value) {
      setState(() {
        _list = value!.cast<LocationDetailsCopy>();
      });
    });

    await databaseService.futureVehicleCategories().then((value) {
      setState(() {
        _vehicleCategoryList = value.cast<VehicleCategories>();
      });
    });
  }

  String _selectedCategory = "2 Wheeler";

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);

    if (vehicleCategoriesAPIProvider.ifLoading) {
      return Utils.getCenterLoading();
    } else if (vehicleCategoriesAPIProvider.error) {
      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    } else if (vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel ==
            null ||
        vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.status! ==
            "0") {
      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    } else {
      // List<VehicleCategoryData> vehicleCategoryList =
      //     vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.data!;
      return _vehicleCategoryList == null
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            )
          : Column(
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
                      return SizedBox(
                        height: 140,
                        child: InkWell(
                          onTap: () async {
                            Utils.showLoaderDialog(context);
                            final result =
                                await databaseService.futureVehicleList(
                                    vehicleCategory:
                                        _vehicleCategoryList![index].name);

                            for (var element in result) {
                              print("element name  -- - - - - - - -" +
                                  element.name);
                              homePageProvider.addMarkers(
                                  markerId: element.documentID,
                                  latitude: double.parse(element.latitude),
                                  longitude: double.parse(element.longitude));
                            }
                            Navigator.of(context).pop();

                            homePageProvider.getDistance(
                                double.parse(_list![index].lat),
                                double.parse(_list![index].lang));

                            selectedIndex = index;
                            // _vehicleCategoryList![index].name;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 100,
                                  // color: Colors.blueGrey[100],
                                  child: Column(
                                    children: [
                                      Text(
                                        _vehicleCategoryList![index].name,
                                        style: TextStyle(
                                            color: Colors.blueGrey[500],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.3),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    _vehicleCategoryList![index]
                                                        .imageUrl))),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // VehicleRideDetails(
                //   vehicleCategories: _vehicleCategories![selectedIndex],
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: ((context, index) {
                    return VehicleRideDetails(
                        price:
                            _vehicleCategoryList![selectedIndex].price[index],
                        range:
                            _vehicleCategoryList![selectedIndex].range[index],
                        unit: _vehicleCategoryList![selectedIndex].unit);
                    // Container(
                    //   color: Colors.white,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             const SizedBox(
                    //               width: 5,
                    //             ),
                    //             Text(
                    //                 '2 Hrs,' +
                    //                     widget.vehicleCategories.range[index],
                    //                 style: const TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.w800,
                    //                     letterSpacing: 0)),
                    //           ],
                    //         ),
                    //         Row(
                    //           children: [
                    //             Text(
                    //                 '₹ ' +
                    //                     widget.vehicleCategories.range[index],
                    //                 style: const TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.w800,
                    //                     letterSpacing: 0)),
                    //             Radio(
                    //               value: 0,
                    //               groupValue: selectedRadioValue,
                    //               onChanged: null,
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );

                    // return Row(
                    //   children: [
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     Text(
                    //         widget.vehicleCategories.price[index] +
                    //             " Hrs" +
                    //             "," +
                    //             widget.vehicleCategories.range[index] +
                    //             widget.vehicleCategories.unit,
                    //         style: const TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.w800,
                    //             letterSpacing: 0)),
                    //   ],
                    // );
                  }),
                  itemCount: _vehicleCategoryList![selectedIndex].price.length,
                ),
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

class VehicleRideDetails extends StatefulWidget {
  const VehicleRideDetails(
      {Key? key, required this.range, required this.price, required this.unit})
      : super(key: key);

  final String range, price, unit;
  @override
  _VehicleRideDetailsState createState() => _VehicleRideDetailsState();
}

class _VehicleRideDetailsState extends State<VehicleRideDetails> {
  int selectedRadioValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Text('2 Hrs,' + widget.range + " " + widget.unit,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0)),
              ],
            ),
            Row(
              children: [
                Text('₹ ' + widget.price,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0)),
                Radio(
                  value: widget.hashCode,
                  groupValue: selectedRadioValue,
                  onChanged: (value) {
                    selectedRadioValue = int.parse(value.toString());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Container(
    //       height: 3,
    //       color: Colors.grey[200],
    //     ),
    //     ListView.builder(
    //       shrinkWrap: true,
    //       itemBuilder: ((context, index) {
    //         return Container(
    //           color: Colors.white,
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Row(
    //                   children: [
    //                     const SizedBox(
    //                       width: 5,
    //                     ),
    //                     Text('2 Hrs,' + widget.vehicleCategories.range[index],
    //                         style: const TextStyle(
    //                             color: Colors.black,
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w800,
    //                             letterSpacing: 0)),
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Text('₹ ' + widget.vehicleCategories.range[index],
    //                         style: const TextStyle(
    //                             color: Colors.black,
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w800,
    //                             letterSpacing: 0)),
    //                     Radio(
    //                       value: 0,
    //                       groupValue: selectedRadioValue,
    //                       onChanged: null,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );

    //         // return Row(
    //         //   children: [
    //         //     const SizedBox(
    //         //       width: 5,
    //         //     ),
    //         //     Text(
    //         //         widget.vehicleCategories.price[index] +
    //         //             " Hrs" +
    //         //             "," +
    //         //             widget.vehicleCategories.range[index] +
    //         //             widget.vehicleCategories.unit,
    //         //         style: const TextStyle(
    //         //             color: Colors.black,
    //         //             fontSize: 12,
    //         //             fontWeight: FontWeight.w800,
    //         //             letterSpacing: 0)),
    //         //   ],
    //         // );
    //       }),
    //       itemCount: widget.vehicleCategories.price.length,
    //     ),
    //     Container(
    //       color: Colors.white,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Row(
    //               children: const [
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text('1 Hrs,10.0km',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w800,
    //                         letterSpacing: 0)),
    //               ],
    //             ),
    //             Row(
    //               children: const [
    //                 Text('₹ 499.00',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w800,
    //                         letterSpacing: 0)),
    //                 Radio(
    //                   value: 0,
    //                   groupValue: 1,
    //                   onChanged: null,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Container(
    //       color: Colors.white,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Row(
    //               children: const [
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text('2 Hrs,10.0km',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w800,
    //                         letterSpacing: 0)),
    //               ],
    //             ),
    //             Row(
    //               children: const [
    //                 Text('₹ 499.00',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w800,
    //                         letterSpacing: 0)),
    //                 Radio(
    //                   value: 0,
    //                   groupValue: 1,
    //                   onChanged: null,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Container(
    //       color: Colors.white,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Row(
    //               children: [
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text('2 Hrs,10.0km',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w800,
    //                         letterSpacing: 0)),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Text('₹ 499.00',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w800,
    //                         letterSpacing: 0)),
    //                 Radio(
    //                   value: 0,
    //                   groupValue: 1,
    //                   onChanged: null,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Container(
    //       color: Colors.white,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Row(
    //               children: [
    //                 SizedBox(
    //                   width: 5,
    //                 ),
    //                 Text('2 Hrs,10.0km',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w800,
    //                         letterSpacing: 0)),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Text('₹ 499.00',
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w800,
    //                         letterSpacing: 0)),
    //                 Radio(
    //                   value: 0,
    //                   groupValue: 1,
    //                   onChanged: null,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Container(
    //       height: 3,
    //       color: Colors.grey[200],
    //     ),
    //     Container(
    //       color: Colors.white,
    //       child: Padding(
    //         padding: const EdgeInsets.all(12.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             const Text('Save 18% on this trip',
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w700,
    //                     letterSpacing: 0.3)),
    //             Row(
    //               children: [
    //                 Icon(Icons.redeem, color: Colors.green.shade800),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.pushNamed(context, 'CouponPage');
    //                   },
    //                   child: const Text('  Apply Coupon',
    //                       style: TextStyle(
    //                           color: Color.fromARGB(255, 88, 26, 22),
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w700,
    //                           letterSpacing: 0.3)),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     // Container(
    //     //   height: 3,
    //     //   color: Colors.grey[200],
    //     // ),
    //   ],
    // );
  }
}

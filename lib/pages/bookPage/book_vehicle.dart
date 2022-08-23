import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_ank_customer/Models/book_vehicle_models.dart';
import 'package:new_ank_customer/Models/goods_type.dart';
import 'package:new_ank_customer/Models/near_driver_list_model.dart';
import 'package:new_ank_customer/Models/vehicle_categories_response_model.dart';
import 'package:new_ank_customer/Services/apiProvider/book_vehicle_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/goods_types_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/helper_list_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/nearby_driver_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/unit_list_api_provider.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:new_ank_customer/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:new_ank_customer/common/color_const.dart';
import 'package:new_ank_customer/common/common_styles.dart';
import 'package:new_ank_customer/common/utils.dart';
import 'package:new_ank_customer/pages/common_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:new_ank_customer/pages/fetchLocation/fetch_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_ank_customer/pages/goods_type_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/unit_list_model.dart';
import '../../Services/apiProvider/order_history_api_provider.dart';
import '../../Services/apiProvider/vehicle_categories_api_provider.dart';
import '../../common/clippers.dart';
import '../../common/custom_divider.dart';
import 'package:cashfree_pg/cashfree_pg.dart';

class BookVehiclePage extends StatefulWidget {
  const BookVehiclePage({
    Key? key,
    required this.toLatitude,
    required this.toLongitude,
    required this.toAddress,
    required this.pickupContactName,
    required this.pickupContactPhone,
    required this.toState,
    required this.fromAddress,
    this.fromLat,
    this.fromLong,
    this.stop1,
    this.stop1lat,
    this.stop1long,
    this.stop2Lat,
    this.stop2Long,
    this.stop3Lat,
    this.stop3Long,
    this.stop2,
    this.stop3,
  }) : super(key: key);
  final double? fromLat,
      fromLong,
      toLatitude,
      toLongitude,
      stop1lat,
      stop1long,
      stop2Lat,
      stop2Long,
      stop3Lat,
      stop3Long;
  final String? toAddress,
      pickupContactName,
      pickupContactPhone,
      toState,
      fromAddress,
      stop1,
      stop2,
      stop3;

  @override
  _BookVehiclePageState createState() => _BookVehiclePageState();
}

class _BookVehiclePageState extends State<BookVehiclePage> {
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  // final Location _location = Location();

  late BitmapDescriptor autoNearByVehicle;
  late BitmapDescriptor cabNearByVehicle;
  late BitmapDescriptor truckNearByVehicle;
  late BitmapDescriptor myLocation;
  late BitmapDescriptor endLocation;
  late BitmapDescriptor stopLocation;
  final Set<Marker> _markers = <Marker>{};

  bool viewStop = false;

  @override
  void initState() {
    getMarkerIcon();
    addLocation();

    // _addPolyLine();
    _getPolyline();

    context.read<VehicleCategoriesAPIProvider>().initialize();
    /*if (widget.stop1lat == null &&
        widget.stop2Lat == null &&
        widget.stop3Lat == null) {
      print("------------ Work  if");*/
    context.read<VehicleCategoriesAPIProvider>().fetchData(
        fromLat: widget.fromLat!,
        fromLong: widget.fromLong!,
        toLat: widget.toLatitude!.toString(),
        toLong: widget.toLongitude!.toString(),
        labourQuantity: 0);
/*    } else if (widget.stop1lat != null &&
        widget.stop2Lat == null &&
        widget.stop3Lat == null) {
      print("------------ Work  else if  1");

      context.read<VehicleCategoriesAPIProvider>().fetchData(
          fromLat: widget.fromLat!,
          fromLong: widget.fromLong!,
          toLat: "₹${widget.stop1lat}₹${widget.toLatitude}".toString(),
          toLong: "₹${widget.stop1long}₹${widget.toLongitude}".toString(),
          labourQuantity: 0);
    } else if (widget.toLatitude != null &&
        widget.stop1lat != null &&
        widget.stop2Lat != null &&
        widget.stop3Lat != null) {
      print("------------ Work  else if  2");

      context.read<VehicleCategoriesAPIProvider>().fetchData(
          fromLat: widget.fromLat!,
          fromLong: widget.fromLong!,
          toLat:
              "₹${widget.stop1lat}₹${widget.stop2Lat}₹${widget.stop3Lat}₹${widget.toLatitude}"
                  .toString(),
          toLong:
              "₹${widget.stop1long}₹${widget.stop2Long}₹${widget.stop3Long}₹${widget.toLongitude}"
                  .toString(),
          labourQuantity: 0);
    }*/

    //  print("List Book Vechie --------"${double.parse(latlng.toString())});
    // getNearDriver();
    if (context.read<HomePageProvider>().markerSet.isNotEmpty) {
      context.read<HomePageProvider>().clearMarkers();
    }
    VehicleCategoriesResponseModel? vehicleCategoriesResponseModel;

    // initialize();
    super.initState();
  }

  // ployLine -----------

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};

  List<LatLng> latlng = [];
  addLocation() {
    latlng.add(LatLng(widget.fromLat!, widget.fromLong!));
    latlng.add(LatLng(widget.toLatitude!, widget.toLongitude!));
    if (widget.stop1lat != null)
      latlng.add(LatLng(widget.stop1lat!, widget.stop1long!));
    if (widget.stop2Lat != null)
      latlng.add(LatLng(widget.stop2Lat!, widget.stop2Long!));
    if (widget.stop3Lat != null)
      latlng.add(LatLng(widget.stop3Lat!, widget.stop3Long!));
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 3,
        polylineId: id,
        color: Colors.blue,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();
  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDgrOHeCPPtxJVF3GGQvkfZrXllj6Z4HTU",
        PointLatLng(widget.fromLat!, widget.fromLong!),
        PointLatLng(widget.toLatitude!, widget.toLongitude!),
        travelMode: TravelMode.driving,
        wayPoints: [
          if (widget.stop1lat != null)
            PolylineWayPoint(
                location: "${widget.stop1lat},${widget.stop1long}",
                stopOver: true),
          if (widget.stop2Lat != null)
            PolylineWayPoint(
                location: "${widget.stop2Lat},${widget.stop2Long}",
                stopOver: true),
          if (widget.stop3Lat != null)
            PolylineWayPoint(
                location: "${widget.stop3Lat},${widget.stop3Long}",
                stopOver: true)
        ]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  getMarkerIcon() async {
    autoNearByVehicle = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), 'assets/auto.png');

    cabNearByVehicle = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/driving_pin.png');

    truckNearByVehicle = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), 'assets/auto.png');

    myLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/srtLoc.png');

    endLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/endLoc.png');
    stopLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/stopLoc.png');
  }

  List<NearByVehicleList> vehicleList = [];
  String vechileId = "1";
  Future<void> getNearDriver() async {
    final nearByDriverList =
        Provider.of<NearbyDriverListAPIProvider>(context, listen: false);
    //  _markers.clear();
    await nearByDriverList.nearByDriverList(
        widget.fromLat!.toString(), widget.fromLong!.toString(), vechileId, "");
    print("Fetching vehicle List");

    if (nearByDriverList.nearByDriverListModel!.status != "0") {
      vehicleList = nearByDriverList.nearByDriverListModel!.vehicleList!;

      for (var element in vehicleList) {
        // print("ELement " + element.driverName!);
        if (element.driverType == "0") {
          //Auto
          var pinPosition = LatLng(double.parse(element.latitude!),
              double.parse(element.longitude!));
          _markers.add(Marker(
              markerId: MarkerId(element.id!),
              position: pinPosition,
              /*       rotation: double.parse(heading),*/
              draggable: false,
              zIndex: 2,
              flat: true,
              anchor: const Offset(0.5, 0.5),
              icon: autoNearByVehicle));
        } else if (element.driverType == "1") {
          //Cab
          var pinPosition = LatLng(double.parse(element.latitude!),
              double.parse(element.longitude!));
          _markers.add(Marker(
              markerId: MarkerId(element.id!),
              position: pinPosition,
              /*       rotation: double.parse(heading),*/
              draggable: false,
              zIndex: 2,
              flat: true,
              anchor: const Offset(0.5, 0.5),
              icon: cabNearByVehicle));
        } else if (element.driverType == "2") {
          //Logistics
          var pinPosition = LatLng(double.parse(element.latitude!),
              double.parse(element.longitude!));
          _markers.add(Marker(
              markerId: MarkerId(element.id!),
              position: pinPosition,
              /*       rotation: double.parse(heading),*/
              draggable: false,
              zIndex: 2,
              flat: true,
              anchor: const Offset(0.5, 0.5),
              icon: truckNearByVehicle));
        }
      }
    } else {
      Utils.showErrorMessage("Driver not Available in your in Location !!!");
    }
    var myLocationPostition = LatLng(widget.fromLat!, widget.fromLong!);

    print(
        "-------------------${SharedPreference.latitude!} ${SharedPreference.longitude!}");
    _markers.add(Marker(
        markerId: const MarkerId("MyPosition"),
        position: myLocationPostition,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: myLocation));

    var endLocationPostition = LatLng(widget.toLatitude!, widget.toLongitude!);
    _markers.add(Marker(
        markerId: const MarkerId("EndPosition"),
        position: endLocationPostition,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: endLocation));

    // Stop1 Location

    var stop1LocationPostition = LatLng(widget.stop1lat!, widget.stop1long!);
    if (widget.stop1lat != null)
      _markers.add(Marker(
          markerId: const MarkerId("Stop1"),
          position: stop1LocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: stopLocation)); // Stop1 Location

    var stop2LocationPostition = LatLng(widget.stop2Lat!, widget.stop2Long!);
    if (widget.stop2Lat != null)
      _markers.add(Marker(
          markerId: const MarkerId("Stop2"),
          position: stop2LocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: stopLocation)); // Stop1 Location

    var stop3LocationPostition = LatLng(widget.stop3Lat!, widget.stop3Long!);
    if (widget.stop3Lat != null)
      _markers.add(Marker(
          markerId: const MarkerId("Stop3"),
          position: stop3LocationPostition,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: stopLocation));

    setState(() {});
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    getJsonFile("assets/mapStyle.json")
        .then((value) => _cntlr.setMapStyle(value));

    getNearDriver();

    homePageProvider.googleMapController = _cntlr;

    homePageProvider.getDistance(widget.toLatitude!, widget.toLongitude!);
  }

  ScreenshotController screenShotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    print("List -------" + latlng.length.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(),
      // bottomSheet: buildvehicalType(),
      bottomNavigationBar: buildBNB(),
    );
  }

  String selectedGoodTypeName = "";
  String selectedGoodTypeUnit = "";
  String selectedUnitType = "";

  buildBody() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Screenshot(child: buildMap(), controller: controller)
        buildMap(),
        DraggableScrollableSheet(
            minChildSize: 0.50,
            initialChildSize: 0.65,
            maxChildSize: 0.65,
            builder: (context, draggableController) {
              return SingleChildScrollView(
                controller: draggableController,
                physics: const ClampingScrollPhysics(),
                child: buildvehicalType(),
              );
            }),
      ],
    );
  }

  buildBodySliver() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: deviceHeight(context) * 0.5,
          floating: true,
          primary: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            // title:,
            background: buildMap(),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            primary: false,
            child: Container(
              height: 700,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: buildvehicalType(),
            ),
          ),
        ),
        // SliverFillRemaining(
        //   child:
        // )
      ],
    );
  }

  buildMap() {
    return SizedBox(
      height: deviceHeight(context) * 0.5,
      child: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.terrain,
        onMapCreated: _onMapCreated,
        markers: _markers,
        polylines: Set<Polyline>.of(polylines.values),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
      ),
    );
  }

  bool _isSelectedHelper = false;
  int _numberOfHelpers = 0;
  TimeOfDay selectedTime = TimeOfDay.now();

  Widget buildvehicalType() {
    final vehicleCategoryAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);
    if (vehicleCategoryAPIProvider.ifLoading) {
      return const SizedBox();
    }
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        // shrinkWrap: true,
        // scrollDirection: Axis.vertical,
        // mainAxisSize: MainAxisSize.min,
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
          // Container(
          //   color: Colors.amber[100],
          //   child: const Padding(
          //     padding: EdgeInsets.all(5.0),
          //     child: Text(
          //       'Drop Should be within city Boundary',
          //       style: TextStyle(
          //         fontSize: 10,
          //         fontWeight: FontWeight.w600,
          //         letterSpacing: 0.3,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),

          Stack(
            children: [
              ClipPath(
                  clipper: CustomShapeCopyClipper(),
                  child: SizedBox(
                      height: 135,
                      child: ClipPath(
                          clipper: CustomShapeClipper(),
                          child: Container(
                            height: 135,
                            /*  decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[
                                  Color(0xffbac3fc),
                                  Color(0xffa7c3f9)
                                ],
                              ),
                            ),*/
                          )))),
              Column(
                children: [
                  isOutStationOrInStation(),
                  Utils.getSizedBox(height: 10),
                  /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 15,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.add_location_alt_outlined,
                                        size: 15,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          widget.fromAddress!,
                                          maxLines: 3,
                                          style: CommonStyles.green12(),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomDividerView(
                                    dividerHeight: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.add_location_alt_outlined,
                                        size: 15,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          widget.toAddress!,
                                          maxLines: 3,
                                          style: CommonStyles.red12(),
                                        ),
                                      )
                                    ],
                                  ),

                                  //  if (viewStop == false)
                                  if (widget.stop1 != " ")
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomDividerView(
                                            dividerHeight: 1,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextButton(
                                            child: Text(
                                              "View Stops",
                                              style: CommonStyles.red12(),
                                            ),
                                            onPressed: () {
                                              viewStop = !viewStop;

                                              print("View Stop -----------" +
                                                  viewStop.toString());
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (viewStop == true)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.add_location_alt_outlined,
                                              size: 15,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                widget.stop1!,
                                                maxLines: 3,
                                                style: CommonStyles.black12(),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDividerView(
                                          dividerHeight: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.add_location_alt_outlined,
                                              size: 15,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                widget.stop2!,
                                                maxLines: 3,
                                                style: CommonStyles.black12(),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDividerView(
                                          dividerHeight: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.add_location_alt_outlined,
                                              size: 15,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                widget.stop3!,
                                                maxLines: 3,
                                                style: CommonStyles.black12(),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Card(
                                  child: Center(
                                    child: IconButton(
                                        icon: Icon(Icons.schedule),
                                        onPressed: () async {
                                          await _selectTime(context);
                                        }),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),*/
                  helperWidget(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Schedule Time  : ',
                          style: CommonStyles.black12(),
                        ),
                        Row(
                          children: [
                            Text(
                              "${DateTime.now().day.toString()} - ${DateTime.now().month.toString()} - ${DateTime.now().year.toString()}  ",
                              style: CommonStyles.blue13(),
                            ),
                            Text(
                              "${selectedTime.hour.toString()} : ${selectedTime.minute.toString()} : ${selectedTime.periodOffset.toString()}",
                              style: CommonStyles.blue13(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Receiver contact',
                          style: CommonStyles.black12(),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.pickupContactName! + " : ",
                              style: CommonStyles.blue13(),
                            ),
                            Text(
                              widget.pickupContactPhone!,
                              style: CommonStyles.blue13(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _showBookingPage,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          final result = await showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return const SelectGoodTyepBottomSheet();
                              });
                          getListOfSelectedGoodType();

                          if (result != null) {
                            setState(() {
                              _showBookingPage = true;
                              selectedGoodTypeName = result['goodtype'];
                              selectedGoodTypeUnit = result['unit'];
                              selectedUnitType = result['properUnit'];
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Selected Good Type',
                              style: CommonStyles.black12(),
                            ),
                            Text(
                              selectedGoodTypeName +
                                  " " +
                                  selectedGoodTypeUnit +
                                  " " +
                                  selectedUnitType,
                              //  categoryName.split(',').first
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                              style: CommonStyles.blue12(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                SizedBox(
                  height: 0,
                ),
                /*Text(
                  "Recommended For You !!",
                  style: CommonStyles.blue14900(),
                ),*/
                instantBookVehicle()
              ],
            ),
          ),

          Utils.getSizedBox(height: 10),
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        print("--------------" + selectedTime.format(context));
      });
    }
  }

  String categoryName = "";
  String firstList = "";
  int totalIndex = 0;

  getListOfSelectedGoodType() {
    final goodTypeAPIProvider =
        Provider.of<ListGoodTypeAPIProvider>(context, listen: false);
    for (int i = 0; i < selectedGoodTye.length; i++) {
      if (selectedGoodTye[i]) {
        categoryName += goodTypeAPIProvider
                .goodsTypeResponseModel!.categoryList![i].categoryName! +
            " " +
            textEditingController[i].text +
            " " +
            selectedUnit[i]!.units! +
            ",";
      }
    }
  }

  List<DataRow> returnRowgetListOfSelectedGoodType() {
    final goodTypeAPIProvider =
        Provider.of<ListGoodTypeAPIProvider>(context, listen: false);

    List<DataRow> dataRowList = [];

    for (int i = 0; i < selectedGoodTye.length; i++) {
      if (selectedGoodTye[i]) {
        dataRowList.add(DataRow(cells: [
          DataCell(SizedBox(
            width: deviceWidth(context) * 0.5,
            child: Text(
              goodTypeAPIProvider
                  .goodsTypeResponseModel!.categoryList![i].categoryName!,
              style: CommonStyles.black10thin(),
            ),
          )),
          DataCell(SizedBox(
            width: deviceWidth(context) * 0.2,
            child: Text(
              textEditingController[i].text,
              style: CommonStyles.black10thin(),
            ),
          )),
          DataCell(SizedBox(
            width: deviceWidth(context) * 0.2,
            child: Text(
              selectedUnit[i]!.units!,
              style: CommonStyles.black10thin(),
            ),
          ))
        ]));
      }
    }
    return dataRowList;
  }

  isOutStationOrInStation() {
    final vehicleCategoryAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);
    if (vehicleCategoryAPIProvider.ifLoading ||
        vehicleCategoryAPIProvider.vehicleCategoriesResponseModel == null) {
      return const SizedBox();
    }

    return Visibility(
      visible: !vehicleCategoryAPIProvider.ifLoading &&
          vehicleCategoryAPIProvider
                  .vehicleCategoriesResponseModel!.outerState ==
              "1",
      child: ShakeWidget(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 0.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.7,
                    0.8,
                  ],
                  colors: [ColorConstant.black900, ColorConstant.blue800Cc],
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   height: 24,
                  //   width: 24,
                  //   decoration: const BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage('assets/boxpacking.jpg'))),
                  // ),
                  Row(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 2.0, bottom: 2.0, left: 6),
                        child: Icon(
                          FontAwesomeIcons.artstation,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                      Utils.getSizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You have choosed Out of the State  !!!",
                            textAlign: TextAlign.left,
                            style: CommonStyles.white11(),
                          ),
                          /* RichText(
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            text: TextSpan(
                                text: "Outstation Charges : ",
                                style: CommonStyles.white11(),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "  ₹  " +
                                          vehicleCategoryAPIProvider
                                              .vehicleCategoriesResponseModel!
                                              .vehicleList![selectedIndex]
                                              .outerCharge!,
                                      style: CommonStyles.white11(),
                                      children: [
                                        TextSpan(
                                            text: " added.",
                                            style: CommonStyles.white9())
                                      ])
                                ]),
                          ),*/
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        // begin: Alignment.bottomLeft,
                        // end: Alignment.topRight,
                        tileMode: TileMode.decal,
                        colors: <Color>[
                          // Color(0xffc850c0),
                          ColorConstant.black900,
                          ColorConstant.blue800Cc,
                        ],
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        splashColor: Colors.blue,
                        onPressed: () async {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: "+91 123455678",
                          );
                          await launch(launchUri.toString());
                        },
                        icon: Stack(
                          children: const <Widget>[
                            Positioned(
                                left: -1.0,
                                bottom: 0.2,
                                child: Icon(Icons.phone_enabled_rounded,
                                    size: 32, color: Colors.black54)),
                            Icon(Icons.phone_enabled_rounded,
                                size: 32, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // return  S);
  }

  bool _showBookingPage = false;

  buildBNBGoodsType() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeumorphicButton(
        provideHapticFeedback: true,

        onPressed: () async {
          final result = await showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const GoodsTypeScreen();
              });
          if (result != null) {
            setState(() {
              _showBookingPage = true;
              selectedGoodTypeName = result['goodtype'];
              /*selectedGoodTypeUnit = result['unit'];
              selectedUnitType = result['properUnit'];*/
            });
          }
        },

        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Good Types ?",
            style: CommonStyles.whiteText15BoldW500(),
            textAlign: TextAlign.center,
          ),
        ),
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          color: ColorConstant.blue800Cc,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          //border: NeumorphicBorder()
        ),
        // minWidth: deviceWidth(context) * 0.95,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        // color: Colors.blue[900],
      ),
    );
  }

  buildBNB() {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);
    if (!_showBookingPage) {
      return buildBNBGoodsType();
    }
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  final vehicleCategoriesAPIProvider =
                      Provider.of<VehicleCategoriesAPIProvider>(context,
                          listen: false);
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      context: context,
                      builder: (context) {
                        return Verify30PercentPayment(
                          stop1Lat: widget.stop1lat,
                          stop1Long: widget.stop1long,
                          stop2Lat: widget.stop2Lat,
                          stop2Long: widget.stop2Long,
                          stop3Lat: widget.stop3Lat,
                          stop3Long: widget.stop3Long,
                          stop1Address: widget.stop1,
                          stop2Address: widget.stop2,
                          stop3Address: widget.stop3,
                          fromAddress: widget.fromAddress!,
                          fromLat: widget.fromLat!,
                          fromLong: widget.fromLong!,
                          toLatitude: widget.toLatitude!,
                          toLongitude: widget.toLongitude!,
                          pickupContactName: widget.pickupContactName!,
                          pickupContactPhone: widget.pickupContactPhone!,
                          toAddress: widget.toAddress!,
                          vehicleList: vehicleCategoriesAPIProvider
                              .vehicleCategoriesResponseModel!
                              .vehicleList![selectedIndex],
                          vehicleSelectedIndex: selectedIndex,
                          toPayAmount: "",
                        );
                      });
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
        height: 50,
        width: 150,
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
            color: ColorConstant.blue800Cc,
            borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Book  :  ' +
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
                insetPadding: const EdgeInsets.all(0),
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

    // print("Trip KM" + vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.kmLimitStatus!);

    if (vehicleCategoriesAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (vehicleCategoriesAPIProvider.error) {
      return SizedBox(
        height: 400,
        width: 300,
        child:
            Utils.showErrorMessage(vehicleCategoriesAPIProvider.errorMessage),
      );
    } else if (vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel ==
            null ||
        vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.status! ==
            "0") {
      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    } else {
      final _vehicleCategoryList = vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.vehicleList;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 430,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                primary: false,
                scrollDirection: Axis.vertical,
                itemCount: _vehicleCategoryList!.length,
                itemBuilder: (BuildContext context, int index) {
                  print("The length of vehicle list " +
                      _vehicleCategoryList.length.toString());
                  print("Index" + index.toString());
                  print(_vehicleCategoryList.length == index + 1);

                  return Padding(
                    padding: _vehicleCategoryList.length == index + 1
                        ? const EdgeInsets.only(bottom: 140.0)
                        : const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      elevation: selectedIndex == index ? 10 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        curve: selectedIndex == index
                            ? Curves.easeIn
                            : Curves.easeInOut,
                        // elevation: selectedIndex == index ? 10 : 0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: selectedIndex == index
                                  ? ColorConstant.blue800Cc
                                  : Colors.transparent),
                          boxShadow: selectedIndex == index
                              ? [
                                  BoxShadow(
                                      color: Colors.blue.shade50,
                                      spreadRadius: 3,
                                      blurRadius: 1.2,
                                      blurStyle: BlurStyle.normal)
                                ]
                              : [],
                        ),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              selectedIndex = index;
                              vechileId = _vehicleCategoryList[index].id!;
                              getNearDriver();
                            });
                            showVehicleDetails(context);
                          },
                          child: SizedBox(
                            width: 100,
                            // color: Colors.blueGrey[100],
                            height: 80,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "₹ " +
                                          _vehicleCategoryList[index]
                                              .totalPrice!,
                                      style: CommonStyles.red15(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Utils.getSizedBox(width: 5),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          _vehicleCategoryList[index].wheeler!,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: ColorConstant.blue800Cc,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.2),
                                        ),
                                        /*Text(
                                          "Get ${_vehicleCategoryList[index].wheeler!} at your Door step",
                                          style: CommonStyles.black11(),
                                          textAlign: TextAlign.center,
                                        )*/
                                      ],
                                    ),
                                  ),
                                  Utils.getSizedBox(height: 5),
                                  Utils.getSizedBox(width: 5),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      vehicleCategoriesAPIProvider
                                                              .vehicleCategoriesResponseModel!
                                                              .vehicleBaseurl! +
                                                          _vehicleCategoryList[
                                                                  index]
                                                              .image!))),
                                        ),
                                        Text(
                                          _vehicleCategoryList[index].time!,
                                          style: CommonStyles.black12(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  showVehicleDetails(BuildContext context) async {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context, listen: false);
    return await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (buildContext) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, bottom: 4, left: 4),
                    child: Text(
                        vehicleCategoriesAPIProvider
                            .vehicleCategoriesResponseModel!
                            .vehicleList![selectedIndex]
                            .wheeler!,
                        style: CommonStyles.blue14900()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Capacity", style: CommonStyles.black12()),
                        Text(
                          vehicleCategoriesAPIProvider
                              .vehicleCategoriesResponseModel!
                              .vehicleList![selectedIndex]
                              .capacity!,
                          style: CommonStyles.black12(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Size", style: CommonStyles.black12()),
                        Text(
                          vehicleCategoriesAPIProvider
                              .vehicleCategoriesResponseModel!
                              .vehicleList![selectedIndex]
                              .size!,
                          style: CommonStyles.black12(),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    itemCount: vehicleCategoriesAPIProvider
                        .vehicleCategoriesResponseModel!
                        .vehicleList![selectedIndex]
                        .description!
                        .length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      // if()
                      if (vehicleCategoriesAPIProvider
                              .vehicleCategoriesResponseModel!
                              .vehicleList![selectedIndex]
                              .description![index] ==
                          "") {
                        return SizedBox();
                      }
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 5, left: 8),
                          child: Center(
                            child: Row(
                              children: [
                                const MyBullet(),
                                Utils.getSizedBox(width: 15),
                                Flexible(
                                  child: Text(
                                      vehicleCategoriesAPIProvider
                                          .vehicleCategoriesResponseModel!
                                          .vehicleList![selectedIndex]
                                          .description![index],
                                      style: CommonStyles.black10thin()),
                                ),
                                // ListTile(
                                //   dense: true,
                                //   contentPadding: const EdgeInsets.only(left: 4),
                                //   visualDensity: VisualDensity.compact,
                                //   leading:
                                //   horizontalTitleGap: 0,
                                //   title:
                                // ),
                              ],
                            ),
                          ));
                    }),
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        elevation: 10,
                        color: ColorConstant.blue800Cc,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Okay",
                          style: CommonStyles.whiteText15BoldW500(),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
          );
        });
  }

  helperWidget() {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);

    if (vehicleCategoriesAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (vehicleCategoriesAPIProvider.error) {
      return SizedBox(
        height: 400,
        width: 300,
        child:
            Utils.showErrorMessage(vehicleCategoriesAPIProvider.errorMessage),
      );
    } else if (vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel ==
            null ||
        vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.status! ==
            "0") {
      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    }
    // final labourDe = vehicleCategoriesAPIProvider
    //     .vehicleCategoriesResponseModel!.labourDetails;

    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.lightBlue.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //  height: 50,
        // width: deviceWidth(context),
        /*blur: 3,
        shadowStrength: 10,
        opacity: 0.5,*/

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // Checkbox(
            //     value: _isSelectedHelper,
            //     onChanged: _vehicleCategoryList[selectedIndex].labour != "0"
            //         ? (value) {
            //             setState(() {
            //               _isSelectedHelper = !_isSelectedHelper;
            //             });
            //           }
            //         : (value) {}),
            //  _vehicleCategoryList[
            //                                         selectedIndex]
            //                                     .labour ==
            //                                 "0"
            //                             ? " is not "
            //                             : " is "
            Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/boxpacking.jpg'))),
                ),
                Utils.getSizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _numberOfHelpers != 0
                        ? Text(
                            "Helper Selected",
                            textAlign: TextAlign.left,
                            style: CommonStyles.blueText12BoldW500(),
                          )
                        : Text(
                            "I Want Helper",
                            textAlign: TextAlign.left,
                            style: CommonStyles.blueText12BoldW500(),
                          ),
                    _numberOfHelpers != 0
                        ? SizedBox(
                            width: 200,
                            child: RichText(
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              text: TextSpan(
                                  text: _numberOfHelpers.toString(),
                                  style: CommonStyles.black1254thin(),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: " Helpers ",
                                        style: CommonStyles.black11(),
                                        children: [
                                          TextSpan(
                                              text: "added to this trip.",
                                              style: CommonStyles.black11())
                                        ])
                                  ]),
                            ),
                          )
                        : SizedBox(
                            width: 200,
                            child: FittedBox(
                              child: RichText(
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                text: TextSpan(
                                    text: "Add",
                                    style: CommonStyles.black11(),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: " extra ",
                                          style: CommonStyles.black11(),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "help for loading and unloading",
                                                style: CommonStyles.black11())
                                          ])
                                    ]),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),

            Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: _isSelectedHelper,
                onChanged: (value) async {
                  if (value) {
                    final Map<String, dynamic>? result =
                        await showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12))),
                            context: context,
                            builder: (context) {
                              return const HelperDetailsBottomSheet();
                            });
                    if (result != null) {
                      setState(() {
                        _numberOfHelpers = result['noh'];
                        _isSelectedHelper = true;
                      });
                      print('_isselected helper _ _number of heter -------' +
                          _numberOfHelpers.toString() +
                          "=---" +
                          _isSelectedHelper.toString());
                    }
                  } else {
                    context.read<VehicleCategoriesAPIProvider>().fetchData(
                        fromLat: SharedPreference.latitude!,
                        fromLong: SharedPreference.longitude!,
                        toLat: selectedLongLat.selectedLatitude!.toString(),
                        toLong: selectedLongLat.selectedLongitude!.toString(),
                        labourQuantity: 0);
                    setState(() {
                      _isSelectedHelper = false;
                      _numberOfHelpers = 0;
                    });
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  outerStateDialog() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 7),
            child: Icon(
              Icons.info,
              color: Colors.black54,
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                  child: Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 5,
                    color: Colors.blue,
                    endIndent: 5,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.toState!,
                        style: CommonStyles.black1654thin(),
                      ),
                      Text(
                        "is outside city boundary",
                        style: CommonStyles.black1654thin(),
                      ),
                      Utils.getSizedBox(height: 10),
                      Text(
                        "You can continue to book an Outstation ride",
                        style: CommonStyles.black13thin(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/outStation.png")),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                "Continue with outstation booking",
                style: CommonStyles.whiteText12BoldW500(),
              ),
              minWidth: deviceWidth(context) * 0.95,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Colors.blue[900],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                "Change Drop Location",
                style: CommonStyles.black13thin(),
              ),
              minWidth: deviceWidth(context) * 0.95,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromARGB(31, 181, 163, 163),
            ),
          )
        ],
      ),
    );
  }
}

class ShakeWidget extends StatelessWidget {
  final Duration duration;
  final double deltaX;
  final Widget? child;
  final Curve curve;

  const ShakeWidget({
    Key? key,
    this.duration = const Duration(seconds: 2),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
    required this.child,
  }) : super(key: key);

  /// convert 0-1 to 0-1-0
  double shake(double animation) =>
      2 * (0.5 - (0.5 - curve.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: key,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, animation, child) => Transform.translate(
        offset: Offset(deltaX * shake(animation), 0),
        child: child,
      ),
      child: child,
    );
  }
}

class HelperSelectFragment extends StatefulWidget {
  const HelperSelectFragment({Key? key}) : super(key: key);

  @override
  _HelperSelectFragmentState createState() => _HelperSelectFragmentState();
}

class _HelperSelectFragmentState extends State<HelperSelectFragment> {
  bool _isSelectedHelper = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 0.5,
              color: Colors.black12,
            ),
            color: Colors.black12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // Checkbox(
            //     value: _isSelectedHelper,
            //     onChanged: _vehicleCategoryList[selectedIndex].labour != "0"
            //         ? (value) {
            //             setState(() {
            //               _isSelectedHelper = !_isSelectedHelper;
            //             });
            //           }
            //         : (value) {}),
            //  _vehicleCategoryList[
            //                                         selectedIndex]
            //                                     .labour ==
            //                                 "0"
            //                             ? " is not "
            //                             : " is "
            Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/boxpacking.jpg'))),
                ),
                Utils.getSizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Include Helper",
                      textAlign: TextAlign.left,
                      style: CommonStyles.blueText12BoldW500(),
                    ),
                    SizedBox(
                      width: 200,
                      child: FittedBox(
                        child: RichText(
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          text: TextSpan(
                              text: "Add",
                              style: CommonStyles.black1254thin(),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " extra ",
                                    style: CommonStyles.blue12(),
                                    children: [
                                      TextSpan(
                                          text:
                                              "help for loading and unloading",
                                          style: CommonStyles.black1254thin())
                                    ])
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
              width: 30,
              child: CupertinoSwitch(
                value: _isSelectedHelper,
                onChanged: (value) {
                  if (value) {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        builder: (context) {
                          return const HelperDetailsBottomSheet();
                        });
                  }
                  setState(() {
                    _isSelectedHelper = value;
                  });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class HelperDetailsBottomSheet extends StatefulWidget {
  const HelperDetailsBottomSheet({Key? key}) : super(key: key);

  @override
  _HelperDetailsBottomSheetState createState() =>
      _HelperDetailsBottomSheetState();
}

class _HelperDetailsBottomSheetState extends State<HelperDetailsBottomSheet> {
  late ExpandableController controller1;
  late ExpandableController controller2;

  bool start = false;

  @override
  void initState() {
    if (context.read<HelperListAPIProvider>().helperListResponseModel == null) {
      context.read<HelperListAPIProvider>().fetchData();
    }
    controller1 = ExpandableController(initialExpanded: true);
    controller2 = ExpandableController();
    _selectHelpers = 1;

    controller1.addListener(() {
      if (controller1.expanded) {
        _selectHelpers = 1;
        controller1.expanded = true;
        controller2.expanded = false;
      } else {
        controller2.value = true;
      }
      setState(() {});
    });
    controller2.addListener(() {
      print("is controller 2 expanded " + controller2.expanded.toString());
      if (controller2.expanded) {
        _selectHelpers = 2;
        controller2.expanded = true;
        controller1.expanded = false;
      } else {
        controller1.expanded = true;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  bool isAcceptedTermsAndCondition = false;
  UniqueKey expansionkey = UniqueKey();
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);
    if (vehicleCategoriesAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 300,
        width: 300,
      );
    } else if (vehicleCategoriesAPIProvider.error) {
      print("------error ----------------");
      return SizedBox(
        height: 300,
        width: 300,
        child:
            Utils.showErrorMessage(vehicleCategoriesAPIProvider.errorMessage),
      );
    } else if (vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel !=
            null &&
        vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.status! ==
            "0") {
      print("------error2 ----------------");

      return Utils.showErrorMessage(vehicleCategoriesAPIProvider
          .vehicleCategoriesResponseModel!.message!);
    } else {
      return SingleChildScrollView(
        // height: 300,

        // decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card2(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add extra help for',
                    style: CommonStyles.blue13900(),
                  ),
                  Text(
                    "Loading & Unloading",
                    style: CommonStyles.blue20900(),
                  )
                ],
              ),
            ),
            expandablePanel(),
            expandablePanel2(),
            Utils.getSizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(color: Colors.amber),
              width: deviceWidth(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Center(
                  child: Text(
                    " Fair will be increased by ₹ " +
                        getMultipleLabourPrice(int.parse(
                            vehicleCategoriesAPIProvider
                                .vehicleCategoriesResponseModel!
                                .labourDetails!
                                .price!)),
                    style: CommonStyles.whiteText12BoldW500(),
                  ),
                ),
              ),
            ),
            Utils.getSizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: isAcceptedTermsAndCondition,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          isAcceptedTermsAndCondition = value;
                        });
                      }
                    }),
                RichText(
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  text: TextSpan(
                      text: controller1.expanded
                          ? "I accept Helper service terms"
                          : "I accept ",
                      style: CommonStyles.black10thin(),
                      children: <TextSpan>[
                        if (!controller1.expanded)
                          TextSpan(
                              text: (_selectHelpers).toString() + " Helpers ",
                              style: CommonStyles.black10thin(),
                              children: [
                                TextSpan(
                                    text: "service terms",
                                    style: CommonStyles.black10thin())
                              ])
                      ]),
                ),
              ],
            ),
            Center(
              child: MaterialButton(
                minWidth: deviceWidth(context) * 0.95,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: isAcceptedTermsAndCondition
                    ? () {
                        print(selectedLongLat.selectedLatitude!.toString() +
                            "--------" +
                            selectedLongLat.selectedLongitude!.toString());

                        print(SharedPreference.latitude!.toString() +
                            "--------" +
                            SharedPreference.longitude!.toString());
                        context.read<VehicleCategoriesAPIProvider>().fetchData(
                            fromLat: SharedPreference.latitude!,
                            fromLong: SharedPreference.longitude!,
                            toLat: selectedLongLat.selectedLatitude!.toString(),
                            toLong:
                                selectedLongLat.selectedLongitude!.toString(),
                            labourQuantity: _selectHelpers);
                        Map<String, dynamic> map = {
                          'noh': _selectHelpers,
                        };
                        Navigator.of(context).pop(map);
                      }
                    : () {
                        Utils.showSnackBar(
                            context: this.context,
                            text: "Please accept terms and conditions!");
                      },
                color: isAcceptedTermsAndCondition
                    ? Colors.blue[900]
                    : const Color.fromARGB(255, 221, 204, 198),
                child: RichText(
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  text: TextSpan(
                      text: controller1.expanded ? "Add Helper" : "Add ",
                      style: isAcceptedTermsAndCondition
                          ? CommonStyles.white12()
                          : CommonStyles.blackw12s12(),
                      children: <TextSpan>[
                        if (!controller1.expanded)
                          TextSpan(
                            text: (_selectHelpers).toString() + " Helpers ",
                            style: isAcceptedTermsAndCondition
                                ? CommonStyles.white12()
                                : CommonStyles.blackw12s12(),
                          )
                      ]),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  UniqueKey expandablePanel1Key = UniqueKey();
  UniqueKey expandablePanel2Key = UniqueKey();

  expandablePanel() {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);
    return ExpandableNotifier(
      key: expandablePanel1Key,
      initialExpanded: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ScrollOnExpand(
            child: ExpandablePanel(
              controller: controller1,
              builder: (_, __, expanded) {
                return Expandable(
                  collapsed: const SizedBox(),
                  expanded: Padding(
                      padding: const EdgeInsets.all(10), child: expanded),
                );
              },
              theme: const ExpandableThemeData(
                  collapseIcon: Icons.radio_button_checked_rounded,
                  expandIcon: Icons.radio_button_off_outlined,
                  iconColor: Colors.blue,

                  // tapBodyToExpand: false,
                  tapBodyToCollapse: false),
              // controller: ,
              header: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/boxpacking.jpg'))),
                        ),
                        Utils.getSizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Helper (Single)",
                              style: CommonStyles.black12(),
                            ),
                            FittedBox(
                              child: Text(
                                "Request single helper",
                                maxLines: 2,
                                style: CommonStyles.black10thin(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "₹ " +
                          vehicleCategoriesAPIProvider
                              .vehicleCategoriesResponseModel!
                              .labourDetails!
                              .price!,
                      style: CommonStyles.black12(),
                    )
                  ],
                ),
              ),
              collapsed: const SizedBox(),
              expanded: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Helper won't do complete loading.",
                            style: CommonStyles.blackw54s9Thin(),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              "Only ground floor movement upto 25 meters distance",
                              style: CommonStyles.blackw54s9Thin())
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              "Maximum time of 3 hours for loading and unloading.",
                              style: CommonStyles.blackw54s9Thin())
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _selectHelpers = 2;

  String getMultipleLabourPrice(int pricePerHelper) {
    return (_selectHelpers * pricePerHelper).toString();
  }

  expandablePanel2() {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context);
    return ExpandableNotifier(
      key: expandablePanel2Key,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ScrollOnExpand(
            child: ExpandablePanel(
              controller: controller2,
              builder: (_, __, expanded) {
                return Expandable(
                  collapsed: const SizedBox(),
                  expanded: Padding(
                      padding: const EdgeInsets.all(10), child: expanded),
                );
              },
              theme: const ExpandableThemeData(
                  collapseIcon: Icons.radio_button_checked_rounded,
                  expandIcon: Icons.radio_button_off_outlined,
                  iconColor: Colors.blue,
                  tapBodyToExpand: false,
                  tapBodyToCollapse: false),
              // controller: ,
              header: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/boxpacking.jpg'))),
                        ),
                        Utils.getSizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Multiple Helper",
                              style: CommonStyles.black12(),
                            ),
                            RichText(
                                text: TextSpan(
                                    // text: controller1.expanded
                                    //     ? _selectHelpers.toString()
                                    //     : (_selectHelpers + 1).toString(),
                                    // style: CommonStyles.black11(),
                                    children: [
                                  TextSpan(
                                      text: "Request multiple helpers",
                                      style: CommonStyles.black1154())
                                ])),
                          ],
                        ),
                      ],
                    ),
                    controller1.expanded
                        ? Text(
                            "₹ " +
                                (int.parse(vehicleCategoriesAPIProvider
                                            .vehicleCategoriesResponseModel!
                                            .labourDetails!
                                            .price!) *
                                        2)
                                    .toString(),
                            style: CommonStyles.black12(),
                          )
                        : Text(
                            "₹ " +
                                getMultipleLabourPrice(int.parse(
                                    vehicleCategoriesAPIProvider
                                        .vehicleCategoriesResponseModel!
                                        .labourDetails!
                                        .price!)),
                            style: CommonStyles.black12(),
                          )
                  ],
                ),
              ),
              collapsed: const SizedBox(),
              expanded: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Row(
                        children: [
                          Text(
                            "Number of helpers".toString(),
                            style: CommonStyles.black11(),
                          ),
                          Utils.getSizedBox(width: 15),
                          Container(
                            width: 65,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: Icon(Icons.remove,
                                      color: Colors.brown[900]),
                                  onTap: () {
                                    if (_selectHelpers > 2) {
                                      setState(() {
                                        _selectHelpers--;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  _selectHelpers.toString(),
                                  style: CommonStyles.whiteText15BoldW500(),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.brown[900],
                                  ),
                                  onTap: () {
                                    if (_selectHelpers < 5) {
                                      setState(() {
                                        _selectHelpers++;
                                      });
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              "Helpers will do complete loading and unloading",
                              style: CommonStyles.blackw54s9Thin(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              "Only ground floor movement upto 25 meters distance",
                              style: CommonStyles.blackw54s9Thin())
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              "Maximum time of 3 hours for loading and unloading.",
                              style: CommonStyles.blackw54s9Thin())
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<bool> selectedGoodTye = [];
List<TextEditingController> textEditingController = [];
List<UnitList?> selectedUnit = [];

int selectedIndex = 0;

class SelectGoodTyepBottomSheet extends StatefulWidget {
  const SelectGoodTyepBottomSheet({Key? key}) : super(key: key);

  @override
  _SelectGoodTyepBottomSheetState createState() =>
      _SelectGoodTyepBottomSheetState();
}

class _SelectGoodTyepBottomSheetState extends State<SelectGoodTyepBottomSheet> {
  @override
  void initState() {
    if (context.read<UnitListAPIProvider>().unitListResponseModel == null) {
      context.read<UnitListAPIProvider>().fetchUnit();
    }

    if (context.read<ListGoodTypeAPIProvider>().goodsTypeResponseModel ==
        null) {
      context.read<ListGoodTypeAPIProvider>().fetchData().whenComplete(() {
        selectedGoodTye = List.generate(
            context
                .read<ListGoodTypeAPIProvider>()
                .goodsTypeResponseModel!
                .categoryList!
                .length,
            (index) => false);
        textEditingController = List.generate(
            context
                .read<ListGoodTypeAPIProvider>()
                .goodsTypeResponseModel!
                .categoryList!
                .length,
            (index) => TextEditingController());
        selectedUnit = List.generate(
            context
                .read<ListGoodTypeAPIProvider>()
                .goodsTypeResponseModel!
                .categoryList!
                .length,
            (index) => null);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: appBar(),
      body: body(),
    );
  }

  appBar() {
    return AppBar(
      title: SafeArea(
        child: Text(
          "Select your goods ",
          style: CommonStyles.blackText17BoldW500(),
        ),
      ),
    );
  }

  body() {
    final goodTypeAPIProvider = Provider.of<ListGoodTypeAPIProvider>(context);
    if (goodTypeAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 300,
        width: deviceWidth(context),
      );
    } else if (goodTypeAPIProvider.error) {
      print("------error ----------------");
      return SizedBox(
        height: 300,
        width: deviceWidth(context),
        child: Utils.showErrorMessage(goodTypeAPIProvider.errorMessage),
      );
    } else if (goodTypeAPIProvider.goodsTypeResponseModel != null &&
        goodTypeAPIProvider.goodsTypeResponseModel!.status! == "0") {
      return Utils.showErrorMessage(
          goodTypeAPIProvider.goodsTypeResponseModel!.message!);
    } else {
      final listCategory =
          goodTypeAPIProvider.goodsTypeResponseModel!.categoryList!;
      return SafeArea(
        child: Column(
          children: [
            Utils.getSizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: Colors.brown[900],
                    )),
                Utils.getSizedBox(width: 15),
                Text(
                  "Select your goods type",
                  style: CommonStyles.blackText17BoldW500(),
                ),
              ],
            ),
            Utils.getSizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "You can select multiple types and give estimated weight,\n This will help us to charge you fair amount.",
                    style: CommonStyles.black10thin(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Utils.getSizedBox(height: 20),
            Expanded(
              // margin: const EdgeInsets.only(top: 0),
              child: ListView.builder(
                  itemCount: listCategory.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return InkWell(
                        onTap: () async {
                          /*  final result = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              builder: (context) {
                                return SelectUnitGoods(
                                  selectedIndex: index,
                                );
                              });
                          if (result != null) {
                            // selectedIndex = result['si'];
                            if (result['si'] == index) {
                              for (int i = 0; i < selectedGoodTye.length; i++) {
                                if (i == result['si']) {
                                  selectedGoodTye[result['si']] = false;
                                }
                                print("selected Good type " +
                                    index.toString() +
                                    selectedGoodTye[i].toString());
                              }
                              selectedGoodTye[result['si']] = true;
                              selectedUnit[result['si']] = result['su'];
                              print(selectedGoodTye[result['si']].toString() +
                                  "------" +
                                  selectedUnit[result['si']]!.units!);
                            }
                          } else {
                            for (int i = 0; i < selectedGoodTye.length; i++) {
                              // selectedGoodTye[index] = false;
                              // selectedUnit[index] = result['su'];
                            }
                          }
                          setState(() {});*/
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 0),
                                child: ListViewGoodTypeWidget(
                                  isSelected: selectedGoodTye[index],
                                  categoryList: listCategory[index],
                                  index: index,
                                  key: UniqueKey(),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ));
                  })),
            ),
            Utils.getSizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.blue[900],
                  height: 40,
                  onPressed: () {
                    print("any element ----=" +
                        selectedGoodTye.any((element) => true).toString());
                    if (selectedGoodTye.any((element) => true)) {
                      final selInd = selectedGoodTye
                          .indexWhere((element) => element == true);
                      Map<String, dynamic> map = {
                        'goodtype': listCategory[selInd].categoryName,
                        'unit': textEditingController[selInd].text,
                        'properUnit': selectedUnit[selInd]!.units!,
                      };
                      Navigator.of(context).pop(map);
                    } else {
                      Utils.showSnackBar(
                          context: context,
                          text: "Atleast one selection mandatory");
                    }
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) {
                    //       return Verify30PercentPayment(
                    //         toLatitude: widget.toLatitude,
                    //         toLongitude: widget.toLongitude,
                    //         toAddress: widget.toAddress,
                    //         vehicleList: widget.vehicleList,
                    //       );
                    //     });
                    // Navigator.of(context).pop(selectedIndex);
                  },
                  child: Center(
                    child: Text(
                      " Update ",
                      style: CommonStyles.whiteText12BoldW500(),
                    ),
                  )),
            )
          ],
        ),
      );
    }
  }

  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String? _selectedLocation; // Option 2
  UnitList? _selectedUnit;
  TextEditingController quanitytController = TextEditingController();
  final quantityKey = GlobalKey<FormState>();

  Widget listViewGoodType(CategoryList categoryList, int index) {
    String selectedKg = "";
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: selectedGoodTye[index] ? 80 : 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryList.categoryName!,
                  style: CommonStyles.black13thin(),
                ),
                Visibility(
                    visible: selectedGoodTye[index],
                    child: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ))
              ],
            ),
            Visibility(
                visible: selectedGoodTye[index],
                child: Row(
                  children: [
                    Text(
                      "Quantity :",
                      style: CommonStyles.black1154(),
                    ),
                    Text(
                      textEditingController[index].text,
                      style: CommonStyles.black1654thin(),
                    ),
                    //  selectedUnit[index] == null
                    //       ? ""
                    //       : selectedUnit[index]!.units!
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ListViewGoodTypeWidget extends StatefulWidget {
  const ListViewGoodTypeWidget(
      {Key? key,
      required this.isSelected,
      required this.categoryList,
      required this.index})
      : super(key: key);
  final bool isSelected;
  final int index;

  final CategoryList categoryList;

  @override
  _ListViewGoodTypeWidgetState createState() => _ListViewGoodTypeWidgetState();
}

class _ListViewGoodTypeWidgetState extends State<ListViewGoodTypeWidget> {
  TextEditingController quanitytController = TextEditingController();
  final quantityKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("widget is selected  +" + widget.isSelected.toString());

    return SizedBox(
      key: widget.key,
      width: 250,
      // duration: const Duration(milliseconds: 400),
      // decoration:
      //     BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
      height: selectedGoodTye[widget.index] == true ? 70 : 40,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.categoryList.categoryName!,
                  style: CommonStyles.black13thin(),
                ),
                if (selectedGoodTye[widget.index] == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedGoodTye[widget.index] = false;
                          });
                        },
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 26,
                        )),
                  ),
              ],
            ),
            Visibility(
                visible: selectedGoodTye[widget.index] == true,
                child: Row(
                  children: [
                    Text(
                      "Quantity :  ",
                      style: CommonStyles.black1154(),
                    ),
                    Text(
                      // "",
                      textEditingController[widget.index].text,
                      style: CommonStyles.black1654thin(),
                    ),
                    Text(
                      // "",
                      selectedUnit[widget.index] == null
                          ? ""
                          : selectedUnit[widget.index]!.units!,
                      style: CommonStyles.black1654thin(),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class SelectUnitGoods extends StatefulWidget {
  const SelectUnitGoods({Key? key, required this.selectedIndex})
      : super(key: key);
  final int selectedIndex;
  @override
  _SelectUnitGoodsState createState() => _SelectUnitGoodsState();
}

class _SelectUnitGoodsState extends State<SelectUnitGoods> {
  UnitList? _selectedUnit;
  TextEditingController quanitytController = TextEditingController();
  final quantityKey = GlobalKey<FormState>();
  bool _unitWarning = false;

  @override
  Widget build(BuildContext context) {
    return pickUnit(selectedIndex: selectedIndex);
  }

  Widget pickUnit({required int selectedIndex}) {
    final unitListAPIProvider = Provider.of<UnitListAPIProvider>(context);

    if (unitListAPIProvider.ifLoading) {
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 300,
        width: 300,
      );
    } else if (unitListAPIProvider.error) {
      print("------error ----------------");
      return SizedBox(
        height: 300,
        width: 300,
        child: Utils.showErrorMessage(unitListAPIProvider.errorMessage),
      );
    } else if (unitListAPIProvider.unitListResponseModel != null &&
        unitListAPIProvider.unitListResponseModel!.status! == "0") {
      return Utils.showErrorMessage(
          unitListAPIProvider.unitListResponseModel!.message!);
    }
    final list = unitListAPIProvider.unitListResponseModel!.unitList!;

    return Builder(builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Goods quantity",
                  style: CommonStyles.black25thin(),
                ),
              ),
              Utils.getSizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: quantityKey,
                        child: TextFormField(
                          onTap: () {
                            FocusNode().requestFocus();
                          },
                          cursorColor: Colors.black,
                          controller:
                              textEditingController[widget.selectedIndex],
                          readOnly: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Valid Quantity";
                            }
                            return null;
                          },
                          // keyboardType: TextInputType.multiline,
                          style: CommonStyles.black13thin(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.all(17),
                            isDense: true,
                            labelText: ' Enter quantity',
                            hintText: 'E.g.  10 KG',
                            labelStyle: CommonStyles.black10thin(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 1.0, bottom: 1.0, left: 10, right: 10),
                          child: DropdownButton<UnitList>(
                            underline: const SizedBox(),
                            hint: Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, bottom: 2.0, left: 5, right: 5),
                              child: SizedBox(
                                  width: deviceWidth(context) * 0.2,
                                  child: Text('Unit',
                                      style: CommonStyles.black12())),
                            ), // Not necessary for Option 1
                            value: _selectedUnit ??
                                selectedUnit[widget.selectedIndex],

                            onChanged: (newValue) {
                              _selectedUnit = newValue;
                              // selectedUnit[widget.selectedIndex] = newValue!;

                              setState(() {});
                            },
                            items: list.map((location) {
                              return DropdownMenuItem(
                                child: Text(location.units!,
                                    style: CommonStyles.black12()),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                  visible: _unitWarning,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Please select unit', style: CommonStyles.red12())
                    ],
                  )),
              Utils.getSizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.blue[900],
                    height: 40,
                    onPressed: () {
                      // showModalBottomSheet(
                      //     context: context,
                      //     builder: (context) {
                      //       return Verify30PercentPayment(
                      //         toLatitude: widget.toLatitude,
                      //         toLongitude: widget.toLongitude,
                      //         toAddress: widget.toAddress,
                      //         vehicleList: widget.vehicleList,
                      //       );
                      //     });
                      final map = {
                        'si': widget.selectedIndex,
                        'su': _selectedUnit
                      };
                      print(_selectedUnit != null);
                      if (quantityKey.currentState!.validate() &&
                          _selectedUnit != null) {
                        Navigator.of(context).pop(map);
                      } else if (_selectedUnit == null) {
                        setState(() {
                          _unitWarning = true;
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        "Select Quantity",
                        style: CommonStyles.whiteText12BoldW500(),
                      ),
                    )),
              )
            ],
          ),
        ),
      );
    });
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

class Model {
  late String address;
  late double lat;
  late double long;
  late Color color;
  //Other fields if needed....
  Model(this.address, this.color);
//initialise other fields so on....
}

class Verify30PercentPayment extends StatefulWidget {
  Verify30PercentPayment(
      {Key? key,
      required this.fromLat,
      required this.fromLong,
      required this.toLatitude,
      required this.toLongitude,
      this.stop1Lat,
      this.stop1Long,
      this.stop2Lat,
      this.stop2Long,
      this.stop3Lat,
      this.stop3Long,
      this.stop1Address,
      this.stop2Address,
      this.stop3Address,
      required this.fromAddress,
      required this.toAddress,
      required this.pickupContactName,
      required this.pickupContactPhone,
      required this.vehicleList,
      required this.vehicleSelectedIndex,
      required this.toPayAmount})
      : super(key: key);

  final double fromLat, fromLong, toLatitude, toLongitude;
  double? stop1Lat, stop1Long, stop2Lat, stop2Long, stop3Lat, stop3Long;
  final String fromAddress, toAddress, pickupContactName, pickupContactPhone;
  final VehicleList vehicleList;
  final int vehicleSelectedIndex;
  final String toPayAmount;
  String? stop1Address, stop2Address, stop3Address;

  @override
  _Verify30PercentPaymentState createState() => _Verify30PercentPaymentState();
}

class _Verify30PercentPaymentState extends State<Verify30PercentPayment>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late Razorpay _razorpay;

  var options = {
    'key': 'rzp_test_sLmKDw4eKBuFZf',
    'amount': 233, //in the smallest currency sub-unit.
    "currency": "INR",
    "amount_paid": 0,
    "amount_due": 233.3,
    'name': 'Close To Buy',
    'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Paneer Tikka with Extra Rice',
    'timeout': 60, // in seconds
    'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
  };

/*  Timer? _timer;
  int _start = 240;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }*/

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCirc));

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // startTimer();

    super.initState();

    // list.add(Model("Vijayawada", Colors.blue));
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future openCheckout() async {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context, listen: false);
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': getPriceFromPercentage(
                  vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!
                      .vehicleList![widget.vehicleSelectedIndex].totalPrice!,
                  30)
              .toStringAsFixed(2) *
          100,
      'name': 'ANK Speed',
      'description': 'Vehicle Boking',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  bool _paymentCompleted = false;

  buildPaymentFuture() async {
    String categoryId = "", categoryQuantity = "";

    final goodTypeAPIProvider =
        Provider.of<ListGoodTypeAPIProvider>(context, listen: false);

    for (int i = 0; i < selectedGoodTye.length; i++) {
      if (selectedGoodTye[i]) {
        categoryId +=
            goodTypeAPIProvider.goodsTypeResponseModel!.categoryList![i].id! +
                ",";
        categoryQuantity +=
            textEditingController[i].text + " " + selectedUnit[i]!.units! + ",";
      }
    }

    Random rand = Random(12);
    await _animationController.forward();
    Utils.showBookingVehicle(context);

    if (widget.stop1Lat == null &&
        widget.stop2Lat == null &&
        widget.stop3Lat == null) {
      final bookVehicleRequestModel = BookVehicleRequestModel(
          paidAmt: "0",
          rideTime: "12-07-2022",
          timeState: "1",
          vehicleCharge: widget.vehicleList.vehiclePrice!,
          customerName: widget.pickupContactName,
          distance: widget.vehicleList.totalKm!,
          duration: widget.vehicleList.time!,
          fromAddress: widget.fromAddress,
          fromLat: widget.fromLat.toString(),
          fromLong: widget.fromLong.toString(),
          labourQuantity: widget.vehicleList.labour!,
          labourPrice: widget.vehicleList.labourTotal!,
          categoryId: categoryId,
          categoryQuantity: categoryQuantity,
          gst: widget.vehicleList.gst!,
          statePrice: widget.vehicleList.outerCharge!,
          stateStatus: widget.vehicleList.outerState!,
          customerMobile: widget.pickupContactPhone,
          toAddress: widget.toAddress,
          toLat: widget.toLatitude.toString(),
          toLong: widget.toLongitude.toString(),
          total: widget.vehicleList.totalPrice!,
          transactionId: "xyzsdfasdf" + rand.nextInt(2000).toString(),
          userId: ApiServices.userId!,
          vehicleTypeId: widget.vehicleList.id!,
          toMobile: widget.pickupContactPhone,
          toName: widget.pickupContactName,
          couponCode: "jdhf",
          discountAmt: "34");
      await context
          .read<BookVehicleAPIProvider>()
          .fetchData(bookVehicleRequestModel: bookVehicleRequestModel)
          .then((value) {
        // showAboutDialog(context: context)
        Utils.bookingSuccess(context);
        context.read<OrderHistoryAPIProvider>().getOrders();
      });
    } else if (widget.stop1Lat != null &&
        widget.stop2Lat == null &&
        widget.stop3Lat == null) {
      final bookVehicleRequestModel = BookVehicleRequestModel(
          paidAmt: "0",
          rideTime: "12-07-2022",
          timeState: "1",
          vehicleCharge: widget.vehicleList.vehiclePrice!,
          customerName: widget.pickupContactName,
          distance: widget.vehicleList.totalKm!,
          duration: widget.vehicleList.time!,
          fromAddress: widget.fromAddress,
          fromLat: widget.fromLat.toString(),
          fromLong: widget.fromLong.toString(),
          labourQuantity: widget.vehicleList.labour!,
          labourPrice: widget.vehicleList.labourTotal!,
          categoryId: categoryId,
          categoryQuantity: categoryQuantity,
          gst: widget.vehicleList.gst!,
          statePrice: widget.vehicleList.outerCharge!,
          stateStatus: widget.vehicleList.outerState!,
          customerMobile: widget.pickupContactPhone,
          toAddress: "₹${widget.stop1Address}₹${widget.toAddress}",
          toLat: "₹${widget.stop1Lat}₹${widget.toLatitude}".toString(),
          toLong: "₹${widget.stop1Long}₹${widget.toLongitude}".toString(),
          total: widget.vehicleList.totalPrice!,
          transactionId: "xyzsdfasdf" + rand.nextInt(2000).toString(),
          userId: ApiServices.userId!,
          vehicleTypeId: widget.vehicleList.id!,
          toName: "₹${widget.pickupContactName}₹${widget.pickupContactName}",
          toMobile:
              "₹${widget.pickupContactPhone}₹${widget.pickupContactPhone}",
          couponCode: "jdhf",
          discountAmt: "34");
      await context
          .read<BookVehicleAPIProvider>()
          .fetchData(bookVehicleRequestModel: bookVehicleRequestModel)
          .then((value) {
        // showAboutDialog(context: context)
        Utils.bookingSuccess(context);
        context.read<OrderHistoryAPIProvider>().getOrders();
      });
    } else if (widget.stop1Lat != null &&
        widget.stop2Lat != null &&
        widget.stop3Lat != null &&
        widget.toLatitude != null) {
      final bookVehicleRequestModel = BookVehicleRequestModel(
          paidAmt: "0",
          rideTime: "12-07-2022",
          timeState: "1",
          vehicleCharge: widget.vehicleList.vehiclePrice!,
          customerName: widget.pickupContactName,
          toName:
              "₹${widget.pickupContactName}₹${widget.pickupContactName}₹${widget.pickupContactName}",
          distance: widget.vehicleList.totalKm!,
          duration: widget.vehicleList.time!,
          fromAddress: widget.fromAddress,
          fromLat: widget.fromLat.toString(),
          fromLong: widget.fromLong.toString(),
          labourQuantity: widget.vehicleList.labour!,
          labourPrice: widget.vehicleList.labourTotal!,
          categoryId: categoryId,
          categoryQuantity: categoryQuantity,
          gst: widget.vehicleList.gst!,
          statePrice: widget.vehicleList.outerCharge!,
          stateStatus: widget.vehicleList.outerState!,
          customerMobile: widget.pickupContactPhone,
          toMobile:
              "₹${widget.pickupContactPhone}₹${widget.pickupContactPhone}₹${widget.pickupContactPhone}",
          toAddress:
              "₹${widget.stop1Address}₹${widget.stop2Address}₹${widget.toAddress}",
          toLat: "₹${widget.stop1Lat}₹${widget.stop2Lat}₹${widget.toLatitude}"
              .toString(),
          toLong:
              "₹${widget.stop1Long}₹${widget.stop2Long}₹${widget.toLongitude}"
                  .toString(),
          total: widget.vehicleList.totalPrice!,
          transactionId: "xyzsdfasdf" + rand.nextInt(2000).toString(),
          userId: ApiServices.userId!,
          vehicleTypeId: widget.vehicleList.id!,
          couponCode: "jdhf",
          discountAmt: "34");
      await context
          .read<BookVehicleAPIProvider>()
          .fetchData(bookVehicleRequestModel: bookVehicleRequestModel)
          .then((value) {
        // showAboutDialog(context: context)
        Utils.bookingSuccess(context);
        context.read<OrderHistoryAPIProvider>().getOrders();
      });
    } else if (widget.stop1Lat != null &&
        widget.stop2Lat != null &&
        widget.stop3Lat == null) {
      final bookVehicleRequestModel = BookVehicleRequestModel(
          paidAmt: "0",
          rideTime: "12-07-2022",
          timeState: "1",
          vehicleCharge: widget.vehicleList.vehiclePrice!,
          customerName: widget.pickupContactName,
          toName:
              "₹${widget.pickupContactName}₹${widget.pickupContactName}₹${widget.pickupContactName}₹${widget.pickupContactName}",
          distance: widget.vehicleList.totalKm!,
          duration: widget.vehicleList.time!,
          fromAddress: widget.fromAddress,
          fromLat: widget.fromLat.toString(),
          fromLong: widget.fromLong.toString(),
          labourQuantity: widget.vehicleList.labour!,
          labourPrice: widget.vehicleList.labourTotal!,
          categoryId: categoryId,
          categoryQuantity: categoryQuantity,
          gst: widget.vehicleList.gst!,
          statePrice: widget.vehicleList.outerCharge!,
          stateStatus: widget.vehicleList.outerState!,
          customerMobile: widget.pickupContactPhone,
          toMobile:
              "₹${widget.pickupContactPhone}₹${widget.pickupContactPhone}₹${widget.pickupContactPhone}₹${widget.pickupContactPhone}",
          toAddress:
              "₹${widget.stop1Address}₹${widget.stop2Address}₹${widget.stop3Address}₹${widget.toAddress}",
          toLat:
              "₹${widget.stop1Lat}₹${widget.stop2Lat}₹${widget.stop3Lat}₹${widget.toLatitude}"
                  .toString(),
          toLong:
              "₹${widget.stop1Long}₹${widget.stop2Long}₹${widget.stop3Long}₹${widget.toLongitude}"
                  .toString(),
          total: widget.vehicleList.totalPrice!,
          transactionId: "xyzsdfasdf" + rand.nextInt(2000).toString(),
          userId: ApiServices.userId!,
          vehicleTypeId: widget.vehicleList.id!,
          couponCode: "jdhf",
          discountAmt: "34");
      await context
          .read<BookVehicleAPIProvider>()
          .fetchData(bookVehicleRequestModel: bookVehicleRequestModel)
          .then((value) {
        // showAboutDialog(context: context)
        Utils.bookingSuccess(context);
        context.read<OrderHistoryAPIProvider>().getOrders();
      });
    }
    //  openCheckout().whenComplete(() async {

    //  });
  }

  // void addNew() {
  //   setState(() {
  //     list.add(Model("Karnool", Colors.black));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price Deatails for your trip",
            style: CommonStyles.blue14900(),
          ),
          Utils.getSizedBox(height: 20),
          showBillScreen(),
          Utils.getSizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.blue[900],
                  height: 40,
                  onPressed: () async {
                    await buildPaymentFuture();

                    /*  Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookingSuccessfull()));*/
                  },
                  child: Row(
                    children: [
                      Text(
                        "Cash  ",
                        style: CommonStyles.whiteText12BoldW500(),
                      ),
                      Icon(
                        Icons.money,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.blue[900],
                  height: 40,
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        "Cupon  ",
                        style: CommonStyles.whiteText12BoldW500(),
                      ),
                      Icon(
                        Icons.local_offer_outlined,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.blue[900],
                    height: 40,
                    onPressed: () async {
                      await buildPaymentFuture();

                      print("Date Time --------" +
                          DateTime.now().toLocal().toString());
                      print("Date Time --------" +
                          DateTime.now().isUtc.toString());

                      await context.read<OrderHistoryAPIProvider>().getOrders();

                      /*context
                          .read<CabBookingAPIProvider>()
                          .cabBookingModel!
                          .status ==
                          "1"
                          ? showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Utils.showSnackBar(
                                          context: context,
                                          text:
                                          "Your Booking is Processing ...");
                                    },
                                    child: AvatarGlow(
                                      endRadius: 120,
                                      glowColor: Colors.green,
                                      child: Image.asset(
                                        "assets/waiting.gif",
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Waiting for Driver Response",
                                        style: CommonStyles.blue14900(),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: Card(
                                          color: Colors.red,
                                          elevation: 10,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 30),
                                            child: Text(
                                              "Cancel",
                                              style: CommonStyles
                                                  .whiteText15BoldW500(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          })
                          : Utils.showSnackBar(
                          context: context, text: "Vehicle not Booking...");*/
                    },
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          makePayment();
                        },
                        child: Row(
                          children: [
                            Text(
                              /*widget.type == "2"
                                  ?*/
                              //  "/*Make Payment of ₹ ${getPriceFromPercentage(vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.vehicleList![widget.vehicleSelectedIndex].totalPrice!, 30).toStringAsFixed(2)}"*/
                              // : "Confirm Booking",
                              "Online",

                              style: CommonStyles.whiteText12BoldW500(),
                            ),
                            Icon(
                              Icons.paypal,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );

    // Scaffold(
    //     appBar: AppBar(
    //         backgroundColor: Colors.black,
    //         title:
    //             Text('Custom Stepper', style: TextStyle(color: Colors.white)),
    //         actions: [
    //           IconButton(
    //               icon: Icon(Icons.add_circle, color: Colors.white),
    //               onPressed: addNew)
    //         ]),
    //     body:

    //     );
  }

  makePayment() {
    //Replace with actual values
    String orderId = "ORDER_ID";
    String stage = "PROD";
    String orderAmount = "ORDER_AMOUNT";
    String tokenData = "TOKEN_DATA";
    String customerName = "Customer Name";
    String orderNote = "Order_Note";
    String orderCurrency = "INR";
    String appId = "APP_ID";
    String customerPhone = "Customer Phone";
    String customerEmail = "sample@gmail.com";
    String notifyUrl = "https://test.gocashfree.com/notify";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl
    };

    CashfreePGSDK.doPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }

  double getPriceFromPercentage(String price, int percentage) {
    return ((double.parse(price) * percentage.toDouble()) / 100);
  }

  showBillScreen() {
    final vehicleCategoriesAPIProvider =
        Provider.of<VehicleCategoriesAPIProvider>(context, listen: false);
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Vehicle Charges (${vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.vehicleList![widget.vehicleSelectedIndex].totalKm})",
            style: CommonStyles.black13thin(),
          ),
          Text(
            "₹ " +
                vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!
                    .vehicleList![widget.vehicleSelectedIndex].vehiclePrice!,
            style: CommonStyles.blue14900(),
          ),
        ],
      ),
      Utils.getSizedBox(height: 10),
      Visibility(
        visible: vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!
                    .vehicleList![widget.vehicleSelectedIndex].labourQty !=
                "0" &&
            vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!
                    .vehicleList![widget.vehicleSelectedIndex].labourQty !=
                null,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Helper Charges (${vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.vehicleList![widget.vehicleSelectedIndex].labourQty} Helpers)",
                  style: CommonStyles.black13thin(),
                ),
                Text(
                  "₹ " +
                      vehicleCategoriesAPIProvider
                          .vehicleCategoriesResponseModel!
                          .vehicleList![widget.vehicleSelectedIndex]
                          .labourTotal!,
                  style: CommonStyles.blue14900(),
                ),
              ],
            ),
            Utils.getSizedBox(height: 10),
          ],
        ),
      ),
      Visibility(
        visible: vehicleCategoriesAPIProvider
                .vehicleCategoriesResponseModel!.outerState !=
            "0",
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Outstation Charges",
                  style: CommonStyles.black13thin(),
                ),
                Text(
                  "₹ " +
                      vehicleCategoriesAPIProvider
                          .vehicleCategoriesResponseModel!
                          .vehicleList![widget.vehicleSelectedIndex]
                          .outerCharge!,
                  style: CommonStyles.blue14900(),
                ),
              ],
            ),
            Utils.getSizedBox(height: 10),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Gst Tax (${vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.vehicleList![widget.vehicleSelectedIndex].gst} %)",
            style: CommonStyles.black13thin(),
          ),
          Text(
            "₹ " +
                (double.parse(vehicleCategoriesAPIProvider
                            .vehicleCategoriesResponseModel!
                            .vehicleList![widget.vehicleSelectedIndex]
                            .totalPrice!) -
                        double.parse(vehicleCategoriesAPIProvider
                            .vehicleCategoriesResponseModel!
                            .vehicleList![widget.vehicleSelectedIndex]
                            .withoutGst!))
                    .toStringAsFixed(2),
            style: CommonStyles.blue14900(),
          ),
        ],
      ),
      Utils.getSizedBox(height: 10),
      _buildDivider(),
      Utils.getSizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Total to Pay", style: CommonStyles.black13thin()),
          Text(
              "₹ "
              "${vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.vehicleList![widget.vehicleSelectedIndex].totalPrice}",
              style: CommonStyles.blue14900())
        ],
      ),
      Utils.getSizedBox(height: 10),
      /*    Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
                "*Waiting Charges (Only applicable when loading and unloading time exceeds 2 hrs) "
                "₹ ${vehicleCategoriesAPIProvider.vehicleCategoriesResponseModel!.waitingCharge}.",
                maxLines: 3,
                style: CommonStyles.blackw54s9Thin()),
          ),
        ],
      ),*/
    ]);
  }

  CustomDividerView _buildDivider() => CustomDividerView(
        dividerHeight: 1.0,
        color: Colors.grey[400],
      );

  String getGstPercerntage(double percentage, String amount) {
    return ((double.parse(amount) * percentage) / 100).toString();
  }
}

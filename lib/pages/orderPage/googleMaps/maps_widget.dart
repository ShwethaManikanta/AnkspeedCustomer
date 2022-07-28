import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:new_ank_customer/Services/apiProvider/order_history_api_provider.dart';
import 'package:new_ank_customer/Services/apiProvider/order_specific_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'dart:async';
import '../../../common/common_styles.dart';
import '../../../common/utils.dart';
import '../../orderPage/googleMaps/model/pin_pill_info.dart';
import '../../orderPage/maps_provider.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

// const LatLng SOURCE_LOCATION = LatLng(13.043410938786145, 77.57266403919914);

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.orderId}) : super(key: key);
  final int orderId;
  // final LatLng sourceLocation;

  // final LatLng destinationLocation;
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> with TickerProviderStateMixin {
  Timer? timer;

  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = <Marker>{};
  Map<PolylineId, Polyline> polylines = {};

// for my drawn routes on the map
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  String googleAPIKey = "AIzaSyCoCUX3aEbxcwud60ocZ-XcA7D4Ac-aNXE";
// for my custom marker pins
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  late BitmapDescriptor liveLocationIcon;

  double pinPillPosition = 0;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: const LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  late PinInformation sourcePinInfo;
  late PinInformation destinationPinInfo;
  late PinInformation liveLocationPinInfo;

  @override
  void initState() {
    super.initState();

    polylinePoints = PolylinePoints();

    // set custom marker pins
    setSourceAndDestinationIcons();
    trackDriverLocation();
  }

  trackDriverLocation() {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context, listen: false);

    // print(widget.sourceLocation.latitude.toString() +
    //     "----" +
    //     widget.sourceLocation.longitude.toString() +
    //     "------" +
    //     widget.destinationLocation.latitude.toString() +
    //     "--------" +
    //     widget.destinationLocation.longitude.toString());
    if (mounted) {
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          apiServices
              .trackOrder(
                  orderId: orderHistoryAPIProvider
                      .orderHistoryResponse!.orderHistory![widget.orderId].id!)
              .then((value) {
            print("the location track value" + value!.status.toString());

            print("Track Status ----------" + value.status!);
            if (value.status == "1" &&
                value.trackDetails != null &&
                orderHistoryAPIProvider.orderHistoryResponse!
                        .orderHistory![widget.orderId].orderStatus !=
                    "3" &&
                orderHistoryAPIProvider.orderHistoryResponse!
                        .orderHistory![widget.orderId].orderStatus !=
                    "2") {
              print("Track Lat " + value.trackDetails!.lat!);
              print("Track lng " + value.trackDetails!.long!);
              updatePinOnMap(
                  latitude: value.trackDetails!.lat!,
                  longitude: value.trackDetails!.long!,
                  heading: value.trackDetails!.heading!);

              // fromCoordinates = LatLng(double.parse(value.trackDetails!.lat!),
              //     double.parse(value.trackDetails!.long!));
              // toCoordinates = LatLng(
              //     double.parse(orderHistoryAPIProvider
              //         .orderHistoryResponse!
              //         .orderHistory![int.parse(widget.orderId)]
              //         .tripDetails!
              //         .fromLat!),
              //     double.parse(orderHistoryAPIProvider
              //         .orderHistoryResponse!
              //         .orderHistory![int.parse(widget.orderId)]
              //         .tripDetails!
              //         .fromLat!));
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), 'assets/source.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), 'assets/des1.png');

    liveLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/driving_pin.png');
  }

  void updatePinOnMap(
      {required String latitude,
      required String longitude,
      required String heading}) async {
    // LatLng latLng = LatLng(double.parse(latitude), double.parse(longitude));

    var pinPosition = LatLng(double.parse(latitude), double.parse(longitude));
    _markers.add(Marker(
        markerId: const MarkerId('driverLiveLocation'),
        position: pinPosition,
        //  rotation: double.parse(heading),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: liveLocationIcon));

    // _markers.add(Marker(
    //     markerId: const MarkerId('driverLiveLocation'),
    //     position: pinPosition, // updated position
    //     icon: liveLocationIcon));
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(double.parse(latitude), double.parse(longitude)),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    // setState(() {
    // updated position
    // var pinPosition = LatLng(double.parse(latitude), double.parse(longitude));

    // the trick is to remove the marker (by id)
    // and add it again at the updated location
    // _markers.removeWhere((m) => m.markerId.value == 'destPin');
    // _markers.add(Marker(
    //     markerId: const MarkerId('destPin'),
    //     position: pinPosition, // updated position
    //     icon: destinationIcon));
    // });
  }

  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);

    if (orderHistoryAPIProvider
            .orderHistoryResponse!.orderHistory![widget.orderId].orderStatus ==
        "1") {
      return Center(
          child: SizedBox(
              height: 200,
              width: deviceWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoadingRotating.square(
                    borderSize: 10,
                  ),
                  Utils.getSizedBox(height: 40),
                  Text(
                    'Waiting for Driver Response',
                    style: CommonStyles.black1254thin(),
                  )
                ],
              )));
    } else if (orderHistoryAPIProvider
            .orderHistoryResponse!.orderHistory![widget.orderId].orderStatus ==
        "2") {
      return Center(
          child: SizedBox(
              height: 200,
              width: deviceWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.brown,
                  ),
                  Utils.getSizedBox(height: 40),
                  Text(
                    'Order Cancelled!',
                    style: CommonStyles.black1254thin(),
                  )
                ],
              )));
    } else if (orderHistoryAPIProvider
            .orderHistoryResponse!.orderHistory![widget.orderId].orderStatus ==
        "3") {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 200,
              width: deviceWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.done_all_sharp,
                    color: Colors.brown,
                  ),
                  Utils.getSizedBox(height: 40),
                  Text(
                    'Yahoo!! Order Completed!!! 🥳',
                    style: CommonStyles.black1254thin(),
                  )
                ],
              )),
        ],
      ));
    } else {
      return googleMapsBody();
    }

    // return Center(
    //       child: SizedBox(
    //           height: 200,
    //           width: deviceWidth(context),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               const Icon(
    //                 Icons.done_all_sharp,
    //                 color: Colors.brown,
    //               ),
    //               Utils.getSizedBox(height: 40),
    //               Text(
    //                 'Waiting for Driver Response',
    //                 style: CommonStyles.black1254thin(),
    //               )
    //             ],
    //           )));
    // if (fromCoordinates == null || toCoordinates == null) {
    //   return Center(
    //       child: SizedBox(
    //           height: 200,
    //           width: deviceWidth(context),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               LoadingRotating.square(
    //                 borderSize: 10,
    //               ),
    //               Utils.getSizedBox(height: 40),
    //               Text(
    //                 'Waiting for Driver Response',
    //                 style: CommonStyles.black1254thin(),
    //               )
    //             ],
    //           )));
    // } else {
    // }
  }

  googleMapsBody() {
    final mapsApiProvider = Provider.of<ViewDetailsMapProvider>(context);
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context);
    LatLng initialTarget = LatLng(
        double.parse(orderHistoryAPIProvider.orderHistoryResponse!
            .orderHistory![widget.orderId].tripDetails!.toLat!),
        double.parse(orderHistoryAPIProvider.orderHistoryResponse!
            .orderHistory![widget.orderId].tripDetails!.toLong!));

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: initialTarget);
    return Scaffold(
      body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: Set<Polyline>.of(polylines.values),
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          onTap: (LatLng loc) {
            pinPillPosition = -100;
          },
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(MapStyle.mapStyles);
            _controller.complete(controller);
            showPinsOnMap();
            mapsApiProvider.googleMapController = controller;

            // my map has completed being created;
            // i'm ready to show the pins on the map
          }),
    );
  }

  void showPinsOnMap() async {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProvider>(context, listen: false);
    // get a LatLng for the source location
    // from the LocationData currentLocation object

    if (orderHistoryAPIProvider
            .orderHistoryResponse!.orderHistory![widget.orderId].orderStatus ==
        "4") {
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.removeWhere((m) => m.markerId.value == 'destPin');

      var pinPosition = LatLng(
          double.parse(orderHistoryAPIProvider.orderHistoryResponse!
              .orderHistory![widget.orderId].tripDetails!.startLocationLat!),
          double.parse(orderHistoryAPIProvider.orderHistoryResponse!
              .orderHistory![widget.orderId].tripDetails!.startLocationLong!));
      // get a LatLng out of the LocationData object
      var destPosition =
          // LatLng(destinationLocation.latitude!, destinationLocation.longitude!);
          LatLng(
              double.parse(orderHistoryAPIProvider.orderHistoryResponse!
                  .orderHistory![widget.orderId].tripDetails!.fromLat!),
              double.parse(orderHistoryAPIProvider.orderHistoryResponse!
                  .orderHistory![widget.orderId].tripDetails!.fromLong!));

      sourcePinInfo = PinInformation(
          locationName: "Start Location",
          location: pinPosition,
          pinPath: "assets/driving_pin.png",
          avatarPath: "assets/friend1.jpg",
          labelColor: Colors.blueAccent);

      destinationPinInfo = PinInformation(
          locationName: "End Location",
          location: destPosition,
          pinPath: "assets/destination_map_marker.png",
          avatarPath: "assets/friend2.jpg",
          labelColor: Colors.purple);

      // add the initial source location pin
      _markers.add(Marker(
          markerId: const MarkerId('sourcePin'),
          position: pinPosition,
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: const MarkerId('destPin'),
          position: destPosition,
          onTap: () {
            setState(() {
              currentlySelectedPin = destinationPinInfo;
              pinPillPosition = 0;
            });
          },
          icon: destinationIcon));

      double miny = (pinPosition.latitude <=
              // double.parse(selectedLocationDetails!.lat)
              destPosition.latitude)
          ? pinPosition.latitude
          : destPosition.latitude;
      // double.parse(selectedLocationDetails!.lat);
      double minx = (pinPosition.longitude <= destPosition.longitude)
          ? pinPosition.longitude
          : destPosition.longitude;
      double maxy = (pinPosition.latitude <= destPosition.latitude)
          ? destPosition.latitude
          : pinPosition.latitude;
      double maxx = (pinPosition.longitude <= pinPosition.longitude)
          ? destPosition.longitude
          : pinPosition.longitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      print(miny.toString() +
          "----" +
          minx.toString() +
          "----" +
          maxy.toString() +
          "----" +
          maxx.toString() +
          "----");
      final controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          50.0,
        ),
      );
      createPolylines(fromLatLong: pinPosition, toLatLong: destPosition);
    } else {
      var pinPosition = LatLng(
          double.parse(orderHistoryAPIProvider.orderHistoryResponse!
              .orderHistory![widget.orderId].tripDetails!.fromLat!),
          double.parse(orderHistoryAPIProvider.orderHistoryResponse!
              .orderHistory![widget.orderId].tripDetails!.fromLong!));
      // get a LatLng out of the LocationData object
      var destPosition =
          // LatLng(destinationLocation.latitude!, destinationLocation.longitude!);
          LatLng(
              double.parse(orderHistoryAPIProvider.orderHistoryResponse!
                  .orderHistory![widget.orderId].tripDetails!.toLat!),
              double.parse(orderHistoryAPIProvider.orderHistoryResponse!
                  .orderHistory![widget.orderId].tripDetails!.toLong!));

      sourcePinInfo = PinInformation(
          locationName: "Start Location",
          location: pinPosition,
          pinPath: "assets/driving_pin.png",
          avatarPath: "assets/friend1.jpg",
          labelColor: Colors.blueAccent);

      destinationPinInfo = PinInformation(
          locationName: "End Location",
          location: destPosition,
          pinPath: "assets/destination_map_marker.png",
          avatarPath: "assets/friend2.jpg",
          labelColor: Colors.purple);

      // add the initial source location pin
      _markers.add(Marker(
          markerId: const MarkerId('sourcePin'),
          position: pinPosition,
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: const MarkerId('destPin'),
          position: destPosition,
          onTap: () {
            setState(() {
              currentlySelectedPin = destinationPinInfo;
              pinPillPosition = 0;
            });
          },
          icon: destinationIcon));

      double miny = (pinPosition.latitude <=
              // double.parse(selectedLocationDetails!.lat)
              destPosition.latitude)
          ? pinPosition.latitude
          : destPosition.latitude;
      // double.parse(selectedLocationDetails!.lat);
      double minx = (pinPosition.longitude <= destPosition.longitude)
          ? pinPosition.longitude
          : destPosition.longitude;
      double maxy = (pinPosition.latitude <= destPosition.latitude)
          ? destPosition.latitude
          : pinPosition.latitude;
      double maxx = (pinPosition.longitude <= pinPosition.longitude)
          ? destPosition.longitude
          : pinPosition.longitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      print(miny.toString() +
          "----" +
          minx.toString() +
          "----" +
          maxy.toString() +
          "----" +
          maxx.toString() +
          "----");
      final controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          50.0,
        ),
      );
      createPolylines(fromLatLong: pinPosition, toLatLong: destPosition);
    }

    // double miny = (fromCoordinates!.latitude <=
    //         // double.parse(selectedLocationDetails!.lat)
    //         toCoordinates!.latitude)
    //     ? fromCoordinates!.latitude
    //     : toCoordinates!.latitude;
    // // double.parse(selectedLocationDetails!.lat);
    // double minx = (fromCoordinates!.longitude <=
    //        toCoordinates!.longitude)
    //     ? fromCoordinates!.longitude
    //     : toCoordinates!.longitude;
    // double maxy =
    //     (fromCoordinates!.latitude <= toCoordinates!.latitude)
    //         ?toCoordinates!.latitude
    //         :fromCoordinates.latitude;
    // double maxx = (widget.sourceLocation.longitude <=
    //         widget.destinationLocation.longitude)
    //     ? widget.destinationLocation.longitude
    //     : widget.sourceLocation.longitude;

    // double southWestLatitude = miny;
    // double southWestLongitude = minx;

    // double northEastLatitude = maxy;
    // double northEastLongitude = maxx;

    // print(miny.toString() +
    //     "----" +
    //     minx.toString() +
    //     "----" +
    //     maxy.toString() +
    //     "----" +
    //     maxx.toString() +
    //     "----");
    // final GoogleMapController controller = await _controller.future;

    // controller.animateCamera(
    //   CameraUpdate.newLatLngBounds(
    //     LatLngBounds(
    //       northeast: LatLng(northEastLatitude, northEastLongitude),
    //       southwest: LatLng(southWestLatitude, southWestLongitude),
    //     ),
    //     50.0,
    //   ),
    // );
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    // setPolylines();
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double totalDistance = 0;
  createPolylines(
      {required LatLng fromLatLong, required LatLng toLatLong}) async {
    totalDistance = 0;

    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDmAKO_2HdB8I4hVpTIN3DKYZO5xCXQ2ow", // Google Maps API Key
      PointLatLng(fromLatLong.latitude, fromLatLong.longitude),
      PointLatLng(toLatLong.latitude, toLatLong.longitude),
      travelMode: TravelMode.driving,
    );
    polylineCoordinates.clear();

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        print("point latitude   ---" + point.latitude.toString());
      }
    }

    //Calculate the distance between polylineCoordinate with is the selected coordinate.
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }

    // Defining an ID
    PolylineId id = PolylineId("PolyId");

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue[900]!,
      points: polylineCoordinates,
      width: 3,
    );
    // Adding the polyline to the map
    polylines[id] = polyline;
    setState(() {});
  }

// void setPolylines() async {
//   final pointLatLng = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPIKey,
//       PointLatLng(
//           widget.sourceLocation.latitude, widget.sourceLocation.longitude),
//       PointLatLng(
//         widget.destinationLocation.latitude,
//         widget.destinationLocation.longitude,
//       ));
//   final result = pointLatLng.points;
//   if (result.isNotEmpty) {
//     for (var point in result) {
//       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     }
//     setState(() {
//       _polylines.add(Polyline(
//           width: 5, // set the width of the polylines
//           polylineId: const PolylineId("poly"),
//           color: const Color.fromARGB(255, 40, 122, 198),
//           points: polylineCoordinates));
//     });
//   }
// }
}

class MapStyle {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}

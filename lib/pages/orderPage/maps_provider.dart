import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'googleMaps/model/pin_pill_info.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class ViewDetailsMapProvider with ChangeNotifier {
  //Google Maps Provider
  LatLng? fromLatLng;
  LatLng? toLatLng;

  late PolylinePoints polylinePoints;
  late GoogleMapController _googleMapController;
// List of coordinates to join
  List<LatLng> polylineCoordinates = [];
// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> _markers = {};
  late double totalDistance;
  late double _nearByRadiusDistanceInKM;
  // DatabaseService databaseService;
  // Stream<List<LocationDetails>> _locationDetailsStream;
  // List<LocationDetails> _locationDetailsList;

// for my custom marker pins
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;

  double pinPillPosition = 0;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: const LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  late PinInformation sourcePinInfo;
  late PinInformation destinationPinInfo;

  set nearByDistanceInKM(double radius) {
    _nearByRadiusDistanceInKM = radius;
    notifyListeners();
  }

  double get nearByDistanceInKM => _nearByRadiusDistanceInKM;

  int getShortDistance(double a, double b) {
    if (a < b) {
      return 0;
    }
    return 1;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Set<Marker> get markerSet => _markers;

  double get getTotalDistance => totalDistance;

  //Google Maps controller assigning to
  GoogleMapController get googleMapController => _googleMapController;

  set googleMapController(GoogleMapController controller) {
    _googleMapController = controller;
    notifyListeners();
  }

  // moveCameraToCurrentLocation() {
  //   _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           target: LatLng(currentPosition.latitude, currentPosition.longitude),
  //           zoom: 15.0)));
  // }

  //Make a route between source and destination place
  getDistance({required LatLng fromLoc, required LatLng toLoc}) {
    print(
        fromLoc.latitude.toString() + "---------" + toLoc.latitude.toString());
    double miny = (toLoc.latitude <= (fromLoc.latitude))
        ? toLoc.latitude
        : (fromLoc.latitude);
    double minx = (toLoc.longitude <= (fromLoc.longitude))
        ? toLoc.longitude
        : (fromLoc.longitude);
    double maxy = (toLoc.latitude <= (fromLoc.latitude))
        ? (fromLoc.latitude)
        : toLoc.latitude;
    double maxx = (toLoc.longitude <= (fromLoc.longitude))
        ? (fromLoc.longitude)
        : toLoc.longitude;

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

    googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        50.0,
      ),
    );
    // createPolylines(destinationLatitude, destinationLongitude)

    notifyListeners();
  }

  void showPinsOnMap() async {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(fromLatLng!.latitude, fromLatLng!.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
        // LatLng(destinationLocation.latitude!, destinationLocation.longitude!);
        LatLng(toLatLng!.latitude, toLatLng!.longitude);

    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: fromLatLng!,
        pinPath: "assets/images/srtLoc.png",
        avatarPath: "assets/friend1.jpg",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location",
        location: toLatLng!,
        pinPath: "assets/images/endLoc.png",
        avatarPath: "assets/friend2.jpg",
        labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          currentlySelectedPin = sourcePinInfo;
          pinPillPosition = 0;
        },
        icon: sourceIcon));
    // destination pin
    _markers.add(Marker(
        markerId: const MarkerId('destPin'),
        position: destPosition,
        onTap: () {
          currentlySelectedPin = destinationPinInfo;
          pinPillPosition = 0;
        },
        icon: destinationIcon));
    double miny = (fromLatLng!.latitude <=
            // double.parse(selectedLocationDetails!.lat)
            toLatLng!.latitude)
        ? fromLatLng!.latitude
        : toLatLng!.latitude;
    // double.parse(selectedLocationDetails!.lat);
    double minx = (fromLatLng!.longitude <= toLatLng!.longitude)
        ? fromLatLng!.longitude
        : toLatLng!.longitude;
    double maxy = (fromLatLng!.latitude <= toLatLng!.latitude)
        ? toLatLng!.latitude
        : fromLatLng!.latitude;
    double maxx = (fromLatLng!.longitude <= toLatLng!.longitude)
        ? toLatLng!.longitude
        : fromLatLng!.longitude;

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

    googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        50.0,
      ),
    );
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    createPolylines();
  }

  createPolylines() async {
    totalDistance = 0;

    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDgrOHeCPPtxJVF3GGQvkfZrXllj6Z4HTU", // Google Maps API Key
      PointLatLng(fromLatLng!.latitude, fromLatLng!.longitude),
      PointLatLng(toLatLng!.latitude, toLatLng!.longitude),
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
    notifyListeners();
  }
}

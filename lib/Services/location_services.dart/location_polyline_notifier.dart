import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'loaction_shared_preference.dart';

class MapsPolyLineProvider with ChangeNotifier {
  List<PointLatLng> _polylineLatLng = [];

  set polylineLatLng(List<PointLatLng> point) {
    _polylineLatLng = point;
  }

  List<PointLatLng> getPolylineLatLng() {
    return _polylineLatLng;
  }

  //Google Maps Provider
  PolylinePoints? polylinePoints;
  GoogleMapController? _googleMapController;
  late Position _currentLocationData;
// List of coordinates to join
  List<LatLng> polylineCoordinates = [];
// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> _markers = {};
  double totalDistance = 0;
  // double? _nearByRadiusDistanceInKM;

  void clearMarkers() {
    _markers.clear();
  }

  MapsPolyLineProvider() {
    _initialize();
  }

  String? _selectedCategory;

  String? get getSelectedCategory => _selectedCategory;

  set selectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  _initialize() async {
    // _nearByRadiusDistanceInKM = 2;
    _currentLocationData = Position(
        longitude: SharedPreference.longitude!,
        latitude: SharedPreference.latitude!,
        timestamp: DateTime.now(),
        accuracy: 9,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);

    markerSet.add(Marker(
      markerId: MarkerId(Random().nextInt(100).toString()),
      position:
          LatLng(_currentLocationData.latitude, _currentLocationData.longitude),
    ));
    notifyListeners();
  }

  setLikeOnfinalLocationDetails(int index, bool isLiked) {
    notifyListeners();
  }

  setLikeOnFalsefinalLocationDetails(int index, bool isLiked) {
    notifyListeners();
  }

  set nearByDistanceInKM(double radius) {
    // _nearByRadiusDistanceInKM = radius;R
    notifyListeners();
  }

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

  set googleMapController(GoogleMapController controller) {
    _googleMapController = controller;
  }

  Position? get currentPosition => _currentLocationData;

  addMarkers(
      {required String markerId,
      required double latitude,
      required double longitude}) {
    markerSet.add(Marker(
        markerId: MarkerId(markerId), position: LatLng(latitude, longitude)));
  }

  //Make a route between source and destination place
  getDistance(double destinationLatitude, double destinationLongitude) {
    double miny = (SharedPreference.latitude! <=
            // double.parse(selectedLocationDetails!.lat)
            destinationLatitude)
        ? SharedPreference.latitude!
        : destinationLatitude;
    // double.parse(selectedLocationDetails!.lat);
    double minx = (SharedPreference.longitude! <= destinationLongitude)
        ? SharedPreference.longitude!
        : destinationLongitude;
    double maxy = (SharedPreference.latitude! <= destinationLatitude)
        ? destinationLatitude
        : SharedPreference.latitude!;
    double maxx = (SharedPreference.longitude! <= destinationLongitude)
        ? destinationLongitude
        : SharedPreference.longitude!;

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

    markerSet.add(Marker(
        markerId: const MarkerId("Destination Marker"),
        position: LatLng(destinationLatitude, destinationLongitude)));

    _googleMapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        50.0,
      ),
    );
    createPolylines(destinationLatitude, destinationLongitude,
        destinationLatitude.toString());
  }

  createPolylines(double destinationLatitude, double destinationLongitude,
      String polylineId) async {
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      "AIzaSyDlqUnhLDV1QlC1yVn2H3tE96T3QA0bjz0", // Google Maps API Key
      PointLatLng(SharedPreference.latitude!, SharedPreference.longitude!),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );
    polylineCoordinates.clear();

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
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
    PolylineId id = PolylineId(polylineId);

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

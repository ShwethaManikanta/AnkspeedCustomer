import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:new_ank_customer/Services/location_services.dart/loaction_shared_preference.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show Random, asin, cos, sqrt;

import '../Models/location_details.dart';

enum HomePageProviderState { Uninitialized, Initialized }

class HomePageProvider with ChangeNotifier {
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
  double? _nearByRadiusDistanceInKM;

  bool _selectRideScreen = false;

  bool get getSelectRideScreen {
    return _selectRideScreen;
  }

  void selectRideScreen(bool value) {
    _selectRideScreen = value;
    print("---- selectedRideScreen - -- - ----" + _selectRideScreen.toString());
    notifyListeners();
  }

  void clearMarkers() {
    _markers.clear();
  }

  // Polyine _polyLine;

  HomePageProviderState _state = HomePageProviderState.Uninitialized;
  // DatabaseService databaseService;
  // Stream<List<LocationDetails>> _locationDetailsStream;
  List<LocationDetailsCopy>? _locationDetailsList;
  LocationDetailsCopy? selectedLocationDetails;

  HomePageProvider() {
    _initialize();
  }

  set selectedLocation(LocationDetailsCopy locationDetailsCopy) {
    selectedLocationDetails = locationDetailsCopy;
  }

  String? _selectedCategory;

  String? get getSelectedCategory => _selectedCategory;

  set selectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // HomePageProvider();
  _initialize() async {
    _nearByRadiusDistanceInKM = 2;
    _currentLocationData = Position(
        longitude: SharedPreference.longitude!,
        latitude: SharedPreference.latitude!,
        timestamp: DateTime.now(),
        accuracy: 9,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);

    //  await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

    print(_currentLocationData.latitude.toString() +
        "------ - - - --  --  -- - " +
        _currentLocationData.longitude.toString());

    markerSet.add(Marker(
      markerId: MarkerId(Random().nextInt(100).toString()),
      position:
          LatLng(_currentLocationData.latitude, _currentLocationData.longitude),
    ));
    // u
    //nfilteredLocationDetails.forEach((element) {
    //   locationDetailsFuture.add(element);
    // });

    // locationDetailsFuture.forEach((element) {
    // _likedParlourList.forEach((likedElement) {
    //   print("fact" + likedElement.parlourId);
    //   if (likedElement.parlourId == element.parlourId) {
    //     element.isLiked = likedElement.isLiked;
    //   }
    // });
    // element.distance = Geolocator.distanceBetween(
    //     _currentLocationData.latitude,
    //     _currentLocationData.longitude,
    //     double.parse(element.latitude),
    //     double.parse(element.longitude));
    // if (element.distance / 1000 < _nearByRadiusDistanceInKM) {
    //   _markers.add(Marker(
    //       markerId: MarkerId(element.parlourName),
    //       position: LatLng(double.parse(element.latitude),
    //           double.parse(element.longitude))));
    // }
    // });

    // locationDetailsFuture
    //     .sort((a, b) => getShortDistance(a.distance, b.distance));
    // selectedLocationDetails = locationDetailsFuture[0];
    _state = HomePageProviderState.Initialized;
    notifyListeners();
  }

  setLikeOnfinalLocationDetails(int index, bool isLiked) {
    // locationDetailsFuture[index].isLiked = isLiked;
    // locationDetailsFuture[index].incrementLikes();
    notifyListeners();
  }

  setLikeOnFalsefinalLocationDetails(int index, bool isLiked) {
    // locationDetailsFuture[index].isLiked = isLiked;
    // locationDetailsFuture[index].decrementLikes();
    notifyListeners();
  }

  set nearByDistanceInKM(double radius) {
    _nearByRadiusDistanceInKM = radius;
    notifyListeners();
  }

  // double get nearByDistanceInKM => _nearByRadiusDistanceInKM;

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

  // double distance(int index) => _distances[index];
  // CarouselController get carouselController => _carouselController;

  // set carouselController(CarouselController carouselController) {
  //   _carouselController = carouselController;
  //   notifyListeners();
  // }

  Set<Marker> get markerSet => _markers;

  HomePageProviderState get state => _state;

  // List<LocationDetailsCopy> get locationDetailsList => locationDetailsFuture;

  // Stream<List<LocationDetails>> get locationDetailsStream =>
  //     _locationDetailsStream;

  // LocationDetailsCopy get getSelectedLocationDetails => selectedLocationDetails;

  // double get getTotalDistance => totalDistance;

  // set setSelectedLocationDetails(LocationDetailsCopy locationDetails) {
  //   selectedLocationDetails = locationDetails;
  //   print("selectedLocationDetails:" + selectedLocationDetails.parlourId);
  //   notifyListeners();
  // }

  //Google Maps controller assigning to
  // GoogleMapController? get getGoogleMapController => _googleMapController;

  set googleMapController(GoogleMapController controller) {
    _googleMapController = controller;
  }

  // moveCameraToCurrentLocation() {
  //   _googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           target:
  //               LatLng(currentPosition!.latitude, currentPosition!.longitude),
  //           zoom: 15.0)));
  // }

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
    totalDistance = 0;

    // // return totalDistance;
    // print(destinationLatitude.toString() +
    //     "--------" +
    //     destinationLongitude.toString());
    // // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      "AIzaSyDgrOHeCPPtxJVF3GGQvkfZrXllj6Z4HTU", // Google Maps API Key
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

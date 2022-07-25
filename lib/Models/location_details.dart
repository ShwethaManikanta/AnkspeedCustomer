import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationDetailsCopy {
//   final String parlourName,
//       parlourDescription,
//       phoneNumber1,
//       phoneNumber2,
//       profileImage,
//       parlourId,
//       documentKey,
//       suitableGender,
//       openTime,
//       closeTime;
//   List<LatLng> _polyLineCoordinates = [];
//   double _distance = 0.0;
//   Map<PolylineId, Polyline> polylines = {};
//   final String longitude, latitude;
//   int likes;

//   LocationDetailsCopy({
//     required this.parlourName,
//     required this.parlourDescription,
//     required this.phoneNumber1,
//     required this.phoneNumber2,
//     required this.profileImage,
//     required this.parlourId,
//     required this.likes,
//     required this.openTime,
//     required this.closeTime,
//     required this.suitableGender,
//     required this.latitude,
//     required this.longitude,
//     required this.documentKey,
//   });

//   factory LocationDetailsCopy.fromMap(
//       {required Map data, required String documentKey}) {
//     return LocationDetailsCopy(
//         profileImage: data['profileImage'] ?? "",
//         parlourName: data['parlourName'] ?? "",
//         parlourDescription: data["parlourDescription"] ?? "",
//         latitude: data['latitude'] ?? "",
//         longitude: data['longitude'] ?? "",
//         phoneNumber1: data['phoneNumber1'] ?? "",
//         phoneNumber2: data['phoneNumber2'] ?? "",
//         parlourId: data['parlourId'] ?? "",
//         likes: data['likes'] ?? 0,
//         suitableGender: data['suitableGender'] ?? "",
//         closeTime: data['closeTime'] ?? "",
//         openTime: data['openTime'] ?? "",
//         documentKey: documentKey);
//   }
// }

class LocationDetailsCopy {
  final String lang, lat, documentKey;
  List<LatLng> _polyLineCoordinates = [];
  double _distance = 0.0;
  Map<PolylineId, Polyline> polylines = {};

  LocationDetailsCopy(
      {required this.lang, required this.lat, required this.documentKey});

  factory LocationDetailsCopy.fromMap(
      {required Map data, required String documentKey}) {
    return LocationDetailsCopy(
        lat: data['lat'] ?? "",
        lang: data['lang'] ?? "",
        documentKey: documentKey);
  }
}

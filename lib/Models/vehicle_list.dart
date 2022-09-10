class VehilceList {
  final String name, category, latitude, longitude, documentID;

  VehilceList({
    required this.documentID,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  factory VehilceList.fromMap(
      {required Map<dynamic, dynamic> data, required String documentId}) {
    return VehilceList(
      documentID: documentId,
      name: data['name'] ?? "NA",
      category: data['category'] ?? "NA",
      latitude: data['latitude'] ?? "NA",
      longitude: data['longitude'] ?? "NA",
    );
  }
}

// factory BookingDetails.fromMap(
//     Map<dynamic, dynamic> data, String documentId) {
//   if (data == null) {
//     return null;
//   }
//   print("--" + data['parlourId']);
//   return BookingDetails(
//       documentId: documentId ?? "",
//       serviceKey: data['serviceKey'] ?? "",
//       bookDateTime: data['bookedDayTime'] ?? "",
//       bookedDate: data['bookedDate'] ?? "",
//       bookedTime: data['bookedTime'] ?? "",
//       bookingDateTime: data['bookingDateTime'] ?? "",
//       bookingUserId: data['bookingUserId'] ?? "",
//       parlourId: data['parlourId'] ?? "",
//       isExpired: data['isExpired'] ?? false,
//       isCancelled: data['isCancelled'] ?? false,
//       isPostponed: data['isPostponed'] ?? false);
// }
// }

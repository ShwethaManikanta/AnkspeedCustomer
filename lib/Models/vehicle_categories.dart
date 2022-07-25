class VehicleCategories {
  final String imageUrl, name, documentID, unit;
  final List<String> price, range;

  VehicleCategories(
      {required this.imageUrl,
      required this.name,
      required this.documentID,
      required this.price,
      required this.range,
      required this.unit});

  factory VehicleCategories.fromMap(
      {required Map<String, dynamic> data, required String documentId}) {
    return VehicleCategories(
        documentID: documentId,
        price: List.from(data['price']),
        range: List.from(data['range']),
        unit: data['unit'] ?? "NA",
        imageUrl: data['imageUrl'] ?? "NA",
        name: data['name'] ?? "NA");
  }
}

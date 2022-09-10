class OrderTrackModel {
  String? status;
  String? message;
  String? orderId;
  TrackDetails? trackDetails;

  OrderTrackModel({this.status, this.message, this.orderId, this.trackDetails});

  OrderTrackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderId = json['order_id'];
    trackDetails = json['track_details'] != null
        ? TrackDetails.fromJson(json['track_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['order_id'] = orderId;
    if (trackDetails != null) {
      data['track_details'] = trackDetails!.toJson();
    }
    return data;
  }
}

class TrackDetails {
  String? id;
  String? tripId;
  String? lat;
  String? long;
  String? heading;
  String? address;
  String? status;
  String? createdAt;

  TrackDetails(
      {this.id, this.tripId, this.address, this.status, this.createdAt});

  TrackDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripId = json['trip_id'];
    lat = json['lat'];
    long = json['long'];
    heading = json['heading'];

    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['trip_id'] = tripId;
    data['address'] = address;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

class HelperListResponseModel {
  String? status;
  String? message;
  List<LabourList>? labourList;

  HelperListResponseModel({this.status, this.message, this.labourList});

  HelperListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['labour_list'] != null) {
      labourList = <LabourList>[];
      json['labour_list'].forEach((v) {
        labourList!.add(new LabourList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.labourList != null) {
      data['labour_list'] = this.labourList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LabourList {
  String? id;
  String? price;
  String? limit;
  String? status;
  String? createdAt;

  LabourList({this.id, this.price, this.limit, this.status, this.createdAt});

  LabourList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    limit = json['limit'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['price'] = price;
    data['limit'] = limit;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

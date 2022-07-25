class UnitListResponseModel {
  String? status;
  String? message;
  List<UnitList>? unitList;

  UnitListResponseModel({this.status, this.message, this.unitList});

  UnitListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['unit_list'] != null) {
      unitList = <UnitList>[];
      json['unit_list'].forEach((v) {
        unitList!.add(UnitList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (unitList != null) {
      data['unit_list'] = unitList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnitList {
  String? id;
  String? units;
  String? status;
  String? createdAt;

  UnitList({this.id, this.units, this.status, this.createdAt});

  UnitList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    units = json['units'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['units'] = units;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

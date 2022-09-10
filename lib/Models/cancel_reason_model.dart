class CancelReasonModel {
  String? status;
  String? message;
  List<ReasonList>? reasonList;

  CancelReasonModel({this.status, this.message, this.reasonList});

  CancelReasonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['reason_list'] != null) {
      reasonList = <ReasonList>[];
      json['reason_list'].forEach((v) {
        reasonList!.add(new ReasonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.reasonList != null) {
      data['reason_list'] = this.reasonList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReasonList {
  String? id;
  String? type;
  String? reason;
  String? status;
  String? createdAt;

  ReasonList({this.id, this.type, this.reason, this.status, this.createdAt});

  ReasonList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    reason = json['reason'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

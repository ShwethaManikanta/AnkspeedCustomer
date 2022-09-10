class CouponModel {
  String? status;
  String? message;
  List<CouponList>? couponList;

  CouponModel({this.status, this.message, this.couponList});

  CouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['coupon_list'] != null) {
      couponList = <CouponList>[];
      json['coupon_list'].forEach((v) {
        couponList!.add(new CouponList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.couponList != null) {
      data['coupon_list'] = this.couponList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponList {
  String? id;
  String? couponName;
  String? type;
  String? offer;
  String? upto;
  String? validDate;
  String? description;
  String? status;
  String? createdAt;

  CouponList(
      {this.id,
      this.couponName,
      this.type,
      this.offer,
      this.upto,
      this.validDate,
      this.description,
      this.status,
      this.createdAt});

  CouponList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponName = json['coupon_name'];
    type = json['type'];
    offer = json['offer'];
    upto = json['upto'];
    validDate = json['valid_date'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon_name'] = this.couponName;
    data['type'] = this.type;
    data['offer'] = this.offer;
    data['upto'] = this.upto;
    data['valid_date'] = this.validDate;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

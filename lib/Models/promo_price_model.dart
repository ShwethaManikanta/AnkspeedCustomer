class PromoPriceModel {
  String? status;
  String? message;
  int? discountAmt;
  String? getTotalPrice;

  PromoPriceModel(
      {this.status, this.message, this.discountAmt, this.getTotalPrice});

  PromoPriceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    discountAmt = json['discount_amt'];
    getTotalPrice = json['get_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['discount_amt'] = this.discountAmt;
    data['get_total_price'] = this.getTotalPrice;
    return data;
  }
}

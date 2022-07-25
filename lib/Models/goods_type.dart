class GoodTypeResponseModel {
  String? status;
  String? message;
  List<CategoryList>? categoryList;

  GoodTypeResponseModel({this.status, this.message, this.categoryList});

  GoodTypeResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? id;
  String? categoryName;
  String? quantity;
  String? status;
  String? createdAt;

  CategoryList(
      {this.id, this.categoryName, this.quantity, this.status, this.createdAt});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

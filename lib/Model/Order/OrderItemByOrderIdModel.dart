// ignore_for_file: file_names

class OrderItemByOrderIdModel {
  FoodId? foodId;
  int? quantity;
  String? status;
  String? createdAt;
  String? updatedAt;

  OrderItemByOrderIdModel(
      {this.foodId,
      this.quantity,
      this.status,
      this.createdAt,
      this.updatedAt});

  OrderItemByOrderIdModel.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'] != null ? FoodId.fromJson(json['foodId']) : null;
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foodId != null) {
      data['foodId'] = foodId!.toJson();
    }
    data['quantity'] = quantity;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class FoodId {
  String? sId;
  String? foodName;
  int? price;
  String? description;
  String? categoryId;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FoodId(
      {this.sId,
      this.foodName,
      this.price,
      this.description,
      this.categoryId,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FoodId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    foodName = json['foodName'];
    price = json['price'];
    description = json['description'];
    categoryId = json['categoryId'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['foodName'] = foodName;
    data['price'] = price;
    data['description'] = description;
    data['categoryId'] = categoryId;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

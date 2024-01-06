// ignore_for_file: file_names

class FoodsByCategoryModel {
  String? sId;
  String? foodName;
  int? price;
  String? description;
  String? categoryId;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FoodsByCategoryModel(
      {this.sId,
      this.foodName,
      this.price,
      this.description,
      this.categoryId,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FoodsByCategoryModel.fromJson(Map<String, dynamic> json) {
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

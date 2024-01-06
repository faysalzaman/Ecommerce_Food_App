// ignore_for_file: file_names

class IsInCartModel {
  bool? isInCart;

  IsInCartModel({this.isInCart});

  IsInCartModel.fromJson(Map<String, dynamic> json) {
    isInCart = json['isInCart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isInCart'] = isInCart;
    return data;
  }
}

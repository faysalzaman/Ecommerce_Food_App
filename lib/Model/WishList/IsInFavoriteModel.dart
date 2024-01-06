// ignore_for_file: file_names

class IsInFavoriteModel {
  bool? isFavorite;

  IsInFavoriteModel({this.isFavorite});

  IsInFavoriteModel.fromJson(Map<String, dynamic> json) {
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFavorite'] = isFavorite;
    return data;
  }
}

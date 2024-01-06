// ignore_for_file: file_names

class UserDetailsModel {
  int? status;
  String? message;
  Data? data;

  UserDetailsModel({this.status, this.message, this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? email;
  String? phone;
  String? address;
  String? profileImage;
  String? fullname;

  Data(
      {this.sId,
      this.email,
      this.phone,
      this.address,
      this.profileImage,
      this.fullname});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    phone = json['Phone'];
    address = json['address'];
    profileImage = json['ProfileImage'];
    fullname = json['fullname'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['Phone'] = phone;
    data['address'] = address;
    data['ProfileImage'] = profileImage;
    data['fullname'] = fullname;
    return data;
  }
}

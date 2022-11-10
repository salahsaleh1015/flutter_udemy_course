class ShopLoginModel {
  late bool status;
  late String message;
  late UserData data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData {
  late int id;
  late String email;
  late String phone;
  late String name;
  late String image;
  late int point;
  late int credit;
  late String token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    image = json['image'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];
  }
}

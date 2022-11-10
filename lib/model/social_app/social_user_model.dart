class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  String? image;
  String? cover;
  String? bio;

  // bool? isEmailVerified;
  SocialUserModel(
      {required this.phone,
      required this.name,
      required this.email,
      required this.uId,
      this.image,
      this.bio,
      this.cover});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
    };
  }
}

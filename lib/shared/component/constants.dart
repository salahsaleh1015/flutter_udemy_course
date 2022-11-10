import 'package:flutter_udemy_course/module/login/shop_login_screen.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';
import 'package:flutter_udemy_course/shared/network/local/cache_helper.dart';

void logOut(context) {
  CacheHelper.removeData(key: "token").then((value) {
    if (value) {
      navigateAndReplace(context, ShopLoginScreen());
    }
  });
}

String token = "";
String uId = '';

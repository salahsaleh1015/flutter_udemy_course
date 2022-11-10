import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/shop_app/shop_cubit/shop_states.dart';
import 'package:flutter_udemy_course/module/shop_app/category/category_screen.dart';
import 'package:flutter_udemy_course/module/shop_app/favorite/favorite_screen.dart';
import 'package:flutter_udemy_course/module/shop_app/product/product_screen.dart';
import 'package:flutter_udemy_course/module/shop_app/setting/setting_screen.dart';
import 'package:flutter_udemy_course/shared/component/constants.dart';
import 'package:flutter_udemy_course/shared/network/remote/dio_helper.dart';
import 'package:flutter_udemy_course/shared/network/remote/end_points.dart';

import '../../../model/shop_app/home_model.dart';

class ShopCubit extends Cubit<ShopAppStates> {
  ShopCubit() : super(ShopAppInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  //===============================================================================

  List<Widget> screens = [
    ProductScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.production_quantity_limits,
        ),
        label: "product"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.category_outlined,
        ),
        label: "category"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        label: "favorite"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: "settings"),
  ];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavBarState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopAppHomeLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel!.data.banners![0].image);
      emit(ShopAppHomeErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppHomeErrorState());
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/social_app/cubit/social_states.dart';
import 'package:flutter_udemy_course/model/social_app/social_user_model.dart';
import 'package:flutter_udemy_course/module/social_app/favorite/fav_screen.dart';
import 'package:flutter_udemy_course/module/social_app/feeds/feeds_screen.dart';
import 'package:flutter_udemy_course/module/social_app/posts/posts_screen.dart';
import 'package:flutter_udemy_course/module/social_app/settings/settings_screen.dart';
import 'package:flutter_udemy_course/module/social_app/users/users_screen.dart';
import 'package:flutter_udemy_course/shared/component/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  List titles = [
    "FeedsScreen",
    " UsersScreen",
    "posts",
    "FavoriteScreen",
    "SettingsScreens",
  ];

  List<Widget> screens = [
    FeedsScreen(),
    UsersScreen(),
    PostsScreen(),
    FavoriteScreen(),
    SettingsScreens(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: "feeds"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.location_on,
        ),
        label: "users"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.post_add,
        ),
        label: "posts"),
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
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print("//====================");
      print(value.data()!);
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      print("//=========//===========");
      print(error.toString());
      emit(SocialGetUserDataErrorState(error));
    });
  }
}

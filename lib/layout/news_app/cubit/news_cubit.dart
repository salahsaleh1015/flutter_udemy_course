import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/news_app/cubit/news_states.dart';
import 'package:flutter_udemy_course/module/news_app/t/business/business_screen.dart';
import 'package:flutter_udemy_course/module/news_app/t/science/science_screen.dart';
import 'package:flutter_udemy_course/module/news_app/t/sports/sports_screen.dart';
import 'package:flutter_udemy_course/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsAppStates> {
  NewsCubit() : super(NewsAppInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

//===============================================================

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: "business"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: "sports"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: "science"),
  ];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    if (index == 1) {
      getSportsData();
    } else {
      getScienceData();
    }

    emit(NewsAppChangeBottomNavigationBarState());
  }

//=========================================================================================
  List<dynamic> business = [];

  getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "business",
        "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
      }).then((value) {
        business = value.data['articles'];
        print(value.data.toString());
        emit(NewsGetBusinessDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessDataErrorState(error));
      });
    } else {
      emit(NewsGetBusinessDataSuccessState());
    }
  }

  List<dynamic> sports = [];

  getSportsData() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
      }).then((value) {
        sports = value.data['articles'];
        print(value.data.toString());
        emit(NewsGetSportsDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsDataErrorState(error));
      });
    } else {
      emit(NewsGetSportsDataSuccessState());
    }
  }

  List<dynamic> science = [];

  getScienceData() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
      }).then((value) {
        science = value.data['articles'];
        print(value.data.toString());
        emit(NewsGetScienceDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceDataErrorState(error));
      });
    } else {
      emit(NewsGetScienceDataSuccessState());
    }
  }

  List<dynamic> search = [];

  getSearchData(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: "v2/everything", query: {
      "q": '$value',
      "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
    }).then((value) {
      search = value.data['articles'];
      print(value.data.toString());
      emit(NewsGetSearchDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchDataErrorState(error));
    });
  }
}

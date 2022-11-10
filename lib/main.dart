//bool boarding =   CacheHelper.getBool(key: "boarding") ?? false;
//bool token =   CacheHelper.getBool(key: "token") ?? false;
// if(boarding != null){
//   if(token!=null){
//     widget = ShopLayOut();
//   }else{
//     widget = ShopLoginScreen();
//   }
// }else{
//   widget = OnBoardingScreen();
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/news_app/cubit/news_cubit.dart';
import 'package:flutter_udemy_course/layout/shop_app/shop_cubit/shop_cubit.dart';
import 'package:flutter_udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_udemy_course/layout/social_app/social_layout.dart';
import 'package:flutter_udemy_course/layout/to_do_app/to_do_layout/task_app_layout.dart';
import 'package:flutter_udemy_course/module/social_app/social_login/social_login_screen.dart';
import 'package:flutter_udemy_course/shared/component/constants.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/cubit.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/states.dart';
import 'package:flutter_udemy_course/shared/network/local/cache_helper.dart';
import 'package:flutter_udemy_course/shared/network/remote/dio_helper.dart';
import 'package:flutter_udemy_course/shared/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool isDark = CacheHelper.getBool(key: "isDark") ?? false;
  uId = CacheHelper.getData(key: "uId") ?? "s";

  if (uId != null) {
    widget = SocialLayOut();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({required this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusinessData(),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMood(fromShared: isDark)
            ..createDatabase(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: TasksLayOut(),
            // home:startWidget,
            /* home: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
               String os  = Platform.operatingSystem;
               print(os);
               print(constraints.minWidth.toInt());
               if(constraints.minWidth.toInt() <= 560){
                 return MediaQuery(data: MediaQuery.of(context).copyWith(
                   textScaleFactor: 1.25,
                 ),
                 child: DeskTopScreen());
               }else {
                 return MediaQuery(data: MediaQuery.of(context).copyWith(
                   textScaleFactor: 0.8,
                 ),
                 child: MobileScreen());
               }

             },
              ),*/
          );
        },
      ),
    );
  }
}

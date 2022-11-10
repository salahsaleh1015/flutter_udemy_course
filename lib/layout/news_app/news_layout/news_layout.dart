import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/news_app/cubit/news_cubit.dart';
import 'package:flutter_udemy_course/layout/news_app/cubit/news_states.dart';
import 'package:flutter_udemy_course/module/news_app/t/search/search_screen.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/cubit.dart';

class NewsLayOut extends StatelessWidget {
  const NewsLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppMood();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
            title: Text("News App"),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/social_app/cubit/social_cubit.dart';
import 'package:flutter_udemy_course/layout/social_app/cubit/social_states.dart';
import 'package:flutter_udemy_course/module/social_app/posts/posts_screen.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';

class SocialLayOut extends StatelessWidget {
  const SocialLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialAddPostState) {
          navigateTo(context, PostsScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_active, color: Colors.grey[800]),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

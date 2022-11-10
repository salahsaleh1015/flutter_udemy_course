import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/shop_app/shop_cubit/shop_cubit.dart';
import 'package:flutter_udemy_course/layout/shop_app/shop_cubit/shop_states.dart';

class ShopLayOut extends StatelessWidget {
  const ShopLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("salla", style: Theme.of(context).textTheme.bodyText1),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}

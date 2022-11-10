import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/shop_app/shop_cubit/shop_cubit.dart';
import 'package:flutter_udemy_course/layout/shop_app/shop_cubit/shop_states.dart';
import 'package:flutter_udemy_course/model/shop_app/home_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context) =>
                buildHomeSlider(ShopCubit.get(context).homeModel!),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildHomeSlider(HomeModel model) => Column(
        children: [
          CarouselSlider(
              items: model.data.banners
                  ?.map((e) => Image(
                        image: NetworkImage('${e.image}'),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ))
        ],
      );
}

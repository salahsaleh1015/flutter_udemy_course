import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/news_app/cubit/news_cubit.dart';
import 'package:flutter_udemy_course/layout/news_app/cubit/news_states.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).business;
        return buildArticle(list);
      },
    );
  }
}

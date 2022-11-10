import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/cubit.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;
        return buildTasks(tasks);
      },
    );
  }
}

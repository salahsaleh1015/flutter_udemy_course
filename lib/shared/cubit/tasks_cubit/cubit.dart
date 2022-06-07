import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/states.dart';

class TasksCubit extends Cubit <TasksStates>{
  TasksCubit():super(TasksInitialState());
  TasksCubit get(context)=>BlocProvider.of(context);

}
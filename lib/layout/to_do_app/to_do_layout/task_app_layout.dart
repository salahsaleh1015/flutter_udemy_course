import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/cubit.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/states.dart';
import 'package:intl/intl.dart';

class TasksLayOut extends StatelessWidget {
  TasksLayOut({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var textController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeIndex(index);
              // setState(() {
              //   currentIndex = index;
              // });
            },
          ),
          body: ConditionalBuilder(
            builder: (context) {
              return cubit.screens[cubit.currentIndex];
            },
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            condition: state is! AppGetLoadingDatabaseState,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertIntoDatabase(
                      title: textController.text,
                      date: dateController.text,
                      time: timeController.text);
                  // insertIntoDatabase(
                  //     title: textController.text,
                  //     date: dateController.text,
                  //     time: timeController.text)
                  //     .then((value) {
                  //   getDataFromDatabase(database).then((value) {
                  //     Navigator.pop(context);
                  //     cubit.changeBottomSheetState(icon: Icons.add, isShow: false);
                  //     // setState(() {
                  //     //   isBottomSheetShown = false;
                  //     //   fabIcon = Icons.add;
                  //     //   tasks = value;
                  //     //   print(tasks);
                  //     // });
                  //   });
                  // });
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet((context) {
                      return Container(
                        padding: EdgeInsets.all(15),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                  label: "enter your task",
                                  prefixIcon: Icons.task,
                                  controller: textController,
                                  type: TextInputType.text,
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'input must not be empty';
                                    }
                                  }),
                              SizedBox(
                                height: 7,
                              ),
                              defaultFormField(
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  label: "enter your time",
                                  prefixIcon: Icons.timer,
                                  controller: timeController,
                                  type: TextInputType.text,
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'input must not be empty';
                                    }
                                  }),
                              SizedBox(
                                height: 7,
                              ),
                              defaultFormField(
                                  onTap: () {
                                    showDatePicker(
                                      lastDate: DateTime.parse('2023-12-30'),
                                      initialDate: DateTime.now(),
                                      context: context,
                                      firstDate: DateTime.now(),
                                    ).then((value) {
                                      dateController.text = DateFormat.yMMMEd()
                                          .format(value!)
                                          .toString();
                                    });
                                  },
                                  label: "enter your date",
                                  prefixIcon: Icons.date_range,
                                  controller: dateController,
                                  type: TextInputType.text,
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'input must not be empty';
                                    }
                                  }),
                            ],
                          ),
                        ),
                      );
                    })
                    .closed
                    .then((value) {
                      cubit.changeBottomSheetState(
                          icon: Icons.add, isShow: false);
                      // isBottomSheetShown = false;
                      // setState(() {
                      //   fabIcon = Icons.add;
                      // });
                    });
                cubit.changeBottomSheetState(icon: Icons.edit, isShow: true);
                //isBottomSheetShown = true;
                // setState(() {
                //   fabIcon = Icons.edit;
                // });
              }
            },
            child: Icon(cubit.fabIcon),
          ),
        );
      },
    );
  }
}

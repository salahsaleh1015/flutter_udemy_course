import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/module/tasks_app_modules/archived_tasks_screen.dart';
import 'package:flutter_udemy_course/module/tasks_app_modules/done_tasks_screen.dart';
import 'package:flutter_udemy_course/module/tasks_app_modules/new_tasks_screen.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/states.dart';
import 'package:flutter_udemy_course/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<String> titles = [
    "new tasks",
    " done tasks",
    "archived tasks",
  ];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasks(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.task,
        ),
        label: "new tasks"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.add_task_outlined,
        ),
        label: "done tasks"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.archive,
        ),
        label: "archived tasks"),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

//==========================================================================================================
  IconData fabIcon = Icons.add;
  bool isBottomSheetShown = false;

  void changeBottomSheetState({required IconData icon, required bool isShow}) {
    fabIcon = icon;
    isBottomSheetShown = isShow;
    emit(AppChangeBottomSheetState());
  }

//===================================================================================================================

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() async {
    database = await openDatabase("todo.db", version: 1,
        onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , time TEXT , date TEXT , status TEXT)')
          .then((value) {
        emit(AppCreateDatabaseState());
        print('table created');
      }).catchError((error) {
        print('${error.toString()}');
      });
    }, onOpen: (database) {
      print('database opened');
      getDataFromDatabase(database);
    });
  }

  Future insertIntoDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks(title, time, date , status) VALUES("$title", "$time", "$date" , "new")')
          .then((value) {
        print("$value inserted in table");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print("${error.toString()}");
      });
    });
  }

  getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  updateData({required String status, required int id}) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [
      '$status',
      id,
    ]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  deleteData({required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark = false;

  changeAppMood({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else
      isDark = !isDark;
    CacheHelper.setBoolean(key: 'isDark', value: isDark);
    emit(AppChangeAppMoodState());
  }
}
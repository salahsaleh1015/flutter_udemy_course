import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy_course/module/tasks_app_modules/archived_tasks_screen.dart';
import 'package:flutter_udemy_course/module/tasks_app_modules/done_tasks_screen.dart';
import 'package:flutter_udemy_course/module/tasks_app_modules/new_tasks_screen.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class TasksLayOut extends StatefulWidget {
  const TasksLayOut({Key? key}) : super(key: key);

  @override
  _TasksLayOutState createState() => _TasksLayOutState();
}

class _TasksLayOutState extends State<TasksLayOut> {
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasks(),
  ];
  List titles = [
    "new tasks",
    " done tasks",
    "archived tasks",
  ];
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    createDatabase();
    // TODO: implement initState
    super.initState();
  }

  late Database database;
  var textController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.add;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: screens[currentIndex],
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.task,
              ),
              label: "new tasks"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_task_outlined,
              ),
              label: "new tasks"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.archive,
              ),
              label: "new tasks"),
        ],
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertIntoDatabase(
                title: textController.text,
                date: dateController.text,
                time: timeController.text,
              ).then((value) {
                Navigator.pop(context);
                isBottomSheetShown = false;
                setState(() {
                  fabIcon = Icons.add;
                });
              });

            }
          } else {
            scaffoldKey.currentState!.showBottomSheet((context) => Container(
                  padding: EdgeInsets.all(20),
                  height: 250,
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(

                        mainAxisSize: MainAxisSize.min,

                        children: [
                          defaultFormField(
                            onTap: (){

                            },
                            prefixIcon: Icons.task,
                            label: "enter your tasks",
                            controller: textController,
                            type: TextInputType.text,
                            onFieldSubmitted: () {},
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "must not be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            onTap: (){
                              showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                                textController.text = value!.format(context).toString();
                              });

                            },
                            prefixIcon: Icons.timer_outlined,
                            label: "enter your time",
                            controller: timeController,
                            type: TextInputType.datetime,
                            onFieldSubmitted: () {},
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "must not be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            onTap: (){
                             showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                 firstDate: DateTime.now(),
                              lastDate:DateTime.parse("2022-12-31") ).then((value){
                                dateController.text = DateFormat.yMMMd().format(value!);
                             });
                            },
                            prefixIcon: Icons.date_range,
                            label: "enter your date",
                            controller: dateController,
                            type: TextInputType.datetime,
                            onFieldSubmitted: () {},
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "must not be empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.edit;
            });
          }
        },
        child: Icon(
          fabIcon,
        ),
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase("todo.db", version: 1,
        onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , time TEXT , date TEXT , status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('${error.toString()}');
      });
    }, onOpen: (database) {
      print('database opened');
    });
  }

 Future insertIntoDatabase({required String title ,required String date ,required String time , }) async{
   return await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks(title, time, date , status) VALUES("$title", "$time", "$date" , "ggg")')
          .then((value) => print("$value inserted in table"))
          .catchError((error) {
        print("${error.toString()}");
      });
    });
  }
}

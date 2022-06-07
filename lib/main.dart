import 'package:flutter/material.dart';
import 'package:flutter_udemy_course/layout/task_app_layout/task_app_layout.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksLayOut(),
    );
  }
}

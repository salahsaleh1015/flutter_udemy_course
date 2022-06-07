import 'package:flutter/material.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Archived Tasks",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

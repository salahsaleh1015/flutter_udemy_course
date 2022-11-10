import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy_course/shared/cubit/tasks_cubit/cubit.dart';
import 'package:flutter_udemy_course/shared/style/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

// reusable component
// 1. timing
// 2. refactor
// 1. quality
//=============================
Widget buildTextButton(
        {required VoidCallback function, required String text}) =>
    TextButton(
        style: ButtonStyle(),
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: primaryColor),
        ));

Widget buildDefaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType? type,
  Function? onFieldSubmitted,
  required ValueChanged<String> onChanged,
  bool isPassword = false,
  Function(String)? onSubmit,
  required FormFieldValidator<String> validator,
  IconData? prefixIcon,
  IconData? suffixIxIcon,
  String? label,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}) =>
    TextFormField(
      onTap: onTap,
      obscureText: isPassword,
      keyboardType: type,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        labelText: label,
        suffixIcon: suffixIxIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(Icons.visibility_off_sharp))
            : null,
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text("${model['time']}"),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${model['date']}",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.done,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archive', id: model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget buildTasks(List<Map> tasks) => ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) {
            return myDivider();
          },
          itemCount: tasks.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.list,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              "no tasks Yet, please enter some tasks",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        //  navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepOrange,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${article['urlToImage']}"),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                height: 120,
                width: 150,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Text(
                      "${article['title']}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget myDivider() => Container(
      padding: EdgeInsetsDirectional.only(start: 20),
      height: 1,
      color: Colors.grey,
      width: double.infinity,
    );

Widget buildArticle(list) => ConditionalBuilder(
      fallback: (context) => Center(
        child: CircularProgressIndicator(),
      ),
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            return buildArticleItem(list[i], context);
          },
          separatorBuilder: (context, i) => myDivider(),
          itemCount: list.length),
      condition: list.length > 0,
    );
//===============================================================================
Future navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndReplace(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));
//--==========================================================================================
void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: showToastState(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color showToastState(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

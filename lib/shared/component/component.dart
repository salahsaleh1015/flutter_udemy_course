import 'package:flutter/material.dart';
// reusable component
// 1. timing
// 2. refactor
// 1. quality
//=============================
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
 required Function? onFieldSubmitted,
  required  ValueChanged <String> onChanged,
  bool isPassword = false,
  Function (String) ? onSubmit,
  required FormFieldValidator<String> validator,
  IconData? prefixIcon,
  IconData? suffixIxIcon,
  String? label,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
})=>TextFormField(
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
    suffixIcon: suffixIxIcon != null ?IconButton(
        onPressed: suffixPressed,
        icon: Icon(Icons.visibility_off_sharp)):null,
  ),
);

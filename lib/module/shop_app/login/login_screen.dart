import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
var formKey = GlobalKey<FormState>();

var emailController = TextEditingController();

   var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        child: Form(
          key: formKey ,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 65,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.alternate_email),
                   labelText: "email",

                 ),
                  onFieldSubmitted: ( String value){},
                  onChanged: (String value){},
                  validator: (value){

                   if(value!.isEmpty){
                     return "email is required";
                   }
                   return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(


                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  onFieldSubmitted: ( String value){},
                  onChanged: (String value){},
                  validator: (value){
                    if(value!.isEmpty){
                      return "password is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    labelText: "password",
                    suffixIcon: Icon(Icons.visibility_off_sharp),
                  ),

                ),
                SizedBox(
                  height: 30,
                ),
                buildDefaultButton(
                  text: "login",
                  function: (){
                    formKey.currentState!.validate();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                buildDefaultButton(
                  text: "register",
                  function: (){

                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Don\,t have an account ? "),
                    Text("Register Now" ,style: TextStyle( color: Colors.blue),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/social_app/social_layout.dart';
import 'package:flutter_udemy_course/module/social_app/social_login/social_login_cubit/shop_login_cubit.dart';
import 'package:flutter_udemy_course/module/social_app/social_login/social_login_cubit/shop_login_states.dart';
import 'package:flutter_udemy_course/module/social_app/social_register/social_register_screen.dart';
import 'package:flutter_udemy_course/shared/network/local/cache_helper.dart';

import '../../../shared/component/component.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.SUCCESS);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.setData(key: 'uId', value: state.uId).then((value) {
              navigateAndReplace(context, SocialLayOut());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Form(
                key: formKey,
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
                      SizedBox(
                        height: 65,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          labelText: "email",
                        ),
                        onFieldSubmitted: (String value) {},
                        onChanged: (String value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
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
                        onFieldSubmitted: (String value) {},
                        onChanged: (String value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
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
                        function: () {
                          SocialLoginCubit.get(context).socialLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text("Don\,t have an account ? "),
                          GestureDetector(
                              onTap: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text(
                                "Register Now",
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

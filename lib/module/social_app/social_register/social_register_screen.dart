import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/social_app/social_layout.dart';
import 'package:flutter_udemy_course/module/social_app/social_register/social_register_cubit/social_register_cubit.dart';
import 'package:flutter_udemy_course/module/social_app/social_register/social_register_cubit/social_register_states.dart';

import '../../../shared/component/component.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateSuccessState) {
            navigateAndReplace(context, SocialLayOut());
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
                        "Register",
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
                          prefixIcon: Icon(Icons.password_outlined),
                          labelText: "password",
                          suffixIcon: Icon(Icons.visibility_off_sharp),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "name",
                        ),
                        onFieldSubmitted: (String value) {},
                        onChanged: (String value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "name is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: "phone number",
                        ),
                        onFieldSubmitted: (String value) {},
                        onChanged: (String value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "phone number is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        condition: state is! SocialRegisterLoadingState,
                        builder: (context) => buildDefaultButton(
                          text: "register",
                          function: () {
                            if (formKey.currentState!.validate()) {
                              SocialRegisterCubit.get(context).socialRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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

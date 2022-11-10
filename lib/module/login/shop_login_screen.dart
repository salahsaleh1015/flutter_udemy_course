import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/layout/shop_app/shop_layout/shop_layout.dart';
import 'package:flutter_udemy_course/module/login/shop_login_cubit/shop_login_cubit.dart';
import 'package:flutter_udemy_course/module/login/shop_login_cubit/shop_login_states.dart';
import 'package:flutter_udemy_course/shared/component/component.dart';
import 'package:flutter_udemy_course/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.shopLoginModel.status) {
              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data.token);
              // Fluttertoast.showToast(
              //     msg: state.shopLoginModel.message,
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 1,
              //     backgroundColor: Colors.green,
              //     textColor: Colors.white,
              //     fontSize: 16.0
              // );
              CacheHelper.setData(
                      key: "token", value: state.shopLoginModel.data.token)
                  .then((value) {
                navigateAndReplace(context, ShopLayOut());
              });
            } else {
              print(state.shopLoginModel.message);
              // Fluttertoast.showToast(
              //     msg: state.shopLoginModel.message,
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 1,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0
              // );
              showToast(
                  text: state.shopLoginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                buildTextButton(
                  function: () {},
                  text: "register".toUpperCase(),
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Login to Brows our hot offers ",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          label: "email",
                          prefixIcon: Icons.email,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          onChanged: (value) {},
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "please enter your email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          prefixIcon: Icons.password,
                          suffixIxIcon: Icons.visibility,
                          label: "password",
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          onChanged: (value) {},
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "password is to short";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => buildDefaultButton(
                              text: "Login",
                              width: double.infinity,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).shopLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text("i don\'t have an account"),
                            SizedBox(
                              width: 5,
                            ),
                            buildTextButton(
                              function: () {},
                              text: "register".toUpperCase(),
                            ),
                          ],
                        )
                      ],
                    ),
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

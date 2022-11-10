import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/model/shop_app/shop_login_model.dart';
import 'package:flutter_udemy_course/module/login/shop_login_cubit/shop_login_states.dart';
import 'package:flutter_udemy_course/shared/network/remote/dio_helper.dart';

import '../../../shared/network/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopLoginModel;

  //=====================================================================
  void shopLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) {
      print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      print(shopLoginModel!.data.token);
      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((error) {
      print("//==============================");
      print(error.toString());
      print("//==============================");
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}

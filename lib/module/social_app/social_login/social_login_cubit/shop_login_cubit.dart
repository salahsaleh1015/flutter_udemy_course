import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/module/social_app/social_login/social_login_cubit/shop_login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void socialLogin({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user);
      print("////////=======================");

      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }
}

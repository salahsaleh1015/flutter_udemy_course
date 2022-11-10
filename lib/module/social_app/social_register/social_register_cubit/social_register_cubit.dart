import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy_course/model/social_app/social_user_model.dart';
import 'package:flutter_udemy_course/module/social_app/social_register/social_register_cubit/social_register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void socialRegister(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user);
      print(value.user!.uid);
      socialCreate(
        name: name,
        phone: phone,
        email: email,
        uId: value.user!.uid,
      );
      // emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print("kkkkkkkkkkkkkkkkkkkk");
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void socialCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
    bool? isEmailVerified,
    // required String image,
    // required String bio,
    // required String cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      // image:image,
      // bio: bio,
      // cover: cover,
      //
      // isEmailVerified: isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateSuccessState());
    }).catchError((error) {
      print("lllllllllllllllllll");
      print(error.toString());
      emit(SocialCreateErrorState(error));
    });
  }
}

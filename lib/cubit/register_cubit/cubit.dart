import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/register_cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/component.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(SocialInitState());

  static RegisterCubit getCubit(context) => BlocProvider.of(context);

  register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(email: email, name: name, phone: phone, uid: value.user!.uid);
      toast(message: value.user!.uid.toString(), data: ToastStates.success);
    }).catchError((error) {
      emit(SocialRegisterErrorState());
      toast(message: error.toString(), data: ToastStates.error);
    });
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uid,
  }) {
    UserModel model =
        UserModel(name: name, email: email, phone: phone, image: '');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(model.toMap()!)
        .then((value) {
      emit(SocialCreateUserSuccessState(uid));
    }).catchError((e) {
      emit(SocialCreateUserErrorState());
    });
  }

  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(SocialRegisterPasswordState());
  }
}

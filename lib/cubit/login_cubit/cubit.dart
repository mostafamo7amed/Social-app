import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/login_cubit/states.dart';

import '../../shared/components/component.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(SocialInitState());

  static LoginCubit getCubit(context) => BlocProvider.of(context);
  shopLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
      toast(message: value.user!.uid.toString(), data: ToastStates.success);
    }).catchError((error) {
      emit(SocialLoginErrorState());
      toast(message: error.toString(), data: ToastStates.error);
    });
  }

  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(SocialLoginPasswordState());
  }
}

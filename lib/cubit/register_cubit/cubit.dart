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
    String image ='https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1664964381~exp=1664964981~hmac=9959189edadcf63760040449df60e6c6bf10f9b0115341bf117a5b7ca83ee347',
    String bio = 'Hi I\'m using socialApp',
    String cover ='https://img.freepik.com/free-photo/vegetables-set-left-black-slate_1220-685.jpg?w=900&t=st=1665313797~exp=1665314397~hmac=a87c3b36b1c57e345a3f5fad35d9f74a1d59d53191d883cfed7cbb9b87ad6724',
  }) {
    UserModel model =
        UserModel(
            name: name,
            email: email,
            phone: phone,
            image: image,
            bio: bio,
            cover: cover,
            uid: uid,
        );
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

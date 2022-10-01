import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/component.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit getCubit(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUser() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
      print(userModel!.name);
      emit(SocialGetUserSuccessState(uid));
    }).catchError((e) {
      emit(SocialGetUserErrorState());
    });
  }
}

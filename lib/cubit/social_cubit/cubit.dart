import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/new_post_screen/new_post_screen.dart';
import 'package:social_app/shared/components/component.dart';
import '../../modules/chats_screen/chats_screen.dart';
import '../../modules/feeds_screen/feeds_screen.dart';
import '../../modules/settings_screen/settings_screen.dart';
import '../../modules/users_screen/users_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit getCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'new Post',
    'Location',
    'Settings',
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(SocialBottomNavState());
  }

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

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SocialPikImageSuccessState());
    } else {
      print('no image selected');
      emit(SocialPikImageErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      uploadCoverImage();
      emit(SocialPikCoverSuccessState());
    } else {
      print('no image selected');
      emit(SocialPikCoverErrorState());
    }
  }

  String imageUri = '';
  uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        imageUri = value;
        emit(SocialUploadImageSuccessState());
      }).catchError((e) {
        emit(SocialUploadImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadImageErrorState());
      print(error.toString());
    });
  }

  String coverUri = '';
  uploadCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverUri = value;
        emit(SocialUploadCoverSuccessState());
      }).catchError((e) {
        emit(SocialUploadCoverErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverErrorState());
      print(error.toString());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {

    UserModel model = UserModel(
        name: name,
        email: userModel!.email,
        phone: phone,
        image: image ??= userModel!.image,
        bio: bio,
        cover: cover ??= userModel!.cover,
        uid: uid);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .update(model.toMap()!)
        .then((value) {
      emit(SocialUpdateUserSuccessState());
    }).catchError((e) {
      emit(SocialUpdateUserErrorState());
    });
  }

  void updateUsersProfile({
    required String name,
    required String phone,
    required String bio,
  }) {
    if (coverImage!=null) {
      updateUser(name: name, phone: phone, bio: bio, cover: coverUri);
    } else if (profileImage!=null) {
      updateUser(name: name, phone: phone, bio: bio, image: imageUri);
    } else if (coverImage==null && profileImage==null) {
      updateUser(name: name, phone: phone, bio: bio);
    } else if (coverImage!=null && profileImage!=null) {
      updateUser(
          name: name, phone: phone, bio: bio, cover: coverUri, image: imageUri);
    }
    getUser();
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/new_post_screen/new_post_screen.dart';
import '../../models/message_model.dart';
import '../../models/post_model.dart';
import '../../modules/chats_screen/chats_screen.dart';
import '../../modules/feeds_screen/feeds_screen.dart';
import '../../modules/settings_screen/settings_screen.dart';
import '../../modules/users_screen/users_screen.dart';
import '../../shared/network/local/cache_helper.dart';

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
    if (index == 1) {
      getAllUsers();
    }
    currentIndex = index;
    emit(SocialBottomNavState());
  }

  UserModel? userModel;
  void getUser() {
    String uid = CacheHelper.getData(key: 'uid');
    emit(SocialGetUserLoadingState());
    print('errrrrrrrrrrrrrrrrrrrr' + CacheHelper.getData(key: 'uid'));
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
        uid: userModel!.uid);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uid)
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
    if (coverImage != null) {
      updateUser(name: name, phone: phone, bio: bio, cover: coverUri);
    } else if (profileImage != null) {
      updateUser(name: name, phone: phone, bio: bio, image: imageUri);
    } else if (coverImage == null && profileImage == null) {
      updateUser(name: name, phone: phone, bio: bio);
    } else if (coverImage != null && profileImage != null) {
      updateUser(
          name: name, phone: phone, bio: bio, cover: coverUri, image: imageUri);
    }
    getUser();
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPikPostSuccessState());
    } else {
      print('no image selected');
      emit(SocialPikPostErrorState());
    }
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
        name: userModel!.name,
        image: userModel!.image,
        uid: userModel!.uid,
        dateTime: dateTime,
        postImage: postImage ?? '',
        text: text);
    FirebaseFirestore.instance
        .collection('Posts')
        .add(model.toMap()!)
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((e) {
      emit(SocialCreatePostErrorState());
    });
  }

  String postUri = '';
  uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialUploadPostImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(text: text, dateTime: dateTime, postImage: value);
        emit(SocialUploadPostImageSuccessState());
      }).catchError((e) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadImageErrorState());
      print(error.toString());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemoveImageState());
  }

  void removeMessageImage() {
    messageImage = null;
    emit(SocialRemoveImageState());
  }

  List<PostModel> posts = [];
  List<int> comment = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('Posts').orderBy('dateTime').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('Likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromMap(element.data()));
          emit(SocialGetPostSuccessState());
        }).catchError((e) {
          emit(SocialGetPostErrorState());
        });
      }
      emit(SocialGetPostSuccessState());
    }).catchError((e) {
      emit(SocialGetPostErrorState());
    });
  }

  void getComments() {
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('Comments').get().then((value) {
          comment.add(value.docs.length);
          emit(SocialGetPostSuccessState());
        });
      }
      emit(SocialGetPostSuccessState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((e) {
      emit(SocialLikePostErrorState());
    });
  }

  void commentPost(String postId, String text) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .doc(userModel!.uid)
        .set({
      'comment': text,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((e) {
      emit(SocialCommentPostErrorState());
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    users = [];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      for (var element in value.docs) {
        // !=
        if (element.reference.id != userModel!.uid) {
          users.add(UserModel.fromMap(element.data()));
        }
      }
      emit(SocialGetAllUsersSuccessState());
    }).catchError((e) {
      emit(SocialGetAllUsersErrorState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
    String image = '',
  }) {
    MessageModel messageModel = MessageModel(
      dateTime: dateTime,
      receiver: receiverId,
      sender: userModel!.uid,
      text: text,
      image: image,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uid)
        .collection('Chats')
        .doc(receiverId)
        .collection('Messages')
        .add(messageModel.toMap()!)
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((e) {
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('Chats')
        .doc(userModel!.uid)
        .collection('Messages')
        .add(messageModel.toMap()!)
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((e) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uid)
        .collection('Chats')
        .doc(receiverId)
        .collection('Messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromMap(element.data()));
      }
      emit(SocialGetMessageSuccessState());
    });
  }



  File? messageImage;
  Future<void> getMessageImage({
    required String receiverId,
    required String dateTime,
  }) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      uploadMessageImage(dateTime: dateTime,receiverId: receiverId,);
      emit(SocialPikImageSuccessState());
    } else {
      print('no image selected');
      emit(SocialPikImageErrorState());
    }
  }
  uploadMessageImage(
      {
        required String receiverId,
        required String dateTime,
      }
      ) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(receiverId: receiverId, text: 'image', dateTime: dateTime,image:value);
        emit(SocialMessageImageSuccessState());
      }).catchError((e) {
        emit(SocialMessageImageErrorState());
      });
    }).catchError((error) {
      emit(SocialMessageImageErrorState());
      print(error.toString());
    });
  }

}

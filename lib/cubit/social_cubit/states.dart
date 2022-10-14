
abstract class SocialStates {}

class SocialInitState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {
  String uid;
  SocialGetUserSuccessState(this.uid);
}
class SocialGetUserLoadingState extends SocialStates {}
class SocialGetUserErrorState extends SocialStates {}

class SocialLoginPasswordState extends SocialStates {}

class SocialBottomNavState extends SocialStates {}

class SocialNavNewPostState extends SocialStates {}

class SocialPikImageSuccessState extends SocialStates {}
class SocialPikImageErrorState extends SocialStates {}

class SocialPikCoverSuccessState extends SocialStates {}
class SocialPikCoverErrorState extends SocialStates {}

class SocialUploadImageSuccessState extends SocialStates {}
class SocialUploadImageErrorState extends SocialStates {}

class SocialUploadCoverSuccessState extends SocialStates {}
class SocialUploadCoverErrorState extends SocialStates {}

class SocialUpdateUserSuccessState extends SocialStates {}
class SocialUpdateUserErrorState extends SocialStates {}
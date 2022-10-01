
abstract class SocialStates {}

class SocialInitState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {
  String uid;
  SocialGetUserSuccessState(this.uid);
}
class SocialGetUserLoadingState extends SocialStates {}
class SocialGetUserErrorState extends SocialStates {}

class SocialLoginPasswordState extends SocialStates {}

abstract class RegisterStates {}

class SocialInitState extends RegisterStates {}

class SocialRegisterSuccessState extends RegisterStates {}
class SocialRegisterLoadingState extends RegisterStates {}
class SocialRegisterErrorState extends RegisterStates {}
class SocialCreateUserSuccessState extends RegisterStates {
  String uid;
  SocialCreateUserSuccessState(this.uid);
}
class SocialCreateUserErrorState extends RegisterStates {}

class SocialRegisterPasswordState extends RegisterStates {}
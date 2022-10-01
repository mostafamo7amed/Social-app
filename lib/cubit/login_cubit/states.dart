
abstract class LoginStates {}

class SocialInitState extends LoginStates {}

class SocialLoginSuccessState extends LoginStates {
  String uid;
  SocialLoginSuccessState(this.uid);
}
class SocialLoginSuccessErrorState extends LoginStates {
}
class SocialLoginLoadingState extends LoginStates {}
class SocialLoginErrorState extends LoginStates {}

class SocialLoginPasswordState extends LoginStates {}
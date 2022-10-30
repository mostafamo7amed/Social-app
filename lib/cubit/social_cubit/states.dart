
abstract class SocialStates {}

class SocialInitState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {
  String uid;
  SocialGetUserSuccessState(this.uid);
}
class SocialGetUserLoadingState extends SocialStates {}
class SocialGetUserErrorState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}
class SocialGetPostLoadingState extends SocialStates {}
class SocialGetPostErrorState extends SocialStates {}

class SocialLoginPasswordState extends SocialStates {}

class SocialBottomNavState extends SocialStates {}

class SocialNavNewPostState extends SocialStates {}

class SocialPikImageSuccessState extends SocialStates {}
class SocialPikImageErrorState extends SocialStates {}

class SocialLikePostSuccessState extends SocialStates {}
class SocialLikePostErrorState extends SocialStates {}

class SocialCommentPostSuccessState extends SocialStates {}
class SocialCommentPostErrorState extends SocialStates {}

class SocialPikCoverSuccessState extends SocialStates {}
class SocialPikCoverErrorState extends SocialStates {}

class SocialPikPostSuccessState extends SocialStates {}
class SocialPikPostErrorState extends SocialStates {}

class SocialUploadImageSuccessState extends SocialStates {}
class SocialUploadImageErrorState extends SocialStates {}

class SocialUploadPostImageLoadingState extends SocialStates {}
class SocialUploadPostImageSuccessState extends SocialStates {}
class SocialUploadPostImageErrorState extends SocialStates {}

class SocialUploadCoverSuccessState extends SocialStates {}
class SocialUploadCoverErrorState extends SocialStates {}

class SocialUpdateUserSuccessState extends SocialStates {}
class SocialUpdateUserErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}
class SocialCreatePostErrorState extends SocialStates {}
class SocialCreatePostSuccessState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialIncreaseLikesState extends SocialStates {}


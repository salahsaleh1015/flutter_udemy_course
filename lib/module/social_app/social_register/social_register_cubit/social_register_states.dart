abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialCreateErrorState extends SocialRegisterStates {
  final String error;

  SocialCreateErrorState(this.error);
}

class SocialCreateSuccessState extends SocialRegisterStates {}

abstract class NewsAppStates {}

class NewsAppInitialState extends NewsAppStates {}

class NewsAppChangeBottomNavigationBarState extends NewsAppStates {}

//==================================================================
class NewsGetBusinessDataSuccessState extends NewsAppStates {}

class NewsGetBusinessDataErrorState extends NewsAppStates {
  final String error;

  NewsGetBusinessDataErrorState(this.error);
}

class NewsGetBusinessLoadingState extends NewsAppStates {}

//==================================================================
class NewsGetSportsDataSuccessState extends NewsAppStates {}

class NewsGetSportsDataErrorState extends NewsAppStates {
  final String error;

  NewsGetSportsDataErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsAppStates {}

//=============================================================
class NewsGetScienceDataSuccessState extends NewsAppStates {}

class NewsGetScienceDataErrorState extends NewsAppStates {
  final String error;

  NewsGetScienceDataErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsAppStates {}

//=========================================================================
class NewsGetSearchDataSuccessState extends NewsAppStates {}

class NewsGetSearchDataErrorState extends NewsAppStates {
  final String error;

  NewsGetSearchDataErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsAppStates {}

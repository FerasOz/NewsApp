part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

class NewsInitialStates extends NewsState{}

class NewsBottomNAvBarStates extends NewsState{}

class NewsSelectBusinessItemStates extends NewsState{}

class NewsSetDesktopStates extends NewsState{}

class NewsGetBusinessLoadingStates extends NewsState{}

class NewsGetBusinessSuccessStates extends NewsState{}

class NewsGetBusinessErrorStates extends NewsState{

  final error;

  NewsGetBusinessErrorStates(this.error);
}

class NewsGetSportsLoadingStates extends NewsState{}

class NewsGetSportsSuccessStates extends NewsState{}

class NewsGetSportsErrorStates extends NewsState{

  final error;

  NewsGetSportsErrorStates(this.error);
}

class NewsGetScienceLoadingStates extends NewsState{}

class NewsGetScienceSuccessStates extends NewsState{}

class NewsGetScienceErrorStates extends NewsState{

  final error;

  NewsGetScienceErrorStates(this.error);
}

class NewsGetSearchLoadingStates extends NewsState{}

class NewsGetSearchSuccessStates extends NewsState{}

class NewsGetSearchErrorStates extends NewsState{

  final error;

  NewsGetSearchErrorStates(this.error);
}

class AppChangeThemeModeState extends NewsState{}

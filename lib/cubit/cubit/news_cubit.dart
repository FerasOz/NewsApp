import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/helpers/cache_helper.dart';
import 'package:news_app/helpers/dio_helper.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/sports_screen.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "business",
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "sports"),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: "science",
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: "settings",
    // ),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }

    emit(NewsBottomNAvBarStates());
  }

  List<dynamic> business = [];
  int currentIndexBusiness = 0;
  bool isDesktop = false;

  void setDesktop(bool value) {
    isDesktop = value;
    emit(NewsSetDesktopStates());
  }

  void selectedBusinessItem(int index) {
    currentIndexBusiness = index;
    emit(NewsSelectBusinessItemStates());
  }

  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'business',
            'apiKey': '54b4ea2fd14c49ac9af5370f571ce3c0',
          },
        )
        .then((value) {
          business = value.data['articles'];
          print(business[0]['title']);
          emit(NewsGetBusinessSuccessStates());
        })
        .catchError((error) {
          print(error.toString());
          emit(NewsGetBusinessErrorStates(error.toString()));
        });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingStates());

    if (sports.isEmpty) {
      DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country': 'us',
              'category': 'sports',
              'apiKey': '54b4ea2fd14c49ac9af5370f571ce3c0',
            },
          )
          .then((value) {
            sports = value.data['articles'];
            print(sports[0]['title']);
            emit(NewsGetSportsSuccessStates());
          })
          .catchError((error) {
            print(error.toString());
            emit(NewsGetSportsErrorStates(error.toString()));
          });
    } else {
      emit(NewsGetSportsSuccessStates());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingStates());

    if (science.isEmpty) {
      DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country': 'us',
              'category': 'science',
              'apiKey': '54b4ea2fd14c49ac9af5370f571ce3c0',
            },
          )
          .then((value) {
            science = value.data['articles'];
            print(science[0]['title']);
            emit(NewsGetScienceSuccessStates());
          })
          .catchError((error) {
            print(error.toString());
            emit(NewsGetScienceErrorStates(error.toString()));
          });
    } else {
      emit(NewsGetScienceSuccessStates());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingStates());

    DioHelper.getData(
          url: 'v2/everything',
          query: {'q': value, 'apiKey': '54b4ea2fd14c49ac9af5370f571ce3c0'},
        )
        .then((value) {
          search = value.data['articles'];
          print(search[0]['title']);
          emit(NewsGetSearchSuccessStates());
        })
        .catchError((error) {
          print(error.toString());
          emit(NewsGetSearchErrorStates(error.toString()));
        });
  }

  bool isDark = false;

  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeModeState());
      });
    }
  }
}

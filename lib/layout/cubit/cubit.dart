// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class BNBCubit extends Cubit <BNBStates>{
  BNBCubit ():super(InitialState());
  static BNBCubit getObject(context) =>BlocProvider.of(context);
  int current = 0 ;
  bool isLight =false;
  ThemeMode themeData = ThemeMode.light ;
  List<dynamic> business =[];
  List<dynamic> sports =[];
  List<dynamic> science =[];
  List<dynamic> search =[];
  List<Widget> screens = const[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<String> titles = const[
    "Business Screen",
    "Sports Screen",
    "Science Screen",
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItems =const [
    BottomNavigationBarItem(
      label: "Business",
      icon: Icon(
        Icons.business,
        size:35 ,
      ),
    ),
    BottomNavigationBarItem(
      label: "Sports",
      icon: Icon(
        Icons.sports,
        size:35 ,
      ),
    ),
    BottomNavigationBarItem(
      label: "Science",
      icon: Icon(
        Icons.science,
        size:35 ,
      ),
    ),
  ];
  void changeCurrent (int index){
    current = index ;
    emit(ChangeBNBState());
  }
  void changeLight ({bool? fromShared}){
    if(fromShared!=null){
      isLight =fromShared;
      emit(ChangeLightState());
    }else{
      isLight =!isLight;
      CashHelper.setPool(key: "key", value: isLight).then((value){
        emit(ChangeLightState());
      });
    }
  }
  void getBusiness(){
    emit(LoadingStates());
    DioHelper.getData(
        url: "v2/top-headlines",
        queryParameters: {
          "country":"eg",
          "category":"business",
          "apiKey":"b279858c8f624136aa7d2bfb33e01903",
        }).then((value) {
      business = value.data["articles"];
      print(business[0]["title"]);
      emit(GetBusinessSuccess());
    }
    ).catchError((onError){
      emit(GetBusinessError(onError.toString()));
      print(onError.toString());
    }
    );

  }
  void getSorts(){
    emit(LoadingStates());
    DioHelper.getData(
        url: "v2/top-headlines",
        queryParameters: {
          "country":"eg",
          "category":"sports",
          "apiKey":"b279858c8f624136aa7d2bfb33e01903",
        }).then((value) {
      sports = value.data["articles"];
      print(sports[0]["title"]);
      emit(GetSportsSuccess());
    }
    ).catchError((onError){
      emit(GetSportsError(onError.toString()));
      print(onError.toString());
    }
    );

  }
  void getScience(){
    emit(LoadingStates());
    DioHelper.getData(
        url: "v2/top-headlines",
        queryParameters: {
          "country":"eg",
          "category":"science",
          "apiKey":"b279858c8f624136aa7d2bfb33e01903",
        }).then((value) {
      science = value.data["articles"];
      print(science[0]["title"]);
      emit(GetScienceSuccess());
    }
    ).catchError((onError){
      emit(GetScienceError(onError.toString()));
      print(onError.toString());
    }
    );

  }
  void getSearch( String value){
    emit(LoadingStates());
    search=[];
    DioHelper.getData(
        url: "v2/everything",
        queryParameters: {
          "q":value,
          "apiKey":"b279858c8f624136aa7d2bfb33e01903",
        }).then((value) {
      search = value.data["articles"];
      print(search[0]["title"]);
      emit(GetSearchSuccess());
    }
    ).catchError((onError){
      emit(GetSearchError(onError.toString()));
      print(onError.toString());
    }
    );

  }
}
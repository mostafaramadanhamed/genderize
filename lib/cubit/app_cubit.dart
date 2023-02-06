import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/cubit/app_states.dart';

import '../data/service/dio.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());


  getData({required String name}){
    emit(AppLoadingState());
    try {
      emit(AppSuccessState());
      DioHelper().getData(name: name);
    }
    catch(ex){
      emit(AppErrorState());
      debugPrint(ex.toString());
    }
  }

}
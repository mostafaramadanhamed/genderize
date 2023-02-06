import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/cubit/app_states.dart';
import 'package:genderize/data/model/data_model.dart';

import '../data/service/dio.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

 late Map<String,dynamic> data ;
  GenderModel ?  gender;

  Future<Map<String, dynamic>>  getData({required String name})async{
    emit(AppLoadingState());


     await DioHelper().getData(name: name).then((value) {
       emit(AppSuccessState());
       data=value;
       GenderModel.fromJson(data);
     }).catchError((error){
       emit(AppErrorState());
       //return {error};

     });
     return data;
   //    then((val){
   // //    GenderModel(count: val['count'], gender: val['gender'], name: val['name'], probability: val['probability']);
   //
   //    });
  }

}
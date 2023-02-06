import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constant/cons_string.dart';

class DioHelper{

 late Dio dio;
 DioHelper(){
   BaseOptions baseOptions=BaseOptions(
     baseUrl: MyStrings.baseUrl,
     receiveTimeout: 15*1000,
     sendTimeout: 15*1000,
     receiveDataWhenStatusError: true,
   );
   dio=Dio(baseOptions);
 }
 getData({required String name})async{
   try{

     Response response=await dio.get(name);
     return response.data;
   }
   catch(ex){
     debugPrint('Error in $ex');
   }
 }
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:genderize/data/model/data_model.dart';

import '../../constant/cons_string.dart';

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
 Future<Map<String, dynamic>> getData({required String name})async{
   try{

     Response response=await dio.get(
       MyStrings.getUrl,
       queryParameters: {
         'name':name,
       }
     );
   GenderModel gender=GenderModel.fromJson(response.data);
     debugPrint(response.data.toString());

     return response.data;
   }
   catch(ex){
     debugPrint('Error in $ex');
     return {};
   }

 }
}
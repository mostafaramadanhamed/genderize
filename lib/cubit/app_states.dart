import 'package:genderize/data/model/data_model.dart';

abstract class AppStates{}
class AppInitialState extends AppStates{}
class AppLoadingState extends AppStates{}
class AppSuccessState extends AppStates{
  final Map<String,dynamic>gender;

  AppSuccessState(this.gender);

}
class AppErrorState extends AppStates{}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/cubit/app_cubit.dart';
import 'package:genderize/view/home_screen.dart';

import 'cubit/bloc_observer.dart';

void main() {
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:BlocProvider(
          create: (context)=>AppCubit(),
          child: HomeScreen()),
    );
  }
}

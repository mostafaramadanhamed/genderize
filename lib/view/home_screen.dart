import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genderize/cubit/app_cubit.dart';
import 'package:genderize/cubit/app_states.dart';
import 'package:genderize/data/model/data_model.dart';
import 'package:genderize/view/widget/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey =GlobalKey();
  // GenderModel  gender;
  AutovalidateMode autovalidateMode=AutovalidateMode.disabled;
bool isClick=false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit(),
      child: Scaffold(
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/5,
                    width: MediaQuery.of(context).size.width,
                  ),
                  CustomTextFiled(hint: 'Search 🔎',
                    onSubmit: (va){
                      // add function
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        AppCubit().getData(name: va);
                        isClick= !isClick;
                        setState((){});
                      }
                      else{
                        autovalidateMode=AutovalidateMode.always;
                        setState((){});
                      }
                    },),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/10,
                  ),
            BlocBuilder<AppCubit,AppStates> (
              builder: (context,state){
                return isClick?        Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all( 24),
                  height:MediaQuery.of(context).size.height/5 ,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.pink.shade200,
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Name:  gender.name'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/20,
                      ),
                      Row(
                        children:const [

                          Expanded(child: Text('Gender: gender.Gender')),
                          Expanded(child:  Text('Probability')),
                        ],
                      ),

                    ],
                  ),
                ):Container();
              }
            ),
                ],
              ),
            ),),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Gender',style: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
    );
  }
}

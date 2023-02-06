import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:genderize/cubit/app_cubit.dart';
import 'package:genderize/cubit/app_states.dart';
import 'package:genderize/view/widget/custom_text_field.dart';

import '../constant/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey =GlobalKey();
  final TextEditingController controller=TextEditingController();
  // GenderModel  gender;
  Map<String,dynamic>gender={};
  AutovalidateMode autovalidateMode=AutovalidateMode.disabled;
bool isClick=false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
      if(state is AppSuccessState)
        this.gender=state.gender;
    },
      builder: (context,state){
    return  OfflineBuilder(
        connectivityBuilder: (
    BuildContext context,
           ConnectivityResult connectivity,
    Widget child,
    )
    {
    final bool connected = connectivity != ConnectivityResult.none;
    if(connected){
    return Scaffold(
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
    controller: controller,
    onSubmit: (va)async{
    // add function
    if(formKey.currentState!.validate()){
    formKey.currentState!.save();
    BlocProvider.of<AppCubit>(context).getData(name: va);
    await Future.delayed(const Duration(seconds: 2));
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
    if(state is AppLoadingState)const CircularProgressIndicator(color: Colors.blueAccent,),
    if(isClick)buildDetailsContainer(context),
    isClick? buildElevatedButton():Container(),

    ],
    ),
    ),),
    );
    }
    else{
      return Scaffold(
      body:  buildNoInternetWidget(context),
      );
    }
    },
      child:const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),),
    );
    }
    );

  }

  Widget buildNoInternetWidget(context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/15,
          ),
          Image.asset(MyImages.noInternet,
            height:MediaQuery.of(context).size.height/2 ,
            width: MediaQuery.of(context).size.width,),
          Text(
            ' Can\'t connect.. check your internet',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width/20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
                    onPressed: (){
                      controller.clear();
                      isClick= !isClick;
                      setState((){});
                    },
                    child: const Icon(Icons.rotate_right));
  }

  Container buildDetailsContainer(BuildContext context) {
    return Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all( 24),
                          height:MediaQuery.of(context).size.height/4 ,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${gender['name']}',style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),),
                              SizedBox(
                                height: MediaQuery.of(context).size.height/40,
                              ),
                              Text('Gender: ${gender['gender']}',style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),),
                              SizedBox(
                                height: MediaQuery.of(context).size.height/30,
                              ),
                              Text('Probability: ${gender['probability']}',style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),),

                            ],
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

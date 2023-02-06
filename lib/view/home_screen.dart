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
                    onSubmit: (va){
                      // add function
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        BlocProvider.of<AppCubit>(context).getData(name: va);
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

                        //  print(gender['name']);
                        isClick?  Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all( 24),
                            height:MediaQuery.of(context).size.height/4 ,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.pink.shade200,
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
                          ):Container(),
                  ElevatedButton(
                      onPressed: (){
                        controller.clear();
                        isClick= !isClick;
                        setState((){});
                      },
                      child: Icon(Icons.rotate_right))

                ],
              ),
            ),),
        );
      },

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

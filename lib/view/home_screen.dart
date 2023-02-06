import 'package:flutter/material.dart';
import 'package:genderize/cubit/app_cubit.dart';
import 'package:genderize/view/widget/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey =GlobalKey();

  AutovalidateMode autovalidateMode=AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
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
                onSubmit: (va){
                // add function
                  if(formKey.currentState!.validate()){
                    formKey.currentState!.save();
                    AppCubit().getData(name: va);

                  }
                  else{
                    autovalidateMode=AutovalidateMode.always;
                    setState((){});
                  }
              },),
              SizedBox(
                height: MediaQuery.of(context).size.height/10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all( 24),
                height:MediaQuery.of(context).size.height/3 ,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Name:'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/20,
                    ),
                    Row(
                      children:const [

                         Expanded(child: Text('Gender:')),
                         Expanded(child:  Text('Probability')),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
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

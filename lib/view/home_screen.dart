import 'package:flutter/material.dart';
import 'package:genderize/view/widget/custom_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width,
          ),
          CustomTextFiled(hint: 'Search 🔎',
            onSubmit: (va){
            // add function
          },)
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
